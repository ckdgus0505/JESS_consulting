;���� ��õ R1
(deffunction recsav ()
	(printout t "���� ���ݷ��� �������ϹǷ� ������ ��õ�մϴ�." crlf))
	
;���� ��õ R2
(deffunction recsto ()
	(printout t "���� ���ݷ��� �����ϰ�"crlf)
	(printout t "���� �������� �����ϹǷ� ���ڸ� ��õ�մϴ�." crlf))
	
;������ ��õ R3
(deffunction reccom ()
	(printout t "���� ���ݷ��� ����������" crlf)
	(printout t "�������� �������ϹǷ� ���ݰ� ���ڸ� ��� �ϴ°��� ��õ�մϴ�." crlf))
	
; ������ ���� R4
(deffunction savingsad (?x, ?y)
	(printout t "���� ���ݷ��� " ?x "�̰�" crlf)
	(printout t "�ξ簡�� " ?y "���� �ξ��ϱ� ���� �ʿ�� �ϴ� ������" crlf)
	(printout t "��� ���θ� �Ǵ��ϴ� ������ " (* 5000 ?y)"�̹Ƿ�" crlf)
	(printout t "������ ����� ������ �Ǵܵ˴ϴ�." crlf crlf))
	
; ������ ���� X R5
(deffunction savingsin (?x, ?y)
	(printout t "���� ���ݷ��� " ?x "�̰�" crlf)
	(printout t "�ξ簡�� " ?y "���� �ξ��ϱ� ���� �ʿ�� �ϴ� ������" crlf)
	(printout t "��� ���θ� �Ǵ��ϴ� ������ " (* 5000 ?y)"�̹Ƿ�" crlf)
	(printout t "������ ������� ���� ������ �Ǵܵ˴ϴ�." crlf crlf))


; ���� ���� R6
(deffunction incomead (?x, ?y)
	(printout t "���� �������� " ?x "�̰�" crlf)
	(printout t "�ξ簡�� " ?y "���� �ξ��ϱ� ���� �ʿ�� �ϴ� ������" crlf)
	(printout t "��� ���θ� �Ǵ��ϴ� ������ " (+ 15000 (* 4000 ?y))"�̹Ƿ�" crlf)
	(printout t "������ ����� ������ �Ǵܵ˴ϴ�." crlf crlf))
	 
; ���� ���� X R7
(deffunction incomein (?x, ?y)
	(printout t "���� �������� " ?x "�̰�" crlf)
	(printout t "�ξ簡�� " ?y "���� �ξ��ϱ� ���� �ʿ�� �ϴ� ������" crlf)
	(printout t "��� ���θ� �Ǵ��ϴ� ������ " (+ 15000 (* 4000 ?y))"�̹Ƿ�" crlf)
	(printout t "������ ������� ���� ������ �Ǵܵ˴ϴ�." crlf crlf))
	
; ���� ����X R8
(deffunction incomeun ()
	(printout t "���� ������ �������� �����Ƿ�" crlf)
	(printout t "������ ������� ���� ������ �Ǵܵ˴ϴ�." crlf crlf))
	

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