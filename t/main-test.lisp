(5am:def-suite all)
(5am:def-suite equal-line :in all)
(5am:def-suite colon-line :in all)

(5am:in-suite equal-line)
(5am:test get-value-from-equal-line
  (5am:is (equal (cl-rc:get-value-from-rc-line "TEST=1") 
		 (cons "TEST" "1"))))

(5am:in-suite colon-line)
(5am:test get-value-from-colon-line
  (5am:is (equal (cl-rc:get-value-from-rc-line "TEST:1") 
		 (cons "TEST" "1"))))
