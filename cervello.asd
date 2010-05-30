(in-package :cl-user)

(asdf:defsystem :cervello
  :description "Cervello written in LISP. See http://duckinator.net/ai."
  :depends-on (:split-sequence)
  :components ((:file "cervello")))
