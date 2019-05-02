**
PROCEDURE LoadSchedEarn
SELECT curschedearn
GOTO TOP
SCAN
     cempnumber = ALLTRIM(curschedearn.empnumber)
     cacctnumber = ALLTRIM(curschedearn.acctnumber)
     namt = curschedearn.amount
     UPDATE xcurpaylst SET &cacctnumber;
= &cacctnumber + namt WHERE ALLTRIM(empnumber);
== cempnumber
ENDSCAN
ENDPROC
**
