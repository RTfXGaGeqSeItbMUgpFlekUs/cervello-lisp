(defpackage #:cervello
  (:use :cl :split-sequence))

(in-package :cervello)

(defun remove-punctuation (str)
  "Strip all crap (punctuation) from a string."
  ;;; If you are wondering why we refer to punctuation as crap,
  ;;; the original name of this function was remove-crap.
  (let ((crap '(#\, #\. #\:)))
    (labels ((remove-crap (str crap)
	       (if (car crap)
		   (remove-crap (remove (car crap) str) (cdr crap))
		   str)))
      (remove-crap str crap))))

(defun split-without-punctuation (str)
  "Split a string without punctuation."
  ;;; Ask nixeagle about this tomorrow.
  (multiple-value-bind (lst len)
      (split-sequence #\  (remove-punctuation str))
    lst))

(defun group (lst w)
  "Split the list of words into groups based on w."
  (let ((n (+ w 1)))
    ;;; Is there a library function to do this?
    (labels ((list-from-first-nth-items (n lst)
	       (labels ((lffni-i (n lst acc)
			  (if (> n 0)
			      (lffni-i (- n 1)
				       (cdr lst)
				       (append acc (list (first lst))))
			      acc)))
		 (lffni-i n lst nil)))
	     (group-i (lst acc)
	       ;;; Split a list into groups of w. (1,2,3,4) -> (1,2),(2,3),...
	       ;;; for w = 2.
	       (if (> (length lst) w)
		   ;;; If there is more to the list, recursively call ourself
		   ;;; after moving w elements to a new list in acc.
		   (group-i (cdr lst)
			    (append acc (list
					 (list-from-first-nth-items w lst))))
		   ;;; Otherwise, append the rest of the elements to acc.
		   (append acc (list
				(list-from-first-nth-items
				 (length lst) lst))))))
      (if (> (length lst) n)
	  (group-i lst nil)
	  (list lst)))))