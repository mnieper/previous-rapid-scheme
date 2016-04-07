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

(import (scheme base)
	(scheme process-context)
	(rapid and-let)
	(rapid format)
	(rapid expansion)
	(rapid compiler compile))

(define help-string (format "\ 
Usage: ~a [options] file
Options:
  -I<dir>        Add <dir> to the library search path
  -h, --help     Display this information
  -v, --version  Display compiler version information

" (car (command-line))))

(define version-string "\ 
rapid-compiler (Rapid Scheme) 0.1
Copyright (C) 2016 Marc Nieper-Wißkirchen
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

")

(define (help) (write-string help-string))
(define (version) (write-string version-string))

(cond
 ((or (member "--help" (command-line) string=?)
      (member "-h" (command-line) string=?))
  (help))
 ((or (member "--version" (command-line) string=?)
      (member "-v" (command-line) string=?))
  (version))
 (else
  (let loop ((command-line (cdr (command-line))) (search-paths '()))
    (and-let*
	(((or (not (null? command-line))
	      (begin
		(write-string "rapid-compiler: exactly one input file needed\n")
		(exit #f))))
	 (argument (car command-line)))
      (or
       (and-let*
	   (((>= (string-length argument) 2))
	    ((char=? (string-ref argument 0) #\-)))
	 (case (string-ref argument 1)
	   ((#\I)
	    (loop (cdr command-line) (cons (string-copy argument 2) search-paths)))
	   (else #f)))
       (parameterize
	   ((current-search-paths search-paths))
	 (compile argument)))))))
