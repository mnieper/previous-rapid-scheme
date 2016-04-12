;;; Rapid Scheme --- An implementation of R7RS

;; Copyright (C) 2016 Marc Nieper-Wißkirchen

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Fundamental binding construct

(define-syntax letrec*-values
  (syntax-rules ()
    ((letrec*-values ((formals init) ...) body1 body2 ...)
     (let ()
       (define-values formals init)
       ...
       (let ()
	 body1
	 body2
	 ...)))))

;; Procedural records

(define-record-type <rtd>
  (%make-rtd name fieldspecs make-record record? record-fields)
  rtd?
  (name rtd-name)
  (fieldspecs rtd-fieldspecs)
  (make-record rtd-make-record)
  (record? rtd-record?)
  (record-fields rtd-record-fields))

(define (find-index fieldspecs field)
  (let loop ((i 0))
    (cond
     ((= i (vector-length fieldspecs))
      (error "invalid field" field))
     ((eq? (vector-ref fieldspecs i) field)
      i)
     (else
      (loop (+ i 1))))))

(define (make-rtd name fieldspecs)
  (define-record-type <record>
    (make-record fields)
    record?
    (fields record-fields))
  (%make-rtd name fieldspecs make-record record? record-fields))

(define (rtd-constructor rtd fieldspecs)
  (let*
      ((make-record
	(rtd-make-record rtd))
       (k
	(vector-length (rtd-fieldspecs rtd)))
       (indexes
	(vector-map
	 (lambda (fieldspec)
	   (find-index (rtd-fieldspecs rtd) fieldspec))
	 fieldspecs)))
    (lambda args
      (let ((arg-vector (list->vector args)))
	(unless (= (vector-length arg-vector) (vector-length indexes))
	  (error "unexpected number of arguments" (vector-length args)))
	(let ((fields (make-vector k (if #f #f))))
	  (vector-for-each
	   (lambda (arg index)
	     (vector-set! fields index arg))
	   arg-vector indexes)
	  (make-record fields))))))

(define (rtd-predicate rtd)
  (let ((pred (rtd-record? rtd)))
    (lambda (obj)
      (pred obj))))

(define (rtd-accessor rtd field) 
  (let*
      ((record-fields (rtd-record-fields rtd))
       (index (find-index (rtd-fieldspecs rtd) field)))
    (lambda (record)
      (vector-ref (record-fields record) index))))

(define (rtd-mutator rtd field)
  (let*
      ((record-fields (rtd-record-fields rtd))
       (index (find-index (rtd-fieldspecs rtd) field)))
    (lambda (record value)
      (vector-set! (record-fields record) index value))))
