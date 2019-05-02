**
DEFINE CLASS  ;
       utilityreportlistener AS  ;
       _reportlistener
frxdatasession = -1
readconfiguration = 0
targetfileext = ("TXT")
targetfilename = (FORCEPATH(SYS(2015),  ;
                 SYS(2023)))
targethandle = -1
configurationobjtype = 1000
frxcursor = (.NULL.)
PROTECTED configurationtable
configurationtable = ("")
loadfrxcursor = .F.
**
PROCEDURE readconfiguration_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "N"  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.readconfiguration =  ;
           m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE setconfiguration
     LPARAMETERS tlcalledfrominit
     IF  .NOT. this.isrunning
          LOCAL liselect, lcpem,  ;
                llopened, lcorder,  ;
                litype, llquiet
          liselect = SELECT(0)
          IF  .NOT.  ;
              USED("OutputConfig")
               llquiet = (tlcalledfrominit  ;
                         .AND.   ;
                         .NOT.  ;
                         this.quietmode)
               IF llquiet
                    this.quietmode =  ;
                     .T.
               ENDIF
               this.getconfigtable()
               IF llquiet
                    this.quietmode =  ;
                     .F.
               ENDIF
               USE SHARED  ;
                   NOUPDATE  ;
                   (this.configurationtable)  ;
                   AGAIN ALIAS  ;
                   "OutputConfig"  ;
                   IN 0
               llopened = .T.
          ELSE
               lcorder = ORDER("OutputConfig")
               SET ORDER TO ObjCode
          ENDIF
          IF ( .NOT.  ;
             this.haderror) .AND.  ;
             this.verifyconfigtable("OutputConfig")
               SELECT outputconfig
               litype = this.configurationobjtype
               SCAN FOR objtype =  ;
                    litype .AND.   ;
                    .NOT.  ;
                    (DELETED()  ;
                    .OR. objname ==  ;
                    "" .OR.  ;
                    objvalue ==  ;
                    "")
                    IF PEMSTATUS(this,  ;
                       objname,  ;
                       5)
                         lcpem = UPPER(PEMSTATUS(this,  ;
                                 objname,  ;
                                 3))
                         DO CASE
                              CASE  ;
                               lcpem ==  ;
                               "PROPERTY"
                                   STORE EVALUATE(objvalue) TO ("THIS." + objname)
                              CASE  ;
                               INLIST("|" +  ;
                               lcpem +  ;
                               "|",  ;
                               "|METHOD|",  ;
                               "|EVENT|")
                                   EVALUATE("THIS." + objname + "(" + objvalue + ")")
                              OTHERWISE
                         ENDCASE
                    ENDIF
               ENDSCAN
               IF llopened
                    USE IN  ;
                        outputconfig
               ELSE
                    SET ORDER IN outputconfig;
TO (lcorder)
               ENDIF
          ENDIF
          SELECT (liselect)
     ENDIF
ENDPROC
**
FUNCTION getconfigtable
     LPARAMETERS tlforceexternal
     LOCAL lcdbf, lcpath
     lcdbf = ""
     IF tlforceexternal .OR.  ;
        FILE(FULLPATH(FORCEEXT("OutputConfig",  ;
        "DBF")))
          lcdbf = FULLPATH(FORCEEXT("OutputConfig",  ;
                  "DBF"))
     ELSE
          lcdbf = FORCEEXT("_ReportOutputConfig",  ;
                  "DBF")
     ENDIF
     IF  .NOT. (FILE(lcdbf) .OR.  ;
         this.isrunning)
          lcpath = this.getpathforexternals()
          lcdbf = FORCEPATH(lcdbf,  ;
                  lcpath)
          IF  .NOT. FILE(lcdbf)
               lcdbf = FORCEEXT(FORCEPATH("OutputConfig",  ;
                       lcpath),  ;
                       "DBF")
               IF  .NOT.  ;
                   FILE(lcdbf)
                    this.createconfigtable(lcdbf)
                    IF FILE(lcdbf)
                         this.domessage( ;
                          "Configuration table " +  ;
                          lcdbf +  ;
                          " was created." ;
                          )
                    ENDIF
               ENDIF
          ENDIF
     ENDIF
     IF  .NOT. FILE(lcdbf)
          lcdbf = ""
     ENDIF
     this.configurationtable = lcdbf
     RETURN lcdbf
