**
PROCEDURE PHICPrem1
SELECT * FROM CurCOA WHERE  ;
         withphic = 1 AND  ;
         accttype = "E" INTO  ;
         CURSOR xAcctPHIC
camt = 0
SELECT xacctphic
SCAN ALL
     xfld = xacctphic.acctnumber
     SELECT xcurpaylst
     camt = camt + &xfld
     SELECT xacctphic
ENDSCAN
xempnumber = ALLTRIM(xcurpaylst.empnumber)
SELECT * FROM CurTblTranCurrentMo  ;
         WHERE  ;
         ALLTRIM(acctnumber) ==  ;
         "D003" AND  ;
         ALLTRIM(empnumber) ==  ;
         xempnumber INTO CURSOR  ;
         x
pphicprem = NVL(x.tamount, 0)
SELECT SUM(tamount) AS prevamt  ;
       FROM CurTblTranCurrentMo  ;
       WHERE acctnumber IN(SELECT  ;
       acctnumber FROM xAcctPHIC)  ;
       AND ALLTRIM(empnumber) ==  ;
       xempnumber INTO CURSOR x
pphicamt = NVL(x.prevamt, 0)
totphicamt = NVL(pphicamt, 0) +  ;
             NVL(camt, 0)
SELECT * FROM CurMedMatrix WHERE  ;
         BETWEEN(totphicamt,  ;
         fstart, fend) INTO  ;
         CURSOR x
mactualphicprem = x.fmedee -  ;
                  pphicprem
SELECT xcurpaylst
REPLACE d003 WITH mactualphicprem
SELECT xacctphic
ENDPROC
**
