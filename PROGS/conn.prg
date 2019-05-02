PUBLIC nconn, xconn
IF  .NOT. USED('link')
     MESSAGEBOX( 'Holding table connection not open yet!.',  'Connetion error' )
     RETURN
ENDIF

mfile 		= ALLTRIM(link.dsn) +  '.dsn'
mlogo 		= ALLTRIM(link.logo)
msvrAddress	= ALLTRIM(link.svrAddress)
mdatabase	= ALLTRIM(link.schemapay)
muser		= ALLTRIM(link.dbuser)
mpw 		= ALLTRIM(link.dbpw)

nconn 		= SQLSTRINGCONNECT( "FILEDSN=include\" +  mfile + ; 
				";SERVER=" 	 + msvrAddress + ; 
				";DATABASE=" + mdatabase + ; 
				";USER=" 	 + muser + ; 						  
				";PASSWORD=" + mpw  ;
			  )

IF nconn < 1
     MESSAGEBOX( "Failed to connect to server",  'Connection Error' )
     RETURN
ENDIF

xconn 	= nconn
mdbf 	= ALLTRIM(link.schemapis)
msql 	= "SELECT * from " + mdbf +  ".coinfo"

SQLEXEC(nconn, msql, "curCoInfo")
SQLEXEC(nconn, "Show Errors",  "ErrorCoInfo")


*--- define public in public variable prg --------------------
xpis 		= ALLTRIM(link.schemapis)
xpay 		= ALLTRIM(link.schemapay)
xdb			= ALLTRIM(link.schemaemp)

apay		= ALLTRIM(link.archpay)
apis		= ALLTRIM(link.archpis)

xtrucking	= ALLTRIM(link.schematruc)
xLumpSum	= ALLTRIM(link.schemals)

xipay 		= ALLTRIM(link.SchemaEmp)
xams		= ALLTRIM(link.Schemaams)
*************************************************************

SELECT  fileloc
mconame = ALLTRIM(curcoinfo.coname)
mcoadd	= ALLTRIM(curcoinfo.coadd)
mcosn	= ALLTRIM(curcoinfo.shortname)
REPLACE coname 			WITH mconame 
REPLACE coadd 			WITH mcoadd 
REPLACE cologo 			WITH mlogo
REPLACE conameshort 	WITH mcosn 

REPLACE schemapis 		WITH xpis 
REPLACE schemapay 		WITH xpay 
*REPLACE schemaEquip WITH xequip 
REPLACE schemalumpsum 	WITH xLumpSum 
REPLACE schamaipay 		WITH xipay 
REPLACE schemaAms		WITH xams 
REPLACE schematruc 		WITH xtrucking

*--- Connection ----------------------------------------------------
_SCREEN.caption = mconame

WAIT WINDOW NOWAIT  ;
     'Processing please wait!......'
ENDPROC