ENDFUNC
**
PROCEDURE createconfigtable
     LPARAMETERS tcdbf,  ;
                 tloverwrite
     LOCAL liselect, lcfile
     lcfile = FORCEEXT(tcdbf,  ;
              "DBF")
     IF FILE(lcfile) .AND.  ;
        tloverwrite
          ERASE (lcfile) RECYCLE
          ERASE (FORCEEXT(lcfile,  ;
                "FPT")) RECYCLE
          ERASE (FORCEEXT(lcfile,  ;
                "CDX")) RECYCLE
     ENDIF
     liselect = SELECT(0)
     SELECT 0
     CREATE TABLE (lcfile) FREE  ;
            (objtype I, objcode I,  ;
            objname V (60),  ;
            objvalue V (60),  ;
            objinfo M)
     IF  .NOT. EMPTY(ALIAS())
          INDEX ON objtype TAG  ;
                objtype
          INDEX ON objcode TAG  ;
                objcode
          INDEX ON objname TAG  ;
                objname
          INDEX ON objvalue TAG  ;
                objvalue
          INDEX ON DELETED() TAG  ;
                ondeleted
          INSERT INTO (ALIAS())  ;
                 VALUES (1000, 0,  ;
                 'DoMessage',  ;
                 '"Welcome to the demo run!",64',  ;
                 'Sample initialization/config method call' ;
                 )
          DELETE NEXT 1
          INSERT INTO (ALIAS())  ;
                 VALUES (1000, 0,  ;
                 'TargetFileName',  ;
                 '"xxx"',  ;
                 'Sample initialization/config property' ;
                 )
          DELETE NEXT 1
          USE
     ENDIF
     SELECT (liselect)
ENDPROC
**
PROTECTED FUNCTION opentargetfile
     this.verifytargetfile()
     this.targethandle = FCREATE(this.targetfilename)
     IF this.targethandle < 0  ;
        .OR. this.haderror
          this.haderror = .T.
          this.domessage("File " +  ;
                        this.targetfilename +  ;
                        " cannot be created.",  ;
                        16)
     ENDIF
     RETURN ( .NOT.  ;
            this.haderror)
ENDFUNC
**
PROCEDURE verifytargetfile
     LOCAL lcfile
     lcfile = ALLTRIM(CHRTRAN(this.targetfilename,  ;
              '?*"<>|', "_"))
     IF  .NOT.  ;
         DIRECTORY(JUSTPATH(lcfile))
          lcfile = FULLPATH(ALLTRIM(lcfile))
     ENDIF
     IF DIRECTORY(lcfile)
          lcfile = FORCEPATH(SYS(2015),  ;
                   lcfile)
     ENDIF
     this.targetfilename = lcfile
     IF JUSTEXT(this.targetfilename) ==  ;
        "" .AND.  ;
        RIGHT(this.targetfilename,  ;
        1) <> "."
          this.targetfileext = CHRTRAN(this.targetfileext,  ;
                               '?*"<>|',  ;
                               "_")
          this.targetfilename = FORCEEXT(this.targetfilename,  ;
                                this.targetfileext)
     ENDIF
     IF FILE(this.targetfilename)
          ERASE (this.targetfilename)
     ENDIF
ENDPROC
**
PROCEDURE targetfileext_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "C"  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.targetfileext = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE targetfilename_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "C"  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.targetfilename = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE targethandle_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "N"  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.targethandle = m.vnewval
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          closetargetfile
     LOCAL ladummy[1]
     IF this.targethandle > -1
          = FCLOSE(this.targethandle)
          this.targethandle = -1
          IF ADIR(ladummy,  ;
             this.targetfilename) =  ;
             1 .AND. ladummy(1,  ;
             2) > 0
               IF this.haderror
                    this.domessage(this.appname +  ;
                     " created your report as" +  ;
                     CHR(13) +  ;
                     this.targetfilename +  ;
                     ". " +  ;
                     CHR(13) +  ;
                     "However, an error occurred during processing." +  ;
                     CHR(13) +  ;
                     "Report execution was cancelled." +  ;
                     CHR(13) +  ;
                     "Your results are not complete.",  ;
                     48)
               ELSE
                    IF this.domessage(this.appname +  ;
                       " created your report as" +  ;
                       CHR(13) +  ;
                       this.targetfilename +  ;
                       "." +  ;
                       CHR(13) +  ;
                       IIF(this.allowmodalmessages,  ;
                       "Press 'Yes' to store" +  ;
                       CHR(13) +  ;
                       "this filename in the Clipboard.",  ;
                       "") +  ;
                       IIF(SYS(2024) =  ;
                       "Y",  ;
                       CHR(13) +  ;
                       "Report execution was cancelled." +  ;
                       CHR(13) +  ;
                       "Your results are not complete.",  ;
                       ""), 068) =  ;
                       6
                         _CLIPTEXT =  ;
                          this.targetfilename
                    ENDIF
               ENDIF
          ELSE
               this.domessage(this.appname +  ;
                             " was not able to create your report.",  ;
                             16)
          ENDIF
     ENDIF
