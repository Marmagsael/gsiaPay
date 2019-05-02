**
PROCEDURE CalcLoans
SELECT empnumber, dedncode,  ;
       IIF(amort > balance,  ;
       balance, amort) AS amort  ;
       FROM curLoans INTO CURSOR  ;
       curLoans1
SELECT curloans
GOTO TOP
SCAN
     cempnumber = ALLTRIM(curloans1.empnumber)
     cacctnumber = ALLTRIM(curloans1.dedncode)
     namt = curloans1.amort
     UPDATE xcurpaylst SET &cacctnumber;
= &cacctnumber + namt WHERE ALLTRIM(empnumber);
== cempnumber
ENDSCAN
ENDPROC
**
