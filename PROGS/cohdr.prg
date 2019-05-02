SELECT fileloc
xselect = " SELECT * FROM coinfo "
DO 'conn.prg'
IF xconn < 1
     MESSAGEBOX( ;
               'Failed to connect to server',  ;
               16, 'WARNING')
     RETURN
ENDIF
SQLEXEC(xconn, 'use ' +  ;
       fileloc.schemapis)
SQLEXEC(xconn, xselect, 'x')
SQLDISCONNECT(xconn)
SELECT fileloc
REPLACE coname WITH x.coname,  ;
        coadd WITH x.coadd
ENDPROC
**