ENDPROC
**
FUNCTION verifyconfigtable
     LPARAMETERS tcalias,  ;
                 tcfailuremsgtable,  ;
                 tcfailuremsgindexes
     IF EMPTY(tcalias) .OR.  ;
        VARTYPE(tcalias) <> "C"
          RETURN .F.
     ENDIF
     LOCAL lctable, lcmessage,  ;
           lcalias, liselect,  ;
           llreturn, litagcount,  ;
           larequired[1],  ;
           lakeys[1], lifound,  ;
           llexactoff,  ;
           llsafetyon
     llreturn = TYPE(tcalias +  ;
                ".OBJTYPE") = "N"  ;
                .AND.  ;
                TYPE(tcalias +  ;
                ".OBJCODE") = "N"  ;
                .AND.  ;
                TYPE(tcalias +  ;
                ".OBJNAME") = "C"  ;
                .AND.  ;
                TYPE(tcalias +  ;
                ".OBJVALUE") =  ;
                "C" .AND.  ;
                TYPE(tcalias +  ;
                ".OBJINFO") =  ;
                "M"
     IF  .NOT. llreturn
          lcmessage = IIF(EMPTY(tcfailuremsgtable),  ;
                      "Configuration table is not in correct format.",  ;
                      tcfailuremsgtable) +  ;
                      CHR(13) +  ;
                      CHR(13) +  ;
                      DBF(tcalias)
     ENDIF
     IF llreturn
          IF (SET("EXACT") =  ;
             "OFF")
               SET EXACT ON
               llexactoff = .T.
          ENDIF
          liselect = SELECT(0)
          SELECT (tcalias)
          DIMENSION larequired[5]
          larequired[1] =  ;
                    "OBJTYPE"
          larequired[2] =  ;
                    "OBJCODE"
          larequired[3] =  ;
                    "OBJNAME"
          larequired[4] =  ;
                    "OBJVALUE"
          larequired[5] =  ;
                    "DELETED()"
          IF TAGCOUNT() > 0
               DIMENSION lakeys[TAGCOUNT()]
               FOR litagcount = 1  ;
                   TO TAGCOUNT()
                    lakeys[litagcount] =  ;
                          UPPER(KEY(litagcount))
               ENDFOR
               FOR litagcount = 1  ;
                   TO  ;
                   ALEN(larequired)
                    lifound = ASCAN(lakeys,  ;
                              UPPER(larequired(litagcount)))
                    IF lifound =  ;
                       0
                         llreturn =  ;
                          .F.
                         EXIT
                    ENDIF
               ENDFOR
          ELSE
               llreturn = .F.
          ENDIF
          IF  .NOT. llreturn
               llsafetyon = (SET("SAFETY") =  ;
                            "ON")
               SET SAFETY OFF
               TRY
                    USE EXCLUSIVE  ;
                        (DBF(tcalias))  ;
                        ALIAS  ;
                        (tcalias)
                    INDEX ON  ;
                          objtype  ;
                          TAG  ;
                          objtype
                    INDEX ON  ;
                          objcode  ;
                          TAG  ;
                          objcode
                    INDEX ON  ;
                          objname  ;
                          TAG  ;
                          objname
                    INDEX ON  ;
                          objvalue  ;
                          TAG  ;
                          objvalue
                    INDEX ON  ;
                          DELETED()  ;
                          TAG  ;
                          ondeleted
                    llreturn = .T.
               CATCH
               ENDTRY
               IF llsafetyon
                    SET SAFETY OFF
               ENDIF
               IF llreturn
                    DIMENSION lakeys[TAGCOUNT()]
                    FOR litagcount =  ;
                        1 TO  ;
                        TAGCOUNT()
                         lakeys[litagcount] =  ;
                               UPPER(KEY(litagcount))
                    ENDFOR
                    FOR litagcount =  ;
                        1 TO  ;
                        ALEN(larequired)
                         lifound =  ;
                          ASCAN(lakeys,  ;
                          UPPER(larequired(litagcount)))
                         IF lifound =  ;
                            0
                              llreturn =  ;
                               .F.
                              EXIT
                         ENDIF
                    ENDFOR
               ENDIF
               USE SHARED  ;
                   (DBF(tcalias))  ;
                   ALIAS  ;
                   (tcalias)
          ENDIF
          IF  .NOT. llreturn
               lcmessage = IIF(EMPTY(tcfailuremsgindexes),  ;
                           "Configuration table is missing " +  ;
                           CHR(13) +  ;
                           "one or more required indexes.",  ;
                           tcfailuremsgtable) +  ;
                           CHR(13)
               FOR litagcount = 1  ;
                   TO  ;
                   ALEN(larequired)
                    lcmessage = lcmessage +  ;
                                CHR(13) +  ;
                                larequired(litagcount)
               ENDFOR
          ENDIF
          IF llexactoff
               SET EXACT OFF
          ENDIF
          SELECT (liselect)
     ENDIF
     IF  .NOT. (llreturn)
          this.domessage(lcmessage,  ;
                        16)
     ENDIF
     RETURN llreturn
