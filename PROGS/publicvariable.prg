PUBLIC xpis 		AS STRING, ; 
	   xpay 		AS  STRING, ; 
	   xdb 			as String, ; 
	   xtrucking	as String, ;  
	   xLumpsum 	as string, ;
	   apay			as string, ;
	   apis			as string  
	   
xpis 		= ALLTRIM(fileloc.schemapis)
xpay 		= ALLTRIM(fileloc.schemapay)
xdb			= ALLTRIM(fileloc.schamaipay)

xtrucking	= ALLTRIM(fileloc.schematruc)
xLumpSum	= ALLTRIM(fileloc.schemalumpSum)