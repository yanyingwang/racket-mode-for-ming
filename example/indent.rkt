;; -*- racket-indent-sequence-depth: 100; racket-indent-curly-as-sequence: t; -*-

;;; NOTE: After changing this file you will need to M-x faceup-write-file
;;; to regenerate the .faceup test comparison file.

;;; Quoted list

'(a b
  (a b
   c))

'((1) 2 3
  (3)
  4 5)

;;; Quasiquoted list (align with head) and unquote or unquote-splicing
;;; (use normal indent rules for the form).

`(Part ()
  (PartNumber ()
   ,part)
  (ETag ()
   ,etag))

`((,(x)
   ,y))

`(Delete
  ,@(for/list ([p (in-list paths)])
      `(Object ()
        (Key () ,p))))

;;; Syntax

#'(for/list ([x xs])
    x)

#`(for/list ([x xs])
    x)

#'(#%app (#%app hasheq (quote a) (quote 42))
         (quote a))

(#%app (#%app hasheq (quote a) (quote 42))
       (quote a))

#'(foo (#%app hasheq (quote a) (quote 42))
       (quote a))

;;; Rackjure style dictionary (when racket-indent-curly-as-sequence is t).

{a b
 c d}

{a b
 c d
 b '(a x
     s (x y
        x v))}

;;; Vector

#(a b
  c d)

;;; List with a keyword as first member (e.g. in many contracts)

(#:x y
 #:y x)

;;; Normal function application.

(foobar x
        y
        z)

(foobar
 x
 y
 z)

(dict-set a
          b
          c)

(dict-set
 a
 b
 c)

(call-with-values (lambda () (values 1 2))
                  +)

(call-with-values
 (lambda () (values 1 2))
 +)

;;; Forms with special indentation

(let ([x 0])
  x)

;; indent 2

(syntax-case stx ()
  [(_ x) #'#f]
  [(_ x y) #'#t])

;; indent 3

(syntax-case* stx () x
  [(_ x) #'#f]
  [(_ x y) #'#t])

(syntax-case*
    stx
    (module #%module-begin define-values define-syntaxes
            define define/contract
            define-syntax struct define-struct)
    x
  [(_ x) #'#f]
  [(_ x y) #'#t])

;; begin and cond have 0 style
(begin
  0
  0)

(begin 0
       0)

(cond [1 2]
      [3 4])

(cond
  [1 2]
  [3 4])

(if a
    x
    x)

;; begin*

(begin-for-foo 0
               0)

(begin-for-foo
  0
  0)

(with-handlers ([x y])
  a b c)

;; def, with-, call-with- and other 'defun style

(define (x) x x
  x)

(struct x x
  ())

(match-define (list x y)
  (list 1 2))

(with-output-to-file path #:mode 'text #:exists 'replace
  (λ () (display "Hello, world.")))

(call-with-output-file path #:mode 'text #:exists 'replace
  (λ (out) (display "Hello, world." out)))


;;; Special forms: When the first non-distinguished form is on the
;;; same line as distinguished forms, disregard it for indent.

;; module has indent 2

(module 1
    2
  3
  4
  5)

;; Normal case
(module 1 2
  3
  4
  5)

;; Weird case -- but this is how scheme-mode indents it.
(module 1 2 3
        4
        5)

;; Weird case -- but this is how scheme-mode indents it.
(module 1 2 3 4
        5)

;;; Bug #50

'((x
   y) A
  z
  (x
   y) A
  z)

(match args
  [(list x) (x
             y)] ...
  [(list x) (x y)] ...
  [(list x) (x y)] ...)

(define-syntax (fstruct stx)
  (syntax-parse stx
    [(_ id:id (field:id ...))
     (with-syntax ([(accessor ...)
                    (for/list ([fld (in-list (syntax->list #'(field ...)))])
                      (format-id stx "~a-~a" (syntax->datum #'id) fld))])
       #'(serializable-struct
          id (field ...) #:transparent
          #:property prop:procedure
          (lambda (self . args)
            (match args
              [(list 'field) (accessor self)] ...
              [(list (list 'field)) (accessor self)] ...
              [(list (list-rest 'field fields)) ((accessor self) fields)] ...
              [(list-rest 'field f args)
               (struct-copy id self
                            [field (apply f (accessor self) args)])] ...
              [(list-rest (list 'field) f args)  ;<-- THIS SEXPR IS INDENTED TOO FAR
               (struct-copy id self
                            [field (apply f (accessor self) args)])] ...
              [(list-rest (list-rest 'field fields) args)
               (struct-copy id self
                            [field (apply (accessor self) fields args)])] ...))))]))