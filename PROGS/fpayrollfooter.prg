**
FUNCTION TotalHrs
xhrs = xcurpaylst.e001_2 * 8
xhrs = xhrs + xcurpaylst.e003_1 +  ;
       xcurpaylst.e006_1 +  ;
       xcurpaylst.e008_1 +  ;
       xcurpaylst.e010_1 +  ;
       xcurpaylst.e012_1 +  ;
       xcurpaylst.e014_1
RETURN xhrs
MESSAGEBOX('Hi')
ENDFUNC
**
FUNCTION EmpBasicSal
RETURN xcurpaylst.e001
ENDFUNC
**
FUNCTION OtherEarnings
xamt = 0
SELECT * FROM CurFldLst WHERE  ;
         accttype = "E" INTO  ;
         CURSOR x
SELECT x
SCAN ALL
     xfld = "xCurPayLst." +  ;
            ALLTRIM(x.cd)
     xamt = xamt + &xfld 
ENDSCAN
RETURN xamt - xcurpaylst.e001
ENDFUNC
**
FUNCTION TotDeductions
xamt = 0
SELECT * FROM CurFldLst WHERE  ;
         accttype = "D" INTO  ;
         CURSOR x
SELECT x
SCAN ALL
     xfld = "xCurPayLst." +  ;
            ALLTRIM(x.cd)
     xamt = xamt + &xfld 
ENDSCAN
RETURN xamt
ENDFUNC
**
FUNCTION GetTaxCd
xempnumber = xempnumber
SELECT * FROM CurPayLst WHERE  ;
         empnumber = xempnumber  ;
         INTO CURSOR x
RETURN NVL(x.taxcode, "")
ENDFUNC
**
FUNCTION GetAllowance
xempnumber = xcurpaylst.empnumber
SELECT * FROM curPayLst WHERE  ;
         empnumber = xempnumber  ;
         INTO CURSOR x
RETURN NVL(x.allowrate, 0)
ENDFUNC
**
