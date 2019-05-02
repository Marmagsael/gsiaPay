FUNCTION ClassifyTax
PARAMETER fclientrate, fminrate
xval = .T.
xempnumber = xcurpaylst.empnumber
SELECT * FROM curpaylst WHERE  empnumber = xempnumber  INTO CURSOR x

xbasic = x.basicrate
xallow = 0

IF x.allowrate > 0
     xallow = (x.allowrate / 30)
ENDIF

IF x.rateid = 1
     xbasic = (xbasic / 30) +  ;
              xallow
ENDIF

IF x.rateid = 2
     xbasic = x.basicrate
ENDIF

IF x.rateid = 3
     xbasic = (xbasic / 15) +  ;
              xallow
ENDIF
IF xbasic = 0
     xbasic = fclientrate +  ;
              xallow
ENDIF
IF xbasic <= fminrate
     RETURN .F.
ENDIF
RETURN .T.
ENDFUNC
**
