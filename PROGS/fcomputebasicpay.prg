PROCEDURE ComputeBasicPay
LPARAMETERS xacctcd, xdefbasic
	mempno = ALLTRIM(xcurpaylst.empnumber)
	SELECT * FROM CurPayLst WHERE  ;
	         empnumber = mempno INTO  ;
	         CURSOR x
	amt = 0
	IF x.rateid = 2
	     xbasic = x.basicrate
	     IF x.basicrate = 0
	          xbasic = xdefbasic
	     ENDIF
	     amt = xcurpaylst.e001_2 *  xbasic
	ENDIF
	IF RECCOUNT('x') = 0
	     xbasic = xdefbasic
	     amt = xcurpaylst.e001_2 *  xbasic
	ENDIF
	IF x.rateid = 3
	     amt = x.basicrate
	ENDIF
	IF x.rateid = 1
	     amt = x.basicrate / 2
	ENDIF
	IF amt = 0
	     amt = xcurpaylst.e001_2 *  xdefbasic
	ENDIF

	SELECT xcurpaylst
	REPLACE &xAcctCd  WITH Amt 
	REPLACE e016_2 WITH e001_2
ENDPROC
