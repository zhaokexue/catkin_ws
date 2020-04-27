#include <vector>
#include "mbot_bringup/mbot.h"
#include "mbot_linux_serial.h"
using namespace std;

namespace mbot
{
  boost::array<double, 36> odom_pose_covariance = {
        {1e-9, 0, 0, 0, 0, 0, 
        0, 1e-3,1e-9, 0, 0, 0, 
        0, 0, 1e6, 0, 0, 0,
        0, 0, 0, 1e6, 0, 0, 
        0, 0, 0, 0, 1e6, 0, 
        0, 0, 0, 0, 0, 1e-9}};
    boost::array<double, 36> odom_twist_covariance = {
        {1e-9, 0, 0, 0, 0, 0, 
        0, 1e-3,1e-9, 0, 0, 0, 
        0, 0, 1e6, 0, 0, 0, 
        0, 0, 0, 1e6, 0, 0, 
        0, 0, 0, 0, 1e6, 0, 
        0, 0, 0, 0, 0, 1e-9}};
  /*
    boost::array<double, 36> odom_pose_covariance = {
        {1e-3, 0, 0, 0, 0, 0, 
        0, 1e-3,0, 0, 0, 0, 
        0, 0, 1e6, 0, 0, 0,
        0, 0, 0, 1e6, 0, 0, 
        0, 0, 0, 0, 1e6, 0, 
        0, 0, 0, 0, 0, 1e3}};
    boost::array<double, 36> odom_twist_covariance = {
        {1e-3, 0, 0, 0, 0, 0, 
        0, 1e-3,0, 0, 0, 0, 
        0, 0, 1e6, 0, 0, 0, 
        0, 0, 0, 1e6, 0, 0, 
        0, 0, 0, 0, 1e6, 0, 
        0, 0, 0, 0, 0, 1e3}};
*/
    mbot::mbot():
        x_(0.0), y_(0.0), th_(0.0),
        vx_(0.0), vy_(0.0), vth_(0.0)
    {
    }

    mbot::~mbot()
    {
    }
    /********************************************************
    函数功能：串口参数初始化、时间变量初始化、实例化发布对象
    入口参数：无
    出口参数：bool
    ********************************************************/
    bool mbot::init()
    {
        // 串口初始化连接
        serialInit();
               
        ros::Time::init();
        current_time_ = ros::Time::now();
        last_time_ = ros::Time::now();
        
        //定义发布消息的名称
        pub_ = nh.advertise<nav_msgs::Odometry>("odom", 50);		
        
        return true;
    }
 
    /********************************************************
    函数功能：根据机器人线速度和角度计算机器人里程计
    入口参数：无
    出口参数：无
    ********************************************************/
    void mbot::calcOdom()
    {
        ros::Time curr_time;
        curr_time = ros::Time::now();
        
        double dt = (curr_time - last_time_).toSec();                                       //间隔时间
        double delta_x = (vx_ * cos(th_) - vy_ * sin(th_)) * dt;
        double delta_y = (vx_ * sin(th_) + vy_ * cos(th_)) * dt;
        double delta_th = vth_ * dt;
        //相隔20ms
        ROS_INFO("dt:%f\n",dt);   //s

        x_ += delta_x;
        y_ += delta_y;
//==============change
//        th_ += delta_th;//实时角度信息,如果这里不使用IMU，也可以通过这种方式计算得出

        last_time_ = curr_time;  

        ROS_INFO("x_:%f\n",x_);
        ROS_INFO("y_:%f\n",y_);
        ROS_INFO("th_:%f\n",th_);

    }
    /********************************************************
    函数功能：自定义spinOnce，实现整合，并且发布TF变换和Odom
    入口参数：机器人线速度和角速度，调用上面三个函数
    出口参数：bool
    ********************************************************/
    bool mbot::spinOnce(double RobotV, double YawRate)
    {
        // 下发机器人期望速度
        writeSpeed(RobotV, YawRate);
        // 读取机器人实际速度和角度
        readSpeed(vx_,vth_,th_);
        // 里程计计算
        calcOdom();
        
        current_time_ = ros::Time::now();
        // 发布TF
        geometry_msgs::TransformStamped odom_trans;
        odom_trans.header.stamp = current_time_;
        odom_trans.header.frame_id = "odom";
        odom_trans.child_frame_id  = "base_footprint";

        geometry_msgs::Quaternion odom_quat;
        odom_quat = tf::createQuaternionMsgFromYaw(th_);
        odom_trans.transform.translation.x = x_;
        odom_trans.transform.translation.y = y_;
        odom_trans.transform.translation.z = 0.0;
        odom_trans.transform.rotation = odom_quat;
        
      odom_broadcaster_.sendTransform(odom_trans);

        // 发布里程计消息
        nav_msgs::Odometry msgl;
        msgl.header.stamp = current_time_;
        msgl.header.frame_id = "odom";

        msgl.pose.pose.position.x = x_;
        msgl.pose.pose.position.y = y_;
        msgl.pose.pose.position.z = 0.0;
        msgl.pose.pose.orientation = odom_quat;
        msgl.pose.covariance = odom_pose_covariance;

        msgl.child_frame_id = "base_footprint";
        msgl.twist.twist.linear.x = vx_;
        msgl.twist.twist.linear.y = vy_;
        msgl.twist.twist.angular.z = vth_;
        msgl.twist.covariance = odom_twist_covariance;
    
        pub_.publish(msgl);
    }
}
