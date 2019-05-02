**
FUNCTION SQL_ERR_HANDLER
LPARAMETERS nflag AS INTEGER,  ;
            nconnhandler AS  ;
            INTEGER
IF nflag < 1
     SQLROLLBACK(nconnhandler)
     SQLDISCONNECT(nconnhandler)
     MESSAGEBOX( ;
               "FATAL ERROR! Transaction Aborted. Report this error to your administrator immediately.",  ;
               "WARNING")
     QUIT
ENDIF
RETURN 0
ENDFUNC
**
FUNCTION PeriodCovered
LPARAMETERS cyymmpp AS STRING
cyy = LEFT(cyymmpp, 2)
cmm = RIGHT(LEFT(cyymmpp, 4), 2)
IF RIGHT(cyymmpp, 2) == "01"
     ddatefrom = CTOD(cmm + "/1/" +  ;
                 cyy)
     ddateto = CTOD(cmm + "/15/" +  ;
               cyy)
ELSE
     ddatefrom = CTOD(cmm +  ;
                 "/16/" + cyy)
     ddateto = GOMONTH(CTOD(cmm +  ;
               "/01/" + cyy), 1) -  ;
               1
ENDIF
RETURN "Period Covered: " +  ;
       MDY(ddatefrom) + " to " +  ;
       MDY(ddateto)
ENDFUNC
**
FUNCTION PYR_HEADER
LPARAMETERS nfilehwnd AS INTEGER
TRY
     cbatchz = " Batch: " +  ;
               ALLTRIM(curpyr.batch)
CATCH
     cbatchz = ""
ENDTRY
ch1 = SPACE(fileloc.wscospace) +  ;
      ALLTRIM(UPPER(fileloc.coname))
ch2 = SPACE(fileloc.wsadspace) +  ;
      ALLTRIM(fileloc.coadd)
ch3 = ""
ch4 = "                                                                                                     P A Y R O L L    R E G I S T E R"
ch5 = "                                                                                                     ================================"
ch6 = " Page:" +  ;
      PADL(ALLTRIM(STR(npagecount)),  ;
      4, SPACE(1))
ch7 = " " +  ;
      periodcovered(LEFT(curpyr.trn,  ;
      6)) + NVL(cbatchz, "")
ch7a = " Client: " +  ;
       ALLTRIM(curpyr.clname)
ch8 = PADL("RUN DATE: " +  ;
      TTOC(DATETIME()), 232,  ;
      SPACE(1))
ch9 = "          We hereby acknowledge to have received from " +  ;
      ALLTRIM(UPPER(fileloc.coname)) +  ;
      ", the sum specified opposite our respective name as full compensation for our service rendered."
