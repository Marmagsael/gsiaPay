FUNCTION MealAllowance
mempnumber = ALLTRIM(xcurpaylst.empnumber)
nclmallow = curclmealallow.mealallow

SELECT * FROM CurMealAllowOpt  WHERE ALLTRIM(empnumber) ==  ALLTRIM(mempnumber) INTO  CURSOR x READWRITE
IF RECCOUNT('x') = 0
     INSERT INTO x (empnumber,  mealallow, ismgr)  VALUES (mempnumber,  nclmallow, 0)
ENDIF

IF nclmallow = 0
     SELECT xcurpaylst
     REPLACE e029 WITH 0
     RETURN 0
ENDIF

IF x.mealallow = 0
     UPDATE x SET mealallow = nclmallow
ENDIF

xmealallowamt = xcurpaylst.e001_2 *  x.mealallow
IF x.ismgr = 0
     hrscnt = 0
     SELECT curmealallow
     SCAN ALL
          xfld = ALLTRIM(acctnumber) +  "_" +  ALLTRIM(STR(timedmode))
          SELECT xcurpaylst
          xcomm = "HrsCnt = HrsCnt + " +  xfld
          &xcomm 
          SELECT curmealallow
     ENDSCAN
     xmealallowamt = xmealallowamt +  (hrscnt / 4 *  (x.mealallow /  2))
ENDIF

SELECT xcurpaylst
REPLACE e029 WITH xmealallowamt
ENDFUNC
