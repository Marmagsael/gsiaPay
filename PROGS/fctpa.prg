**
PROCEDURE ctpa
PARAMETER xctpacoacodereg,  ;
          xctpacoacoderd,  ;
          xctpacoacodereghol,  ;
          xctpacoacoderdreghol,  ;
          xctparate, xctpadays,  ;
          xctpardhr,  ;
          xctparegholhr,  ;
          xctpardregholhr,  ;
          xctpasw
IF NVL(xctpasw, 0) = 0
     RETURN
ENDIF
IF NVL(xctparate, 0) = 0
     RETURN
ENDIF
mctpa = xctparate * xctpadays
mctpareghol = (xctparate / 8) *  ;
              NVL(xctparegholhr,  ;
              0)
mctpardreghol = (xctparate / 8) *  ;
                NVL(xctpardregholhr,  ;
                0)
SELECT xcurpaylst
Replace &xCTPACoaCodeReg   WITH mctpa,;
 &xCTPACoaCodeRegHol  WITH mctpaRegHol,;
 &xCTPACoaCodeRDRegHol  WITH mctpaRDRegHol;

ENDPROC
**
