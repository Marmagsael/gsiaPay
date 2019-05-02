Procedure SEA
Parameter xSEACoaCodeReg, ; 
		  xSEACoaCodeRD, ; 
		  xSEACoaCodeRegHol, ;
		  xSEACoaCodeRDRegHol, ;
		  xSEARate, ;
		  xSEADays, ;
		  xSEARDHr, ;
		  xSEARegHolHr, ;
		  xSEARegRDHolHr, ;
		  xSEASw    
	IF 	NVL(xSEASw,0) = 0 
		RETURN 
	ENDIF 
	IF 	NVL(xSEARate,0) = 0 
		RETURN 
	ENDIF 
	
	mSEA			= xSEARate * xSEADays
	*mSEARD			= (xSEARate/8) * NVL(xSEARDHr,0) 
	mSEARegHol		= (xSEARate/8) * NVL(xSEARegHolHr,0) 
	mSEARDRegHol	= (xSEARate/8) * NVL(xSEARegRDHolHr,0) 
		
	Select xcurpaylst
	Replace &xSEACoaCodeReg 		WITH mSEA, ;
			&xSEACoaCodeRegHol 		WITH mSEARegHol,; 
			&xSEACoaCodeRDRegHol 	WITH mSEARDRegHol
			
ENDPROC
