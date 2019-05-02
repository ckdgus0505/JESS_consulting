;저금 추천 R1
(deffunction recsav ()
	(printout t "현재 저금량이 부적절하므로 저금을 추천합니다." crlf))
	
;투자 추천 R2
(deffunction recsto ()
	(printout t "현재 저금량이 적절하고"crlf)
	(printout t "현재 연수입이 적절하므로 투자를 추천합니다." crlf))
	
;복합적 추천 R3
(deffunction reccom ()
	(printout t "현재 저금량이 적절하지만" crlf)
	(printout t "연수입이 부적절하므로 저금과 투자를 모두 하는것을 추천합니다." crlf))
	
; 저금이 적당 R4
(deffunction savingsad (?x, ?y)
	(printout t "현재 저금량은 " ?x "이고" crlf)
	(printout t "부양가족 " ?y "명을 부양하기 위해 필요로 하는 수입의" crlf)
	(printout t "충분 여부를 판단하는 기준은 " (* 5000 ?y)"이므로" crlf)
	(printout t "저금은 충분한 것으로 판단됩니다." crlf crlf))
	
; 저금이 적당 X R5
(deffunction savingsin (?x, ?y)
	(printout t "현재 저금량은 " ?x "이고" crlf)
	(printout t "부양가족 " ?y "명을 부양하기 위해 필요로 하는 수입의" crlf)
	(printout t "충분 여부를 판단하는 기준은 " (* 5000 ?y)"이므로" crlf)
	(printout t "저금은 충분하지 않은 것으로 판단됩니다." crlf crlf))


; 저금 적당 R6
(deffunction incomead (?x, ?y)
	(printout t "현재 연수입은 " ?x "이고" crlf)
	(printout t "부양가족 " ?y "명을 부양하기 위해 필요로 하는 수입의" crlf)
	(printout t "충분 여부를 판단하는 기준은 " (+ 15000 (* 4000 ?y))"이므로" crlf)
	(printout t "수입은 충분한 것으로 판단됩니다." crlf crlf))
	 
; 수입 적당 X R7
(deffunction incomein (?x, ?y)
	(printout t "현재 연수입은 " ?x "이고" crlf)
	(printout t "부양가족 " ?y "명을 부양하기 위해 필요로 하는 수입의" crlf)
	(printout t "충분 여부를 판단하는 기준은 " (+ 15000 (* 4000 ?y))"이므로" crlf)
	(printout t "수입은 충분하지 않은 것으로 판단됩니다." crlf crlf))
	
; 수입 꾸준X R8
(deffunction incomeun ()
	(printout t "현재 수입이 일정하지 않으므로" crlf)
	(printout t "수입이 충분하지 않은 것으로 판단됩니다." crlf crlf))
	

(defrule R1
;	(savings_account ?x)
	(savings_account inadequate)
;	(income ?y)
	=>
	(recsav)
	(assert (investment savings)))
	
(defrule R2
;	(savings_account ?x)
	(savings_account adequate)
;	(income ?y)
	(income adequate)
	=>
	(recsto)
	(assert (investment stocks)))
	
(defrule R3
;	(savings_account ?x)
	(savings_account adequate)
;	(income ?y)
	(income inadequate)
	=>
	(recsto)
	(assert (investment combination)))
	
(defrule R4
	(amount_saved ?x)
	(dependents ?y&:(>= ?x (* 5000 ?y)))
	=>
	(savingsad ?x ?y)
	(assert (savings_account adequate)))
	
(defrule R5
	(amount_saved ?x)
	(dependents ?y&:(< ?x (* 5000 ?y)))
	=>
	(savingsin ?x ?y)
	(assert (savings_account inadequate)))
	
(defrule R6
	(earnings ?x steady)
	(dependents ?y&:(>= ?x (+ 15000 (* 4000 ?y))))
	=>
	(incomead ?x ?y)
	(assert (income adequate)))
	
(defrule R7
	(earnings ?x steady)
	(dependents ?y&:(< ?x (+ 15000 (* 4000 ?y))))
	=>
	(incomein ?x ?y)
	(assert (income inadequate)))

(defrule R8
	(earnings ?x unsteady)
	=>
	(incomeun)
	(assert (income inadequate)))
	
(run)