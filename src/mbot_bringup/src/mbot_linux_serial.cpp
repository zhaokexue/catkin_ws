#include "mbot_linux_serial.h"

using namespace std;
using namespace boost::asio;
//串口相关对象
boost::asio::io_service iosev;
boost::asio::serial_port sp(iosev, "/dev/mbot");
boost::system::error_code err;
/********************************************************
            串口发送接收相关常量、变量、共用体对象
********************************************************/
const unsigned char ender[2] = {0x0d, 0x0a};
const unsigned char header[2] = {0x55, 0xaa};
const int SPEED_INFO = 0xa55a; 
const int GET_SPEED  = 0xaaaa;

union sendData
{
    int d;
    unsigned char data[4];
}leftdata, rightdata;

union checkSum
{
    short d;
    unsigned char data[1];
}SendCheckSum, ReceiveCheckSum;

union receiveHeader
{
    int d;
    unsigned char data[2];
}receive_command, receive_header;

union sendCommand
{
    int d;
    unsigned char data[2];
}send_command;

union odometry
{
    float odoemtry_float;
    unsigned char odometry_char[4];
}vel_left, vel_right,angle;

const double ROBOT_LENGTH = 157.00; //mm
const double ROBOT_RADIUS = 78.50;  //两轮之间的半径长度mm
/********************************************************
函数功能：串口参数初始化
入口参数：无
出口参数：
********************************************************/
void serialInit()
{
    sp.set_option(serial_port::baud_rate(115200));
    sp.set_option(serial_port::flow_control(serial_port::flow_control::none));
    sp.set_option(serial_port::parity(serial_port::parity::none));
    sp.set_option(serial_port::stop_bits(serial_port::stop_bits::one));
    sp.set_option(serial_port::character_size(8));    
}
/********************************************************
函数功能：将机器人的线速度和角速度分解成左右轮子速度，打包发送给下位机
入口参数：机器人线速度、角速度
出口参数：
********************************************************/
void writeSpeed(double RobotV, double YawRate)
{
    unsigned char buf[16] = {0};
    int i, length = 0;
    double r = RobotV / YawRate;//mm

    // 计算左右轮期望速度
    if(RobotV == 0)      //旋转
    {
        leftdata.d = -YawRate * ROBOT_RADIUS;//mm/s
        rightdata.d = YawRate * ROBOT_RADIUS;//mm/s
    } 
    else if(YawRate == 0)//直线
    {
        leftdata.d = RobotV;//mm/s
        rightdata.d = RobotV;
    }
    else                //速度不一致
    {
        leftdata.d  = YawRate * (r - ROBOT_RADIUS);//mm/s
        rightdata.d = YawRate * (r + ROBOT_RADIUS);
    }

    // 设置消息头
    for(i = 0; i < 2; i++)
        buf[i] = header[i];
    
    // 设置消息类型
    send_command.d = GET_SPEED;
    for(i = 0; i < 2; i++)
        buf[i + 2] = send_command.data[i];
    
    // 设置机器人左右轮速度
    length = 8;
    buf[4] = length;
    for(i = 0; i < 4; i++)
    {
        buf[i + 5] = leftdata.data[i];
        buf[i + 9] = rightdata.data[i];
    }
    
    // 设置校验值、消息尾
    buf[5 + length] = getCrc8(buf, 5 + length);
    buf[6 + length] = ender[0];
    buf[6 + length + 1] = ender[1];

    // 通过串口下发数据
    boost::asio::write(sp, boost::asio::buffer(buf));
}
/********************************************************
函数功能：从下位机读取数据，解析出线速度、角速度、角度
入口参数：机器人线速度、角速度、角度，引用参数
出口参数：bool
********************************************************/
bool readSpeed(double &vx,double &vth,double &th)
{
    int i, length = 0;
    unsigned char checkSum;
    unsigned char buf[200]={0};
    //=========================================================
    //此段代码可以读数据的结尾，进而来进行读取数据的头部
    try
    {
        boost::asio::streambuf response;
        boost::asio::read_until(sp, response, "\r\n",err);   
        copy(istream_iterator<unsigned char>(istream(&response)>>noskipws),
        istream_iterator<unsigned char>(),
        buf); 
    }  
    catch(boost::system::system_error &err)
    {
        ROS_INFO("read_until error");
    } 
    //=========================================================        

    for (i = 0; i < 2; i++)
        receive_header.data[i] = buf[i];

    // 检查信息头
    if (receive_header.data[0] != header[0] || receive_header.data[1] != header[1])
    {
        ROS_ERROR("Received message header error!");
        return false;
    }

    for (i = 0; i < 2; i++)
        receive_command.data[i] = buf[i + 2];
    
    length = buf[4];
    checkSum = getCrc8(buf, 5 + length);
    
    // 检查信息类型
    if(receive_command.d != SPEED_INFO)
    {
        ROS_ERROR("Received command error!");
        return false;
    }

    // 检查信息尾
    if (buf[6 + length] != ender[0] || buf[6 + length + 1] != ender[1])
    {
        ROS_ERROR("Received message header error!");
        return false;
    }
    
    // 检查信息校验值
    ReceiveCheckSum.data[0] = buf[5 + length];
    if (checkSum != ReceiveCheckSum.d)
    {
        ROS_ERROR("Received data check sum error!");
        return false;
    }

    // 读取速度值
    for(i = 0; i < 4; i++)
    {
        vel_left.odometry_char[i]  = buf[i + 5];
        vel_right.odometry_char[i] = buf[i + 9];
        angle.odometry_char[i]     = buf[i + 13];//存放时实角度信息
    }

    // 检查数据信息是否正确
    /*
    ROS_INFO("Left:%f\n",vel_left.odoemtry_float);
    ROS_INFO("Right:%f\n",vel_right.odoemtry_float);
    ROS_INFO("Angle:%f\n",angle.odoemtry_float);
    */
    //===========================速度计算和Angle获取===========================================================
    // x方向速度，以及角速度
    vx  = (vel_right.odoemtry_float + vel_left.odoemtry_float) / 2.0 / 1000.0;        //m/s
    vth = (vel_right.odoemtry_float - vel_left.odoemtry_float) / ROBOT_LENGTH ;       //rad/s
//=====change
    th  = angle.odoemtry_float*0.01745;//实时角度信息(rad)
    return true;
}
/********************************************************
函数功能：获得8位循环冗余校验值
入口参数：数组地址、长度
出口参数：校验值
********************************************************/
unsigned char getCrc8(unsigned char *ptr, unsigned short len)
{
    unsigned char crc;
    unsigned char i;
    crc = 0;
    while(len--)
    {
        crc ^= *ptr++;
        for(i = 0; i < 8; i++)
        {
            if(crc&0x01)
                crc=(crc>>1)^0x8C;
            else 
                crc >>= 1;
        }
    }
    return crc;
}
