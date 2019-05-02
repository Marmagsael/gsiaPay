PROCEDURE CashBond

xempnumber = ALLTRIM(xcurpaylst.empnumber)
SELECT * FROM curPayLst WHERE  empnumber = xempnumber  INTO CURSOR x

xamt = x.cashbond
SELECT * FROM CurTblTranCurrentPd  WHERE ALLTRIM(empnumber) ==  xempnumber AND  ; 
		ALLTRIM(acctnumber) ==  'D010' INTO CURSOR x
		
IF RECCOUNT('x') > 0
     SELECT xcurpaylst
     REPLACE d010 WITH 0
     RETURN
ENDIF

SELECT * FROM CurCashbond WHERE  empnumber = xempnumber  INTO CURSOR x

IF 	x.cbtot >= 15000
    SELECT xcurpaylst
    REPLACE d010 WITH 0
    RETURN
ENDIF

SELECT xcurpaylst
REPLACE d010 WITH xamt
