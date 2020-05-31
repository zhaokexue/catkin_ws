;; Auto-generated. Do not edit!


(when (boundp 'timesync::TimesyncDebug)
  (if (not (find-package "TIMESYNC"))
    (make-package "TIMESYNC"))
  (shadow 'TimesyncDebug (find-package "TIMESYNC")))
(unless (find-package "TIMESYNC::TIMESYNCDEBUG")
  (make-package "TIMESYNC::TIMESYNCDEBUG"))

(in-package "ROS")
;;//! \htmlinclude TimesyncDebug.msg.html


(defclass timesync::TimesyncDebug
  :super ros::object
  :slots (_seq _sensor_time _ros_time _corrected_timestamp ))

(defmethod timesync::TimesyncDebug
  (:init
   (&key
    ((:seq __seq) 0)
    ((:sensor_time __sensor_time) 0.0)
    ((:ros_time __ros_time) 0.0)
    ((:corrected_timestamp __corrected_timestamp) 0.0)
    )
   (send-super :init)
   (setq _seq (round __seq))
   (setq _sensor_time (float __sensor_time))
   (setq _ros_time (float __ros_time))
   (setq _corrected_timestamp (float __corrected_timestamp))
   self)
  (:seq
   (&optional __seq)
   (if __seq (setq _seq __seq)) _seq)
  (:sensor_time
   (&optional __sensor_time)
   (if __sensor_time (setq _sensor_time __sensor_time)) _sensor_time)
  (:ros_time
   (&optional __ros_time)
   (if __ros_time (setq _ros_time __ros_time)) _ros_time)
  (:corrected_timestamp
   (&optional __corrected_timestamp)
   (if __corrected_timestamp (setq _corrected_timestamp __corrected_timestamp)) _corrected_timestamp)
  (:serialization-length
   ()
   (+
    ;; uint32 _seq
    4
    ;; float64 _sensor_time
    8
    ;; float64 _ros_time
    8
    ;; float64 _corrected_timestamp
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _seq
       (write-long _seq s)
     ;; float64 _sensor_time
       (sys::poke _sensor_time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _ros_time
       (sys::poke _ros_time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _corrected_timestamp
       (sys::poke _corrected_timestamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _seq
     (setq _seq (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _sensor_time
     (setq _sensor_time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _ros_time
     (setq _ros_time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _corrected_timestamp
     (setq _corrected_timestamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get timesync::TimesyncDebug :md5sum-) "1b9fcff64ffd5b3203e0d1026359e2c2")
(setf (get timesync::TimesyncDebug :datatype-) "timesync/TimesyncDebug")
(setf (get timesync::TimesyncDebug :definition-)
      "uint32 seq
float64 sensor_time
float64 ros_time
float64 corrected_timestamp

")



(provide :timesync/TimesyncDebug "1b9fcff64ffd5b3203e0d1026359e2c2")


