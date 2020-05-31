; Auto-generated. Do not edit!


(cl:in-package timesync-msg)


;//! \htmlinclude TimesyncDebug.msg.html

(cl:defclass <TimesyncDebug> (roslisp-msg-protocol:ros-message)
  ((seq
    :reader seq
    :initarg :seq
    :type cl:integer
    :initform 0)
   (sensor_time
    :reader sensor_time
    :initarg :sensor_time
    :type cl:float
    :initform 0.0)
   (ros_time
    :reader ros_time
    :initarg :ros_time
    :type cl:float
    :initform 0.0)
   (corrected_timestamp
    :reader corrected_timestamp
    :initarg :corrected_timestamp
    :type cl:float
    :initform 0.0))
)

(cl:defclass TimesyncDebug (<TimesyncDebug>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TimesyncDebug>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TimesyncDebug)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name timesync-msg:<TimesyncDebug> is deprecated: use timesync-msg:TimesyncDebug instead.")))

(cl:ensure-generic-function 'seq-val :lambda-list '(m))
(cl:defmethod seq-val ((m <TimesyncDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader timesync-msg:seq-val is deprecated.  Use timesync-msg:seq instead.")
  (seq m))

(cl:ensure-generic-function 'sensor_time-val :lambda-list '(m))
(cl:defmethod sensor_time-val ((m <TimesyncDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader timesync-msg:sensor_time-val is deprecated.  Use timesync-msg:sensor_time instead.")
  (sensor_time m))

(cl:ensure-generic-function 'ros_time-val :lambda-list '(m))
(cl:defmethod ros_time-val ((m <TimesyncDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader timesync-msg:ros_time-val is deprecated.  Use timesync-msg:ros_time instead.")
  (ros_time m))

(cl:ensure-generic-function 'corrected_timestamp-val :lambda-list '(m))
(cl:defmethod corrected_timestamp-val ((m <TimesyncDebug>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader timesync-msg:corrected_timestamp-val is deprecated.  Use timesync-msg:corrected_timestamp instead.")
  (corrected_timestamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TimesyncDebug>) ostream)
  "Serializes a message object of type '<TimesyncDebug>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seq)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seq)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sensor_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'ros_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'corrected_timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TimesyncDebug>) istream)
  "Deserializes a message object of type '<TimesyncDebug>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seq)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sensor_time) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ros_time) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'corrected_timestamp) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TimesyncDebug>)))
  "Returns string type for a message object of type '<TimesyncDebug>"
  "timesync/TimesyncDebug")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TimesyncDebug)))
  "Returns string type for a message object of type 'TimesyncDebug"
  "timesync/TimesyncDebug")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TimesyncDebug>)))
  "Returns md5sum for a message object of type '<TimesyncDebug>"
  "1b9fcff64ffd5b3203e0d1026359e2c2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TimesyncDebug)))
  "Returns md5sum for a message object of type 'TimesyncDebug"
  "1b9fcff64ffd5b3203e0d1026359e2c2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TimesyncDebug>)))
  "Returns full string definition for message of type '<TimesyncDebug>"
  (cl:format cl:nil "uint32 seq~%float64 sensor_time~%float64 ros_time~%float64 corrected_timestamp~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TimesyncDebug)))
  "Returns full string definition for message of type 'TimesyncDebug"
  (cl:format cl:nil "uint32 seq~%float64 sensor_time~%float64 ros_time~%float64 corrected_timestamp~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TimesyncDebug>))
  (cl:+ 0
     4
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TimesyncDebug>))
  "Converts a ROS message object to a list"
  (cl:list 'TimesyncDebug
    (cl:cons ':seq (seq msg))
    (cl:cons ':sensor_time (sensor_time msg))
    (cl:cons ':ros_time (ros_time msg))
    (cl:cons ':corrected_timestamp (corrected_timestamp msg))
))
