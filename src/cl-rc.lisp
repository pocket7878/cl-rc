;;Copyright (C) <2011>  <Pocket7878>
;;
;;This program is free software: you can redistribute it and/or modify
;;it under the terms of the GNU General Public License as published by
;;the Free Software Foundation, either version 3 of the License, or
;;(at your option) any later version.
;;
;;This program is distributed in the hope that it will be useful,
;;but WITHOUT ANY WARRANTY; without even the implied warranty of
;;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;GNU General Public License for more details.
;;
;;You should have received a copy of the GNU General Public License
;;along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
(in-package :cl-rc)

(defclass config ()
  ((filepath :initform nil :initarg :filepath :reader filepath)
   (data :initform nil :initarg :data :accessor data)))

(defmethod param ((cfg config) key)
  (with-slots (data) cfg
    (gethash key data)))

(defmethod vars ((cfg config))
  (with-slots (data) cfg
    data))

;; update data or add new pair
(defmethod update ((cfg config) key value)
  (with-slots (data) cfg
    (setf (gethash key data) value)))

;; save data
(defmethod save ((cfg config) &optional file-path)
  (let ((out-stm (if file-path
		   (open file-path :direction :output :if-does-not-exist :create)
		   (open (filepath cfg) :direction :output :if-does-not-exist :create :if-exists :supersede))))
    (maphash  #'(lambda (key value) 
			    (format out-stm "~A=~A~%" key value))
	      (vars cfg))
    (close out-stm)))
    

(defun alist-to-hash (alist)
  (let ((hash (make-hash-table :test #'equal)))
    (loop for (key . value) in alist 
	  do (setf (gethash key hash) value))
    hash))

(defun get-value-from-rc-line (line)
  (cl-irregsexp:if-match-bind (key (or "=" ":") value) line 
			      (cons key value)))

;; Create config instance and retern
(defun parse-rc-file (file-path)
  (with-open-file (rc-input file-path :direction :input :if-does-not-exist nil)
    (when rc-input
      (make-instance 'config 
		     :filepath file-path
		     :data
		     (alist-to-hash
		       (loop for line = (read-line rc-input nil 'foo)
			     until (equal line 'foo) 
			     collect (get-value-from-rc-line line)))))))