ch10 = "+======================================================================================================================================================================================================================================+"
ch11 = "|    EMPLOYEE NAME / SIGNATURE     |"
ch12 = "|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|"
= FPUTS(lnfile, ch1)
= FPUTS(lnfile, ch2)
= FPUTS(lnfile, ch3)
= FPUTS(lnfile, ch4)
= FPUTS(lnfile, ch5)
= FPUTS(lnfile, ch6)
= FPUTS(lnfile, ch7)
= FPUTS(lnfile, ch7a)
= FPUTS(lnfile, ch8)
= FPUTS(lnfile, ch9)
= FPUTS(lnfile, ch10)
SELECT curfdesc
GOTO TOP
ctoput = ""
ctoputfinal = ch11
nfinalle = 0
ndtlgrp = 0
DO WHILE  .NOT. EOF("curFDESC")
     IF USED("curTmp")
          SELECT curtmp
          USE
     ENDIF
     SELECT acctname, shortdesc  ;
            FROM curCOF WHERE  ;
            UPPER(acctnumber) ==  ;
            curfdesc.fname INTO  ;
            CURSOR "curTmp"
     IF RECCOUNT("curTmp") < 1
          cacctname = curfdesc.fname
     ELSE
          IF ALLTRIM(curtmp.shortdesc) ==  ;
             ""
               cacctname = ALLTRIM(curtmp.acctname)
          ELSE
               cacctname = ALLTRIM(curtmp.shortdesc)
          ENDIF
     ENDIF
     SELECT curfdesc
     IF curfdesc.isshown < 1
          SKIP
          LOOP
     ENDIF
     DO CASE
          CASE curfdesc.ishrs > 0
               ctoput = PADL(ALLTRIM(cacctname) +  ;
                        IIF(curfdesc.ishrs =  ;
                        1, " hrs",  ;
                        " days"),  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|" +  ;
                        PADL(ALLTRIM(cacctname) +  ;
                        " amt",  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
          OTHERWISE
               ctoput = PADL(ALLTRIM(cacctname),  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
     ENDCASE
     IF (LEN(ctoputfinal) +  ;
        LEN(ctoput)) <= ntotal_x
          ctoputfinal = ctoputfinal +  ;
                        ctoput
          nfinalle = 1
          SKIP
     ELSE
          nfinalle = 0
          = FPUTS(lnfile,  ;
            LEFT(ctoputfinal,  ;
            LEN(ctoputfinal) - 1) +  ;
            PADL("|", ntotal_x -  ;
            LEN(ctoputfinal) + 1,  ;
            SPACE(1)))
          ndtlgrp = ndtlgrp + 1
          ctoputfinal = "|                                  |"
          LOOP
     ENDIF
ENDDO
IF nfinalle = 1
     = FPUTS(lnfile,  ;
       LEFT(ctoputfinal,  ;
       LEN(ctoputfinal) - 1) +  ;
       PADL("|", ntotal_x -  ;
       LEN(ctoputfinal) + 1,  ;
       SPACE(1)))
     ndtlgrp = ndtlgrp + 1
ENDIF
FPUTS(lnfile, ch12)
RETURN 0
ENDFUNC
**
PROCEDURE PYR_PAGETOTAL
LPARAMETERS nfilehwnd AS INTEGER
ch10 = "+======================================================================================================================================================================================================================================+"
SELECT curfdesc
GOTO TOP
ctoput = ""
ctoputfinal = "| P A G E  T O T A L               |"
nfinalle = 0
DO WHILE  .NOT. EOF("curFDESC")
     cfname = curfdesc.fname
     ccmd = "cAmt = TRANSFORM(curPageTotal." +  ;
            cfname +  ;
            ",'99,999,999.99')"
     &ccmd
     SELECT curfdesc
     IF curfdesc.isshown < 1
          SKIP
          LOOP
     ENDIF
     DO CASE
          CASE curfdesc.ishrs > 0
               ccmd = "cAmt2 = TRANSFORM(curPageTotal." +  ;
                      cfname +  ;
                      "_" +  ;
                      ALLTRIM(STR(curfdesc.ishrs)) +  ;
                      ",'99,999,999.99')"
               &ccmd
               ctoput = PADL(camt2,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|" +  ;
                        PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
          OTHERWISE
               ctoput = PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
     ENDCASE
     IF (LEN(ctoputfinal) +  ;
        LEN(ctoput)) <= ntotal_x
          ctoputfinal = ctoputfinal +  ;
                        ctoput
          nfinalle = 1
          SKIP
     ELSE
          nfinalle = 0
          = FPUTS(lnfile,  ;
            LEFT(ctoputfinal,  ;
            LEN(ctoputfinal) - 1) +  ;
            PADL("|", ntotal_x -  ;
            LEN(ctoputfinal) + 1,  ;
            SPACE(1)))
          ctoputfinal = "|                                  |"
          LOOP
     ENDIF
ENDDO
IF nfinalle = 1
     = FPUTS(lnfile,  ;
       LEFT(ctoputfinal,  ;
       LEN(ctoputfinal) - 1) +  ;
       PADL("|", ntotal_x -  ;
       LEN(ctoputfinal) + 1,  ;
       SPACE(1)))
ENDIF
FPUTS(lnfile, ch13)
SELECT curpagetotal
FOR i = 6 TO  ;
    FCOUNT("curPageTotal")
     cfname = UPPER(ALLTRIM(FIELD(i)))
     ccmd = "UPDATE curPageTotal SET " +  ;
            cfname + " = 0"
     &ccmd
ENDFOR
ENDPROC
**
PROCEDURE PYR_CLIENTTOTAL
LPARAMETERS nfilehwnd AS INTEGER
ch10 = "+======================================================================================================================================================================================================================================+"
SELECT curfdesc
GOTO TOP
ctoput = ""
ctoputfinal = "| C L I E N T  T O T A L           |"
nfinalle = 0
DO WHILE  .NOT. EOF("curFDESC")
     cfname = curfdesc.fname
     ccmd = "cAmt = TRANSFORM(curClientTotal." +  ;
            cfname +  ;
            ",'99,999,999.99')"
     &ccmd
     SELECT curfdesc
     IF curfdesc.isshown < 1
          SKIP
          LOOP
     ENDIF
     DO CASE
          CASE curfdesc.ishrs > 0
               ccmd = "cAmt2 = TRANSFORM(curClientTotal." +  ;
                      cfname +  ;
                      "_" +  ;
                      ALLTRIM(STR(curfdesc.ishrs)) +  ;
                      ",'99,999,999.99')"
               &ccmd
               ctoput = PADL(camt2,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|" +  ;
                        PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
          OTHERWISE
               ctoput = PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
     ENDCASE
     IF (LEN(ctoputfinal) +  ;
        LEN(ctoput)) <= ntotal_x
          ctoputfinal = ctoputfinal +  ;
                        ctoput
          nfinalle = 1
          SKIP
     ELSE
          nfinalle = 0
          = FPUTS(lnfile,  ;
            LEFT(ctoputfinal,  ;
            LEN(ctoputfinal) - 1) +  ;
            PADL("|", ntotal_x -  ;
            LEN(ctoputfinal) + 1,  ;
            SPACE(1)))
          ctoputfinal = "|                                  |"
          LOOP
     ENDIF
ENDDO
IF nfinalle = 1
     = FPUTS(lnfile,  ;
       LEFT(ctoputfinal,  ;
       LEN(ctoputfinal) - 1) +  ;
       PADL("|", ntotal_x -  ;
       LEN(ctoputfinal) + 1,  ;
       SPACE(1)))
ENDIF
FPUTS(lnfile, ch10)
IF  .NOT. curtmp.trn == ctrn
     SELECT curclienttotal
     FOR i = 6 TO  ;
         FCOUNT("curClientTotal")
          cfname = UPPER(ALLTRIM(FIELD(i)))
          ccmd = "UPDATE curClientTotal SET " +  ;
                 cfname + " = 0"
          &ccmd
     ENDFOR
ENDIF
ENDPROC
**
PROCEDURE PYR_GrandTOTAL
LPARAMETERS nfilehwnd AS INTEGER
ch10 = "+======================================================================================================================================================================================================================================+"
SELECT curfdesc
GOTO TOP
ctoput = ""
ctoputfinal = "| G R A N D    T O T A L           |"
nfinalle = 0
DO WHILE  .NOT. EOF("curFDESC")
     cfname = curfdesc.fname
     ccmd = "cAmt = TRANSFORM(curClientTotal." +  ;
            cfname +  ;
            ",'99,999,999.99')"
     &ccmd
     SELECT curfdesc
     IF curfdesc.isshown < 1
          SKIP
          LOOP
     ENDIF
     DO CASE
          CASE curfdesc.ishrs > 0
               ccmd = "cAmt2 = TRANSFORM(curClientTotal." +  ;
                      cfname +  ;
                      "_" +  ;
                      ALLTRIM(STR(curfdesc.ishrs)) +  ;
                      ",'99,999,999.99')"
               &ccmd
               ctoput = PADL(camt2,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|" +  ;
                        PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
          OTHERWISE
               ctoput = PADL(camt,  ;
                        13,  ;
                        SPACE(1)) +  ;
                        "|"
     ENDCASE
     IF (LEN(ctoputfinal) +  ;
        LEN(ctoput)) <= ntotal_x
          ctoputfinal = ctoputfinal +  ;
                        ctoput
          nfinalle = 1
          SKIP
     ELSE
          nfinalle = 0
          = FPUTS(lnfile,  ;
            LEFT(ctoputfinal,  ;
            LEN(ctoputfinal) - 1) +  ;
            PADL("|", ntotal_x -  ;
            LEN(ctoputfinal) + 1,  ;
            SPACE(1)))
          ctoputfinal = "|                                  |"
          LOOP
     ENDIF
ENDDO
IF nfinalle = 1
     = FPUTS(lnfile,  ;
       LEFT(ctoputfinal,  ;
       LEN(ctoputfinal) - 1) +  ;
       PADL("|", ntotal_x -  ;
       LEN(ctoputfinal) + 1,  ;
       SPACE(1)))
ENDIF
FPUTS(lnfile, ch10)
IF  .NOT. curtmp.trn == ctrn
     SELECT curclienttotal
     FOR i = 6 TO  ;
         FCOUNT("curClientTotal")
          cfname = UPPER(ALLTRIM(FIELD(i)))
          ccmd = "UPDATE curClientTotal SET " +  ;
                 cfname + " = 0"
          &ccmd
     ENDFOR
ENDIF
ENDPROC
**
