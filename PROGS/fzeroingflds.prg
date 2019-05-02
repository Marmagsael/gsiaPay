**
PROCEDURE ZeroingFlds
SELECT curfldlst
SCAN FOR accttype = 'E' .OR.  ;
     accttype = 'D'
     xfld = ALLTRIM(cd)
     SELECT xcurpaylst
     REPLACE &xfld WITH 0 
     SELECT curfldlst
ENDSCAN
ENDPROC
**
