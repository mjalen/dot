(asdf:load-system :parenscript)

(defun test ()
  (parenscript:ps
    (defun new-test ()
      (let ((test (array 1 2)))
	(loop :for te :in test
	      :collect (1+ te))))))

