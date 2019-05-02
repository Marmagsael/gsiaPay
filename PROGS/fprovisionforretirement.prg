PROCEDURE ProvisionForRetirement
PARAMETER xcorate
xempnumber = xcurpaylst.empnumber
SELECT * FROM CurRetOpt WHERE  empnumber = xempnumber  INTO CURSOR x
IF RECCOUNT('x') = 0
     RETURN
ENDIF
SELECT xcurpaylst
xamt = xcorate * 22.5  / 12 * 12 /  365 * xcurpaylst.e001_2
REPLACE e028 WITH xamt
ENDPROC
**
