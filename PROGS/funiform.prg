PROCEDURE Uniform
xempnumber = xcurpaylst.empnumber
SELECT * FROM CurUniformOpt WHERE  ;
         empnumber = xempnumber  ;
         INTO CURSOR x
IF RECCOUNT('x') = 0
     RETURN
ENDIF
SELECT xcurpaylst
xamt = (3.28767123287671) *  ;
       xcurpaylst.e001_2
REPLACE e025 WITH xamt
ENDPROC
**