ENDFUNC
**
FUNCTION getpathforexternals
     LOCAL lilevel, lcsys16,  ;
           lcpath
     FOR lilevel = PROGRAM(-1) TO  ;
         1 STEP -1
          lcsys16 = UPPER(SYS(16,  ;
                    lilevel))
          IF INLIST(RIGHT(lcsys16,  ;
             3), "APP", "EXE",  ;
             "DLL")
               lcpath = JUSTPATH(lcsys16)
               EXIT
          ENDIF
     ENDFOR
     IF EMPTY(lcpath)
          lcpath = JUSTPATH(this.classlibrary)
     ENDIF
     IF  .NOT. DIRECTORY(lcpath)
          lcpath = ""
     ENDIF
     RETURN lcpath
ENDFUNC
**
FUNCTION configurationobjtype_access
     RETURN 1000
ENDFUNC
**
FUNCTION Init
     IF DODEFAULT()
          IF INLIST(this.readconfiguration,  ;
             1, 3)
               this.setconfiguration(.T.)
          ENDIF
     ELSE
          RETURN .F.
     ENDIF
     RETURN  .NOT. this.haderror
ENDFUNC
**
PROCEDURE Destroy
     this.closetargetfile()
     STORE .NULL. TO  ;
           this.frxcursor
     DODEFAULT()
ENDPROC
**
PROCEDURE setfrxdatasessionenvironment
     DODEFAULT()
     SET DELETED ON
     SET EXCLUSIVE OFF
     SET TALK OFF
ENDPROC
**
PROCEDURE BeforeReport
     DODEFAULT()
     IF INLIST(this.readconfiguration,  ;
        2, 3)
          this.setconfiguration()
     ENDIF
ENDPROC
**
ENDDEFINE
**
DEFINE CLASS _reportlistener AS  ;
       reportlistener
height = 23
width = 23
frxdatasession = -1
allowmodalmessages = (INLIST(_VFP.startmode,  ;
                     0, 4))
quietmode = ( .NOT.  ;
            INLIST(_VFP.startmode,  ;
            0, 4))
appname = ("VFP Report Listener")
PROTECTED lasterrormessage
lasterrormessage = ("")
PROTECTED reportfilenames
reportfilenames = .NULL.
PROTECTED reportclauses
reportclauses = .NULL.
PROTECTED listeners
listeners = .NULL.
PROTECTED listenerdatasession
listenerdatasession = 1
successor = (.NULL.)
sharedgdiplusgraphics = 0
sharedpageheight = 0
sharedpagewidth = 0
PROTECTED drivingalias
drivingalias = ("")
sharedoutputpagecount = 0
sharedpageno = 0
sharedpagetotal = 0
name = "_reportlistener"
lignoreerrors = .F.
PROTECTED haderror
PROTECTED isrunning
PROTECTED isrunningreports
reportusesprivatedatasession = .F.
issuccessor = .F.
PROTECTED reportpages[1]
**
PROCEDURE allowmodalmessages_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "L"
          this.allowmodalmessages =  ;
           m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE lignoreerrors_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "L"
          this.lignoreerrors = m.vnewval
     ENDIF
ENDPROC
**
FUNCTION prepareerrormessage
     LPARAMETERS nerror, cmethod,  ;
                 nline, cname,  ;
                 cmessage,  ;
                 ccodeline
     LOCAL lcerrormessage,  ;
           lccodelinemsg
     IF VARTYPE(cmessage) = "C"
          lcerrormessage = cmessage
     ELSE
          lcerrormessage = MESSAGE()
     ENDIF
     lcerrormessage = lcerrormessage +  ;
                      CHR(13) +  ;
                      CHR(13)
     IF VARTYPE(cname) = "C"
          lcerrormessage = lcerrormessage +  ;
                           cname
     ELSE
          lcerrormessage = lcerrormessage +  ;
                           this.name
     ENDIF
     lcerrormessage = lcerrormessage +  ;
                      CHR(13) +  ;
                      "Error:           " +  ;
                      ALLTRIM(STR(nerror)) +  ;
                      CHR(13) +  ;
                      "Method:       " +  ;
                      LOWER(ALLTRIM(cmethod))
     IF VARTYPE(ccodeline) = "C"
          lccodelinemsg = ccodeline
     ELSE
          lccodelinemsg = MESSAGE(1)
     ENDIF
     IF BETWEEN(nline, 1, 100000)  ;
        .AND.  .NOT.  ;
        lccodelinemsg = "..."
          lcerrormessage = lcerrormessage +  ;
                           CHR(13) +  ;
                           "Line:            " +  ;
                           ALLTRIM(STR(nline))
          IF  .NOT.  ;
              EMPTY(lccodelinemsg)
               lcerrormessage = lcerrormessage +  ;
                                CHR(13) +  ;
                                CHR(13) +  ;
                                lccodelinemsg
          ENDIF
     ENDIF
     RETURN lcerrormessage
