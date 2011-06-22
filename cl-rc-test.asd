(asdf:defsystem #:cl-rc-test
	:name "cl-rc-test"
	:author "Pocket7878 <poketo7878@yahoo.co.jp>"
	:version "1.0"
	:description "Test for cl-rc"
	:components (
		     (:module :t
			      :components (
					   (:file "main-test"))))
	:depends-on (
		     :fiveam
		     :cl-rc))
