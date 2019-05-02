PROCEDURE ToPDF
PARAMETER creportname AS STRING,  cfilter AS STRING
mpdfExe = ALLTRIM(fileloc.pdfLoc)
IF !FILE(mpdfExe)
	RETURN 
ENDIF 

TRY
     IF cfilter == .F.
          cfilter = ""
     ENDIF
CATCH
ENDTRY

SET PROCEDURE TO utilityReportListener.prg ADDITIVE

LOCAL loxfrx, lnretval

loxfrx 		= xfrx("XFRX#LISTENER")
lnretval 	= loxfrx.setparams("output.pdf",  ,  .T.,  ,  ,  , "PDF")

IF lnretval = 0
     
     ccmd = "REPORT FORM " +  creportname + " " +  ;
            cfilter +  " OBJECT loxfrx"
     &cCmd
     
     *RUN (mpdfExe "output.pdf")
     
     mcomm = "run(" + '"' + mpdfExe + '" "output.pdf")'
	&mcomm
ELSE
     MESSAGEBOX("PDF program execution is invalid.",  "Error Encountered")
ENDIF