ENDFUNC
**
PROTECTED PROCEDURE  ;
          pushglobalsets
**
** ReFox - this procedure is  ;
   empty **
**
ENDPROC
**
PROTECTED PROCEDURE popglobalsets
**
** ReFox - this procedure is  ;
   empty **
**
ENDPROC
**
PROCEDURE clearerrors
     this.haderror = .F.
     this.lasterrormessage = ""
ENDPROC
**
FUNCTION getlasterrormessage
     RETURN this.lasterrormessage
ENDFUNC
**
PROCEDURE addreport
     LPARAMETERS tcfrxname,  ;
                 tcclauses,  ;
                 tolistener
     IF VARTYPE(tcfrxname) = "C"  ;
        .AND. (FILE(tcfrxname)  ;
        .OR.  ;
        FILE(FORCEEXT(tcfrxname,  ;
        "FRX")) .OR.  ;
        FILE(FORCEEXT(tcfrxname,  ;
        "LBX")))
          IF ISNULL(this.reportfilenames)  ;
             .OR.  ;
             ISNULL(this.reportclauses)  ;
             .OR.  ;
             ISNULL(this.listeners)
               this.reportfilenames =  ;
                CREATEOBJECT("Collection")
               this.reportclauses =  ;
                CREATEOBJECT("Collection")
               this.listeners = CREATEOBJECT("Collection")
               DIMENSION this.reportpages[1]
          ENDIF
          this.reportfilenames.add(tcfrxname)
          DIMENSION this.reportpages[this.reportfilenames.count]
          this.reportpages[this.reportfilenames.count] =  ;
                          0
          IF VARTYPE(tcclauses) =  ;
             "C"
               this.reportclauses.add(tcclauses)
          ELSE
               this.reportclauses.add("")
          ENDIF
          IF TYPE("toListener.BaseClass") =  ;
             "C" .AND.  ;
             UPPER(tolistener.baseclass) ==  ;
             "REPORTLISTENER"
               this.listeners.add(tolistener)
          ELSE
               this.listeners.add(.NULL.)
          ENDIF
     ELSE
     ENDIF
ENDPROC
**
PROCEDURE removereports
     IF  .NOT.  ;
         (this.isrunningreports)
          this.reportfilenames = .NULL.
          this.reportclauses = .NULL.
          this.listeners = .NULL.
          DIMENSION this.reportpages[1]
          this.reportpages[1] = 0
     ENDIF
ENDPROC
**
PROCEDURE runreports
     LPARAMETERS tlremovereportsafterrun,  ;
                 tlomitlistenerreferences
     IF  .NOT.  ;
         (this.isrunningreports  ;
         .OR.  ;
         ISNULL(this.reportfilenames)  ;
         .OR.  ;
         this.reportfilenames.count =  ;
         0)
          LOCAL oerror, liindex,  ;
                lcclauses,  ;
                lolistener
          oerror = .NULL.
          this.isrunningreports =  ;
           .T.
          TRY
               FOR liindex = 1 TO  ;
                   this.reportfilenames.count
                    lcclauses = UPPER(this.reportclauses(liindex))
                    lolistener = this.listeners(liindex)
                    DO CASE
                         CASE " OBJE " $  ;
                              STRTRAN( ;
                              " " +  ;
                              lcclauses,  ;
                              "CT",  ;
                              " " ;
                              )  ;
                              .OR.  ;
                              " OBJEC " $  ;
                              " " +  ;
                              lcclauses  ;
                              .OR.  ;
                              tlomitlistenerreferences
                              REPORT FORM;
(THIS.ReportFileNames[liIndex]) &lcClauses;

                         CASE ISNULL(lolistener)
                              REPORT FORM;
(THIS.ReportFileNames[liIndex]) &lcClauses;
OBJECT THIS
                         OTHERWISE
                              REPORT FORM;
