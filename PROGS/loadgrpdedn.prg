**
PROCEDURE LoadGrpDedn
SELECT curgrpdedn
GOTO TOP
SCAN
     cempnumber 	= ALLTRIM(curgrpdedn.empnumber)
     cacctnumber 	= ALLTRIM(curgrpdedn.acctnumber)
     namt 			= curgrpdedn.amount
     UPDATE xcurpaylst SET &cacctnumber = &cacctnumber + namt  WHERE ALLTRIM(empnumber) == cempnumber
ENDSCAN
ENDPROC
**
