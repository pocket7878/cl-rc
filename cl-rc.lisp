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
(in-package :cl-rc)

(defun get-value-from-rc-line (line)
  (multiple-value-bind (match reg)
    (cl-ppcre:scan-to-strings "(.*?)[:=](.*)" line)
    (declare (ignore key item))
    (cons (aref reg 0) (aref reg 1))))

(defun parse-rc-file (file-path)
  (with-open-file (rc-input file-path :direction :input :if-does-not-exist nil)
    (when rc-input
      (loop for line = (read-line rc-input nil 'foo)
	    until (equal line 'foo)
	    collect (get-value-from-rc-line line)))))