(THIS.ReportFileNames[liIndex]) &lcClauses;
OBJECT loListener
                    ENDCASE
                    IF  .NOT. ( ;
                        " NOWA " $  ;
                        STRTRAN( ;
                        " " +  ;
                        lcclauses,  ;
                        "IT",  ;
                        " ") .OR.  ;
                        " NOWAI " $  ;
                        " " +  ;
                        lcclauses)
                         this.reportpages[liindex] =  ;
                          this.sharedpagetotal
                    ENDIF
               ENDFOR
          CATCH TO oerror
               IF  .NOT.  ;
                   (ISNULL(oerror))
                    this.domessage(this.prepareerrormessage(oerror.errorno,  ;
                     oerror.procedure,  ;
                     oerror.lineno,  ;
                     this.appname,  ;
                     oerror.message,  ;
                     oerror.linecontents),  ;
                     16)
                    EXIT
               ENDIF
          FINALLY
               this.isrunningreports =  ;
                .F.
               IF tlremovereportsafterrun
                    this.removereports()
               ENDIF
               STORE .NULL. TO  ;
                     lolistener,  ;
                     oerror
          ENDTRY
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          setfrxdatasessionenvironment
     this.setfrxdatasession()
     SET TALK OFF
ENDPROC
**
FUNCTION invokeoncurrentpass
     RETURN .T.
ENDFUNC
**
PROTECTED PROCEDURE  ;
          resetdatasession
     IF (this.listenerdatasession > - ;
        1)
          TRY
               SET DATASESSION TO (this.listenerdatasession)
          CATCH WHEN .T.
               this.resettodefault("listenerDataSession")
          ENDTRY
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          setfrxdatasession
     IF (this.frxdatasession > - ;
        1) .AND.  ;
        (this.frxdatasession <>  ;
        SET("DATASESSION"))
          TRY
               SET DATASESSION TO (this.frxdatasession)
          CATCH WHEN .T.
               this.resettodefault("FRXDataSession")
          ENDTRY
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          setcurrentdatasession
     IF (this.currentdatasession <>  ;
        SET("DATASESSION"))
          TRY
               SET DATASESSION TO (this.currentdatasession)
          CATCH WHEN .T.
               this.resettodefault("CurrentDataSession")
          ENDTRY
     ENDIF
ENDPROC
**
PROCEDURE quietmode_assign
     LPARAMETERS vnewval
     IF VARTYPE(m.vnewval) = "L"
          this.quietmode = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE issuccessor_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "L"
          this.issuccessor = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE successor_assign
     LPARAMETERS vnewval
     IF ( .NOT. this.isrunning)  ;
        .AND. (ISNULL(vnewval)  ;
        .OR. (VARTYPE(vnewval) =  ;
        "O" .AND.  ;
        UPPER(vnewval.baseclass) ==  ;
        "REPORTLISTENER"))
          this.successor = m.vnewval
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          getfrxstartupinfo
     this.setfrxdatasession()
     IF USED("FRX")
          SELECT frx
          LOCATE FOR objtype = 25
          this.reportusesprivatedatasession =  ;
           frx.environ
     ELSE
          this.reportusesprivatedatasession =  ;
           .F.
     ENDIF
     this.setcurrentdatasession()
     IF this.reportusesprivatedatasession
          SET TALK OFF
     ENDIF
     this.drivingalias = UPPER(ALIAS())
ENDPROC
**
PROCEDURE setsuccessordynamicproperties
     IF  .NOT. this.issuccessor
          this.sharedoutputpagecount =  ;
           this.outputpagecount
          this.sharedpagetotal = this.pagetotal
          this.sharedpageno = this.pageno
          this.sharedgdiplusgraphics =  ;
           this.gdiplusgraphics
     ENDIF
     WITH this.successor
          .currentpass = this.currentpass
          .twopassprocess = this.twopassprocess
          .sharedoutputpagecount =  ;
           this.sharedoutputpagecount
          .sharedpagetotal = this.sharedpagetotal
          .sharedpageno = this.sharedpageno
          .sharedgdiplusgraphics =  ;
           this.sharedgdiplusgraphics
     ENDWITH
ENDPROC
**
PROCEDURE appname_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "C"
          this.appname = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE sharedgdiplusgraphics_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedgdiplusgraphics =  ;
           m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE sharedpageheight_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedpageheight =  ;
           m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE sharedpagewidth_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedpagewidth = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE listenertype_assign
     LPARAMETERS vnewval
     IF this.supportslistenertype(vnewval)  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.listenertype = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE outputtype_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"  ;
        .AND.  .NOT.  ;
        this.isrunning
          this.outputtype = INT(m.vnewval)
          IF this.supportslistenertype(this.outputtype)
               this.listenertype =  ;
                this.outputtype
          ENDIF
     ENDIF
