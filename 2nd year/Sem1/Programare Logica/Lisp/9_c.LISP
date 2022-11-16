(DEFUN lastElem(l)
(
COND
((equal (length l) 0) NIL)
((equal (length l) 1) (car l))
( t ( lastElem (cdr l)))
)
) 

(DEFUN exceptLastE(l)
(
COND
((equal (length l) 0) NIL)
((equal (length l) 1) NIL)
( t (cons (car l) (exceptLastE (cdr l) )))

)
)


(DEFUN summ(l p c)
(
COND
((AND (equal (length l) 0) (equal (length p) 0) (equal c 1)) '(1))
((AND (equal (length l) 0) (equal (length p) 0) (equal c 0)) NIL)

((AND (equal (length p) 0) (equal c 0)) l)
((AND (equal (length p) 0) (equal c 1) )  (summ  l '(0) c))


((AND (equal (length l) 0) (equal c 0)) p)
((AND (equal (length l) 0) (equal c 1) )  (summ '(0) p  c)) 


((< (+ (lastElem l) (lastElem p) c) 10) (APPEND  (summ (exceptLastE l) (exceptLastE p) 0)  (LIST (+ (lastElem l) (lastElem p) c))))
((>= (+ (lastElem l) (lastElem p) c) 10) (APPEND  (summ (exceptLastE l) (exceptLastE p) 1) (LIST(mod (+ (lastElem l) (lastElem p) c) 10 ))))

)
)

(DEFUN sumMain(l p)
(summ l p 0)
)


 