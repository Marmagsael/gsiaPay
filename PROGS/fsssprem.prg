Procedure SSSPrem

	xempnumber = Alltrim(xcurpaylst.empnumber)
	
	*--- Test of for maximum amount -----------------------------------------------
	mmaxSSSAmt = 0 
	SELECT * FROM sssmax WHERE empnumber = xempnumber INTO CURSOR x 
	IF 	RECCOUNT('x') > 0 
		SELECT x 
		GO TOP 
		IF 	ismaxSSS = 1 
			SELECT sssMaxAmt 
			GO TOP 
			mmaxSSSAmt = fstart
		ENDIF 
	ENDIF 

	camt = 0	
	Select * From CurCOA Where  withsss = 1 And accttype =  "E" Into Cursor  xAcctSSS
	
	IF 	mmaxSSSAmt > 0 
		camt = mmaxSSSAmt
	ELSE 
		Select xAcctSSS
		Scan All
			xfld = xAcctSSS.acctnumber
			Select xcurpaylst
			camt = camt + NVL(&xfld,0)
			Select xAcctSSS
		ENDSCAN	
	ENDIF 
	*-----------------------------------------------------------------------------------------------------------
	Select * From CurTblTranCurrentMo  WHERE  ALLTRIM(acctnumber) ==  "D002" And  ALLTRIM(empnumber) ==  ;
		xempnumber Into Cursor  x		
	
	psssprem = Nvl(x.tamount, 0)
	
	Select Sum(tamount) As prevamt  FROM CurTblTranCurrentMo  WHERE acctnumber In ; 
			(Select acctnumber From xAcctSSS)  AND empnumber = xempnumber  INTO Cursor x

	psssamt 	= Nvl(x.prevamt, 0)
	totsssamt 	= Nvl(psssamt, 0) +  NVL(camt, 0)

	Select * From CurSSSMatrix Where BETWEEN(totsssamt, fstart, fend) Into CURSOR x

	mactualsssprem = x.fsssee - psssprem
	Select xcurpaylst
	Replace d002 With mactualsssprem
	Select xAcctSSS
	
Endproc