ENDPROC
**
PROCEDURE sharedoutputpagecount_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedoutputpagecount =  ;
           m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE sharedpageno_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedpageno = m.vnewval
     ENDIF
ENDPROC
**
PROCEDURE sharedpagetotal_assign
     LPARAMETERS vnewval
     IF VARTYPE(vnewval) = "N"
          this.sharedpagetotal = m.vnewval
     ENDIF
ENDPROC
**
PROTECTED PROCEDURE  ;
          setfrxrunstartupconditions
     IF ISNULL(this.commandclauses)
          this.commandclauses = CREATEOBJECT("Empty")
     ENDIF
     IF TYPE("THIS.CommandClauses.NoDialog") <>  ;
        "L"
          ADDPROPERTY(this.commandclauses,  ;
                     "NoDialog",  ;
                     .F.)
     ENDIF
ENDPROC
**
PROCEDURE DoStatus
     LPARAMETERS cmessage
     NODEFAULT
     IF  .NOT. (this.quietmode  ;
         .OR. (this.isrunning  ;
         .AND.  ;
         this.commandclauses.nodialog))
          IF this.twopassprocess  ;
             .AND.  ;
             this.currentpass =  ;
             0
               WAIT WINDOW NOWAIT  ;
                    "Running calculation prepass... "
          ELSE
               IF VARTYPE(cmessage) =  ;
                  "C"
                    DODEFAULT(cmessage)
               ENDIF
          ENDIF
     ENDIF
ENDPROC
**
PROCEDURE LoadReport
     this.clearerrors()
     this.setfrxdatasessionenvironment()
     this.resetdatasession()
     IF  .NOT.  ;
         ISNULL(this.successor)
          WITH this.successor
               .addproperty("IsSuccessor",  ;
                           .T.)
               .outputtype = this.outputtype
               .printjobname = this.printjobname
               .commandclauses = this.commandclauses
               .loadreport()
          ENDWITH
     ENDIF
ENDPROC
**
PROCEDURE ClearStatus
     DODEFAULT()
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.clearstatus()
     ENDIF
ENDPROC
**
PROCEDURE UpdateStatus
     DODEFAULT()
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.updatestatus()
     ENDIF
ENDPROC
**
PROCEDURE UnloadReport
     IF  .NOT. this.issuccessor
          this.sharedpagewidth = this.getpagewidth()
          this.sharedpageheight =  ;
           this.getpageheight()
     ENDIF
     this.resetdatasession()
     IF  .NOT.  ;
         ISNULL(this.successor)
          WITH this.successor
               .frxdatasession = this.frxdatasession
               .currentdatasession =  ;
                this.currentdatasession
               .twopassprocess = this.twopassprocess
               .commandclauses = this.commandclauses
               .sharedpageheight =  ;
                this.sharedpageheight
               .sharedpagewidth =  ;
                this.sharedpagewidth
               this.setsuccessordynamicproperties()
               .unloadreport()
               .issuccessor = .F.
          ENDWITH
     ENDIF
ENDPROC
**
PROCEDURE CancelReport
     IF  .NOT. this.issuccessor
          DODEFAULT()
          NODEFAULT
     ENDIF
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.cancelreport()
     ENDIF
ENDPROC
**
PROCEDURE AfterReport
     IF  .NOT. this.issuccessor
          this.sharedpagewidth = this.getpagewidth()
          this.sharedpageheight =  ;
           this.getpageheight()
     ENDIF
     IF  .NOT.  ;
         ISNULL(this.successor)
          WITH this.successor
               .frxdatasession = this.frxdatasession
               .currentdatasession =  ;
                this.currentdatasession
               .twopassprocess = this.twopassprocess
               .commandclauses = this.commandclauses
               .sharedpageheight =  ;
                this.sharedpageheight
               .sharedpagewidth =  ;
                this.sharedpagewidth
               this.setsuccessordynamicproperties()
               .afterreport()
          ENDWITH
     ENDIF
     IF  .NOT. this.issuccessor
          NODEFAULT
          DODEFAULT()
     ENDIF
ENDPROC
**
FUNCTION Init
     this.listenerdatasession = SET("DATASESSION")
     IF DODEFAULT()
          this.appname = "VFP Report Output Class"
     ELSE
          RETURN .F.
     ENDIF
     RETURN  .NOT. this.haderror
ENDFUNC
**
PROCEDURE BeforeBand
     LPARAMETERS nbandobjcode,  ;
                 nfrxrecno
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.beforeband(nbandobjcode,  ;
           nfrxrecno)
     ENDIF
