// Auto-generated. Do not edit!

// (in-package timesync.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class TimesyncDebug {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.seq = null;
      this.sensor_time = null;
      this.ros_time = null;
      this.corrected_timestamp = null;
    }
    else {
      if (initObj.hasOwnProperty('seq')) {
        this.seq = initObj.seq
      }
      else {
        this.seq = 0;
      }
      if (initObj.hasOwnProperty('sensor_time')) {
        this.sensor_time = initObj.sensor_time
      }
      else {
        this.sensor_time = 0.0;
      }
      if (initObj.hasOwnProperty('ros_time')) {
        this.ros_time = initObj.ros_time
      }
      else {
        this.ros_time = 0.0;
      }
      if (initObj.hasOwnProperty('corrected_timestamp')) {
        this.corrected_timestamp = initObj.corrected_timestamp
      }
      else {
        this.corrected_timestamp = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TimesyncDebug
    // Serialize message field [seq]
    bufferOffset = _serializer.uint32(obj.seq, buffer, bufferOffset);
    // Serialize message field [sensor_time]
    bufferOffset = _serializer.float64(obj.sensor_time, buffer, bufferOffset);
    // Serialize message field [ros_time]
    bufferOffset = _serializer.float64(obj.ros_time, buffer, bufferOffset);
    // Serialize message field [corrected_timestamp]
    bufferOffset = _serializer.float64(obj.corrected_timestamp, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TimesyncDebug
    let len;
    let data = new TimesyncDebug(null);
    // Deserialize message field [seq]
    data.seq = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [sensor_time]
    data.sensor_time = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [ros_time]
    data.ros_time = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [corrected_timestamp]
    data.corrected_timestamp = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'timesync/TimesyncDebug';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1b9fcff64ffd5b3203e0d1026359e2c2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint32 seq
    float64 sensor_time
    float64 ros_time
    float64 corrected_timestamp
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TimesyncDebug(null);
    if (msg.seq !== undefined) {
      resolved.seq = msg.seq;
    }
    else {
      resolved.seq = 0
    }

    if (msg.sensor_time !== undefined) {
      resolved.sensor_time = msg.sensor_time;
    }
    else {
      resolved.sensor_time = 0.0
    }

    if (msg.ros_time !== undefined) {
      resolved.ros_time = msg.ros_time;
    }
    else {
      resolved.ros_time = 0.0
    }

    if (msg.corrected_timestamp !== undefined) {
      resolved.corrected_timestamp = msg.corrected_timestamp;
    }
    else {
      resolved.corrected_timestamp = 0.0
    }

    return resolved;
    }
};

module.exports = TimesyncDebug;
