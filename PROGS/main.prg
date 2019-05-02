PUBLIC progdir
LOCAL lcsys16, lcprogram
SET TALK OFF
SET ECHO OFF
SET STATUS OFF
SET SAFETY OFF
SET CENTURY ON
SET SYSMENU TO
SET DELETED ON
SET EXCLUSIVE OFF
SET DECIMALS TO 2
ON SHUTDOWN QUIT

lcsys16 	= SYS(16)
lcprogram 	= SUBSTR(lcsys16,  AT(":", lcsys16) -  1)
CD LEFT(lcprogram, RAT("\",  lcprogram))

IF RIGHT(lcprogram, 3) = "FXP"
     CD ..
ENDIF

progdir = LEFT(lcprogram, RAT("\",  lcprogram, 1))
SET PATH TO 'class, data, forms, forms2, formsbir, icon, images, graphics, programs, text,';
		+ 'progs, programs, reports, reports2,  menus, text, pix, SavedFiles, dp4eval, include, gridtoexcel'
		
DO open_table.prg
DO publicVariable.prg
DO configure_screen.prg
DO functions.prg

DO FORM login.scx   
 
READ EVENTS
SET SYSMENU TO DEFAULT
ENDPROC