ENDPROC
**
FUNCTION DoMessage
     LPARAMETERS cmessage,  ;
                 iparams, ctitle
     NODEFAULT
     IF this.quietmode .OR.  ;
        (this.isrunning .AND.  ;
        this.commandclauses.nodialog)
          RETURN 0
     ELSE
          IF this.allowmodalmessages
               IF VARTYPE(ctitle) =  ;
                  "C"
                    RETURN MESSAGEBOX(TRANSFORM(cmessage),  ;
                           VAL(TRANSFORM(iparams)),  ;
                           ctitle)
               ELSE
                    RETURN MESSAGEBOX(TRANSFORM(cmessage),  ;
                           VAL(TRANSFORM(iparams)),  ;
                           this.appname)
               ENDIF
          ELSE
               this.dostatus(cmessage)
               RETURN 0
          ENDIF
     ENDIF
ENDFUNC
**
FUNCTION Error
     LPARAMETERS nerror, cmethod,  ;
                 nline
     LOCAL lconerror, lcerrormsg,  ;
           lccodelinemsg
     this.haderror = .T.
     IF this.lignoreerrors .OR.  ;
        _VFP.startmode > 0
          RETURN .F.
     ENDIF
     lconerror = UPPER(ALLTRIM(ON("ERROR")))
     IF  .NOT. EMPTY(lconerror)
          lconerror = STRTRAN(STRTRAN(STRTRAN(lconerror,  ;
                      "ERROR()",  ;
                      "nError"),  ;
                      "PROGRAM()",  ;
                      "cMethod"),  ;
                      "LINENO()",  ;
                      "nLine")
          &lcOnError
          RETURN
     ENDIF
     lcerrormsg = this.prepareerrormessage(nerror,  ;
                  cmethod,  ;
                  nline)
     this.lasterrormessage = lcerrormsg
     this.domessage(lcerrormsg,  ;
                   16)
ENDFUNC
**
PROCEDURE BeforeReport
     this.setfrxrunstartupconditions()
     this.getfrxstartupinfo()
     this.setcurrentdatasession()
     IF  .NOT. this.issuccessor
          this.sharedpageheight =  ;
           this.getpageheight()
          this.sharedpagewidth = this.getpagewidth()
     ENDIF
     IF  .NOT.  ;
         ISNULL(this.successor)
          WITH this.successor
               .addproperty("sharedGDIPlusGraphics",  ;
                           this.sharedgdiplusgraphics)
               .addproperty("sharedPageHeight",  ;
                           this.sharedpageheight)
               .addproperty("sharedPageWidth",  ;
                           this.sharedpagewidth)
               .addproperty("sharedOutputPageCount",  ;
                           this.sharedoutputpagecount)
               .addproperty("sharedPageNo",  ;
                           this.sharedpageno)
               .addproperty("sharedPageTotal",  ;
                           this.sharedpagetotal)
               this.setsuccessordynamicproperties()
               .frxdatasession = this.frxdatasession
               .currentdatasession =  ;
                this.currentdatasession
               .twopassprocess = this.twopassprocess
               .commandclauses = this.commandclauses
               .beforereport()
          ENDWITH
     ENDIF
ENDPROC
**
PROCEDURE Destroy
     STORE .NULL. TO  ;
           this.successor,  ;
           this.listeners,  ;
           this.reportclauses,  ;
           this.reportfilenames,  ;
           this.previewcontainer,  ;
           this.commandclauses
ENDPROC
**
PROCEDURE AfterBand
     LPARAMETERS nbandobjcode,  ;
                 nfrxrecno
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.afterband(nbandobjcode,  ;
           nfrxrecno)
     ENDIF
ENDPROC
**
PROCEDURE Render
     LPARAMETERS nfrxrecno, nleft,  ;
                 ntop, nwidth,  ;
                 nheight,  ;
                 nobjectcontinuationtype,  ;
                 ccontentstoberendered,  ;
                 gdiplusimage
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.render(nfrxrecno,  ;
                               nleft,  ;
                               ntop,  ;
                               nwidth,  ;
                               nheight,  ;
                               nobjectcontinuationtype,  ;
                               ccontentstoberendered,  ;
                               gdiplusimage)
     ENDIF
ENDPROC
**
PROCEDURE EvaluateContents
     LPARAMETERS nfrxrecno,  ;
                 oobjproperties
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.evaluatecontents(nfrxrecno,  ;
           oobjproperties)
     ENDIF
ENDPROC
**
PROCEDURE AdjustObjectSize
     LPARAMETERS nfrxrecno,  ;
                 oobjproperties
     IF  .NOT.  ;
         ISNULL(this.successor)
          this.setsuccessordynamicproperties()
          this.successor.adjustobjectsize(nfrxrecno,  ;
           oobjproperties)
     ENDIF
ENDPROC
**
ENDDEFINE
**
