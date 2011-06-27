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
(5am:def-suite all)
(5am:def-suite equal-line :in all)
(5am:def-suite colon-line :in all)
(5am:def-suite parse-file :in all)

(5am:in-suite equal-line)
(5am:test get-value-from-equal-line
  (5am:is (equal (cl-rc:get-value-from-rc-line "TEST=1") 
		 (cons "TEST" "1"))))

(5am:in-suite colon-line)
(5am:test get-value-from-colon-line
  (5am:is (equal (cl-rc:get-value-from-rc-line "TEST:1") 
		 (cons "TEST" "1"))))
(5am:in-suite parse-file)
(5am:test parse-rc-file-test
 (5am:is (not (null (cl-rc:parse-rc-file ".\\t\\test-rc-file")))))
(5am:test get-param-test
 (5am:is (equal "1" (cl-rc:param 
		      (cl-rc:parse-rc-file ".\\t\\test-rc-file")
		      "TEST")))
 (5am:is (equal "2" (cl-rc:param 
		      (cl-rc:parse-rc-file ".\\t\\test-rc-file")
		     "TEST2"))))
(5am:test update-data-test
	  (5am:is (equal "dat" (let ((cfg  (cl-rc:parse-rc-file ".\\t\\test-rc-file")))
				 (cl-rc:update cfg "TEST" "dat")
				 (cl-rc:param cfg  "TEST")))))
(5am:test add-new-data-test
 (5am:is (equal "dat" (let ((cfg  (cl-rc:parse-rc-file ".\\t\\test-rc-file")))
			(cl-rc:update cfg "TEST3" "dat")
			(cl-rc:param cfg  "TEST3")))))
