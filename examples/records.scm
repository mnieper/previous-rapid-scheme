(import (scheme base)
	(scheme write))

(define-record-type
 <pare>
 (kons x y)
 pare?
 (x kar set-kar!)
 (y kdr set-kdr!))

(define p (kons 1 2))

(display (pare? p)) (newline)
(display (kar p)) (newline)
(set-kar! p 3)
(display (kar p)) (newline)
