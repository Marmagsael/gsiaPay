**
PROCEDURE PagibigPrem
SELECT * FROM CurCOA WHERE  ;
         withsss = 1 AND accttype =  ;
         "E" INTO CURSOR  ;
         xAcctPagibig
camt = 0
SELECT xacctpagibig
SCAN ALL
     xfld = xacctpagibig.acctnumber
     SELECT xcurpaylst
     camt = camt + &xfld
     SELECT xacctpagibig
ENDSCAN
xempnumber = xcurpaylst.empnumber
SELECT * FROM CurTblTranCurrentMo  ;
         WHERE acctnumber =  ;
         "D004" AND  ;
         ALLTRIM(empnumber) ==  ;
         ALLTRIM(xempnumber) INTO  ;
         CURSOR x
ppagibigprem = NVL(x.tamount, 0)
SELECT SUM(tamount) AS prevamt  ;
       FROM CurTblTranCurrentMo  ;
       WHERE acctnumber IN(SELECT  ;
       acctnumber FROM  ;
       xAcctPagibig) AND  ;
       ALLTRIM(empnumber) ==  ;
       ALLTRIM(xempnumber) INTO  ;
       CURSOR x
ppagibigamt = NVL(x.prevamt, 0)
totpagibigamt = NVL(ppagibigamt,  ;
                0) + NVL(camt,  ;
                0)
SELECT * FROM CurPagibigMatrix  ;
         WHERE  ;
         BETWEEN(totpagibigamt,  ;
         fstart, fend) INTO  ;
         CURSOR x
mactualpagibigprem = x.empcont -  ;
                     ppagibigprem
IF mactualpagibigprem < 0
     mactualpagibigprem = 0
ENDIF
SELECT xcurpaylst
REPLACE d004 WITH  ;
        mactualpagibigprem
SELECT xacctpagibig
ENDPROC
**
