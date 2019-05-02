PROCEDURE Tax
xempnumber = xcurpaylst.empnumber
SELECT * FROM CurCOA WHERE  ALLTRIM(istaxable) = '1'  INTO CURSOR x
SELECT x
xamt = 0
SCAN ALL
     macctnumber = acctnumber
     
     xfld = "xCurPayLst." +  ALLTRIM(macctnumber)
     xAmt = xAmt + NVL(&xfld,0) 
*!*	     IF NVL(&xfld,0) > 0 
*!*	     	MESSAGEBOX(acctname)
*!*	     	MESSAGEBOX(&xfld)
*!*	     	
*!*	     ENDIF 
     SELECT x
ENDSCAN



xtax = 0
xempnumber = xcurpaylst.empnumber
SELECT * FROM CurPayLst WHERE  empnumber = xempnumber  INTO CURSOR x
xtaxcode = NVL(x.taxcode, '')
IF EMPTY(ALLTRIM(xtaxcode))
     SELECT xcurpaylst
     REPLACE d001 WITH 0
ELSE
     SELECT * FROM CurTaxMatrix  ;
              WHERE taxcode =  xtaxcode AND  BETWEEN(xamt, samt, eamt) INTO CURSOR  x
     IF RECCOUNT('x') = 0
          MESSAGEBOX( 'Tax criteria for ' +  ALLTRIM(xcurpaylst.name) + ' is invalid',  "Message")
          SELECT curta
          RETURN
     ENDIF
     mexcess = xamt - NVL(x.samt,  0)
     IF mexcess < 1
          mexcess = 0
     ENDIF
     xtax = x.fix + (mexcess *  x.percentage)
     SELECT xcurpaylst
     REPLACE d001 WITH xtax
ENDIF
ENDPROC

