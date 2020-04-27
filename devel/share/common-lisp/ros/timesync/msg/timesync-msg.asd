
(cl:in-package :asdf)

(defsystem "timesync-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "TimesyncDebug" :depends-on ("_package_TimesyncDebug"))
    (:file "_package_TimesyncDebug" :depends-on ("_package"))
  ))