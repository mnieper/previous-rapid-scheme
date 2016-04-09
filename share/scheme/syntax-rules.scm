;;; Rapid Scheme --- An expander for R7RS programs

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

(define-syntax %syntax-rules ;; XXX
  (er-macro-transformer
   (lambda (syntax rename compare)
     (and-let*
	 ((transformer (syntax-datum syntax))
	  (ellipsis-syntax (cond
			    ((and (>= (length transformer) 2)
				  (list (syntax-datum (list-ref transformer 1))))
			     #f)
			    ((and (>= (length transformer) 3)
				  (list? (syntax-datum (list-ref transformer 2))))
			     (list-ref transformer 1))
			    (else
			     (compile-error "bad syntax-rules syntax" transformer-syntax))))
	  (literal-syntax* (list-ref transformer (if ellipsis-syntax 2 1)))
	  (syntax-rule-syntax* (list-tail transformer (if ellipsis-syntax 3 2)))
	  (ellipsis (if ellipsis-syntax (syntax-datum ellipsis-syntax) #f))
	  
	  
	  (ellipsis-syntax (if (and (>= (leng

     )))

  
