PROCEDURE IncentiveLeave
PARAMETER xdefbasic, xcolarate,  ;
          xcolaflag, xctparate,  ;
          xsearate

SQLEXEC(nconn, "SELECT * FROM " +  xpay + ".acctconfig", "x")
mil 			= x.incentiveleave
mctpacode 		= x.ctpa
mctpacodelh 	= x.ctpa_lh
mseacode 		= x.sea
mseacodelh 		= x.sea_lh
xempnumber 		= xcurpaylst.empnumber

SELECT * FROM curPayLst WHERE empnumber = xempnumber  INTO CURSOR x

xbasicrate 		= 0
IF x.basicrate 	= 0
     xbasicrate = xdefbasic
ELSE
     xbasicrate = x.basicrate
ENDIF

IF x.rateid = 2
     xbasicrate = xbasicrate
ENDIF

IF x.rateid = 3
     xbasicrate = xbasicrate / 15
ENDIF

IF 	x.rateid = 1
    xbasicrate = xbasicrate * 12 / 393.5
ENDIF
IF xcolaflag = 1
     xamt = (xbasicrate +  xcolarate) * 5 / 12 /  30 *  xcurpaylst.e001_2
ELSE
     xamt = xbasicrate * 5 / 12 /  30 *  xcurpaylst.e001_2
ENDIF

maddition = 0
SELECT xcurpaylst
maddition = maddition + NVL((5 / 12 /30 * &mctpacode),0) 
maddition = maddition + NVL((5 / 12 /30 * &mseaCode),0) 
SELECT xcurpaylst

REPLACE &mil  WITH xamt + maddition 
