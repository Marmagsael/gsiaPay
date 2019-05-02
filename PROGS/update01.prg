DO systemMenu

*--- Mandatory Dededuction Transaction ----------------------------------
msql = " CREATE TABLE "+xpay+".`dedMandatory_Trans` ( " + ; 
		  " `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
		  " `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `acctnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `amount` DOUBLE(12,4) DEFAULT 0, " + ; 
		  " `islock` INTEGER UNSIGNED DEFAULT 0, " + ; 
		  " PRIMARY KEY(`trn`, `empnumber`, `acctnumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		  


msql = " ALTER TABLE "+xpay+".`paymaindtl` " + ; 
		 " ADD COLUMN `nd` DOUBLE(10,2) NOT NULL DEFAULT 0 , " + ; 
		 " ADD COLUMN `ndot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `nd`, " + ; 
		 " ADD COLUMN `ndlh` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndot`, " + ; 
		 " ADD COLUMN `ndlhot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndlh`, " + ; 
		 " ADD COLUMN `ndsh` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndlhot`, " + ; 
		 " ADD COLUMN `ndshot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndsh`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1x1')		  
		 
msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` " + ; 
		 " ADD COLUMN `nd`  	CHAR(5) DEFAULT ' ' AFTER `rdshot`, " + ; 
		 " ADD COLUMN `ndot` 	CHAR(5) DEFAULT ' ' AFTER `nd`, " + ; 
		 " ADD COLUMN `ndlh` 	CHAR(5) DEFAULT ' ' AFTER `ndot`, " + ; 
		 " ADD COLUMN `ndlhot` 	CHAR(5) DEFAULT ' ' AFTER `ndlh`, " + ; 
		 " ADD COLUMN `ndsh` 	CHAR(5) DEFAULT ' ' AFTER `ndlhot`, " + ; 
		 " ADD COLUMN `ndshot` 	CHAR(5) DEFAULT ' ' AFTER `ndsh`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')	

msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` " + ; 
		 " ADD COLUMN `DH`  		CHAR(5) DEFAULT ' ' AFTER `ndshot`, " + ; 
		 " ADD COLUMN `DHOT` 		CHAR(5) DEFAULT ' ' AFTER `dh`, " + ; 
		 " ADD COLUMN `RDDH` 		CHAR(5) DEFAULT ' ' AFTER `dhot`, " + ; 
		 " ADD COLUMN `RDDHOT` 		CHAR(5) DEFAULT ' ' AFTER `rddh`, " + ; 
		 " ADD COLUMN `NDDH` 		CHAR(5) DEFAULT ' ' AFTER `rddhot`, " + ; 
		 " ADD COLUMN `NDDHOT` 		CHAR(5) DEFAULT ' ' AFTER `nddh`, " + ;
		 " ADD COLUMN `NDRDDH` 		CHAR(5) DEFAULT ' ' AFTER `NDDHOT`, " + ; 
		 " ADD COLUMN `NDRDDHOT` 	CHAR(5) DEFAULT ' ' AFTER `NDRDDH`, " + ;
		 " ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		

*--- Payroll Sources ---------------------------------------------------------
msql = " CREATE TABLE "+xpay+".`tbltranSource` ( " + ;
		 " `trn` CHAR(12) NOT NULL, " + ;
		 " `empnumber` CHAR(5) NOT NULL, " + ;
		 " `acctNumber` CHAR(5) NOT NULL, " + ;
		 " `amount` DOUBLE(12,4) NOT NULL, " + ;
		 " `source` CHAR(20) NOT NULL " + ;
		" ) ENGINE = InnoDB; "
SQLEXEC(nconn, msql)
msql = " CREATE TABLE "+xpay+".`tmptbltranSource` ( " + ;
		 " `trn` CHAR(12) NOT NULL, " + ;
		 " `empnumber` CHAR(5) NOT NULL, " + ;
		 " `acctNumber` CHAR(5) NOT NULL, " + ;
		 " `amount` DOUBLE(12,4) NOT NULL, " + ;
		 " `source` CHAR(20) NOT NULL " + ;
		" ) ENGINE = InnoDB; "
SQLEXEC(nconn, msql)

*msql = "ALTER TABLE "+xpay+".`tmppaysource` DROP PRIMARY KEY, ENGINE = InnoDB;" 
*SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'create database ' + xdb)

*---- ND RD ------------------------
msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `ndrd` CHAR(5) AFTER `ndot`, " + ; 
			" ADD COLUMN `ndrdot` CHAR(5) AFTER `ndrd`, " + ; 
			" ADD COLUMN `ndrdlh` CHAR(5) AFTER `ndrdot`, " + ; 
			" ADD COLUMN `ndrdlhot` CHAR(5) AFTER `ndrdlh`, " + ; 
			" ADD COLUMN `ndrdsh` CHAR(5) AFTER `ndrdlhot`, " + ; 
			" ADD COLUMN `ndrdshot` VARCHAR(45) AFTER `ndrdsh` " + ; 
			", ENGINE = InnoDB; "
SQLEXEC(nconn, msql)

*----
msql = " ALTER TABLE "+xpay+".`paymaindtl` ADD COLUMN `ndrd` DOUBLE(10,2) DEFAULT 0 AFTER `custom3`, " + ; 
			 " ADD COLUMN `ndrdot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrd`, " + ; 
			 " ADD COLUMN `ndrdlh` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdot`, " + ; 
			 " ADD COLUMN `ndrdlhot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdlh`, " + ; 
			 " ADD COLUMN `ndrdsh` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdlhot`, " + ; 
			 " ADD COLUMN `ndrdshot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdsh` " + ; 
			" , ENGINE = InnoDB; " 

SQLEXEC(nconn, msql)

*--- Philheath added table -------------------------------------------------------------------------
msql = " ALTER TABLE "+xpay+".`medtbl` ADD COLUMN `percent` DOUBLE(5,2) DEFAULT 2.75, ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)


*--- uom in tbltrandtl -------------------------------------------------------------------------------
msql = " ALTER TABLE  "+xpay+".`tbltrandtl` ADD COLUMN `uom` CHAR(10) DEFAULT ' ' AFTER `nVal` " + ; 
		", ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)

msql = " ALTER TABLE  "+xpay+".`tmptbltrandtl` ADD COLUMN `uom` CHAR(10) DEFAULT ' ' AFTER `nVal` " + ; 
		", ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)


******************************************************************************************
****** From Ardee ************************************************************************
******************************************************************************************
*****************************************************************************************************************************************
**** Update *****************************************************************************************************************************
*****************************************************************************************************************************************
SQLEXEC(nconn,"ALTER TABLE " + xpis + ".`empmas` MODIFY COLUMN `ACCTCODE` VARCHAR(21) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT ' '","")

msql = "ALTER TABLE `pay`.`loans` ADD COLUMN `cvno` CHAR(15) DEFAULT ' ' AFTER `endTrans`;"
SQLEXEC(nconn,msql)


SQLEXEC(nconn,"ALTER TABLE "+xpay+".`chartofacct` ADD COLUMN `isextloan` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `is13thMoAcct`;")

*--- Add Incentive Leave to Acct Configuration 
SQLEXEC(nconn,"ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `incentiveLeave` CHAR(5) DEFAULT 0 ")

*--- Employee Deduction Exemption --------------------------------------------------------------------

SQLEXEC(nconn," CREATE TABLE "+xpay+".`empDedExemption` ( " + ; 
			  " `idempDedExemption` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
			  " `clnumber` CHAR(10) NOT NULL, " + ; 
			  " `acctnumber` CHAR(5) NOT NULL, " + ; 
			  " `empnumber` CHAR(5) NOT NULL, " + ; 
			  " PRIMARY KEY (`idempDedExemption`)) ENGINE = InnoDB;" )

*--- ctpa rd and rdlh fields addition -----------------------------------------------------------------
SQLEXEC(nconn, " ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `ctpa_rd` CHAR(15) DEFAULT ' ' , " + ; 
 		" ADD COLUMN `ctpa_rdlh` CHAR(15) DEFAULT ' ' ;") 
 		
*--- Add ecola rate to client table -------------------------------------------------------------------
*SQLEXEC(nconn, " ALTER TABLE " + xpis + ".`client` ADD COLUMN `ecolaRevisedRate` DOUBLE(15,2) DEFAULT 0 AFTER `ecolaRevised`;")


*--- ecola account ---------------------------------------------------------------------------------------
SQLEXEC(nconn,  " ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `ecola` CHAR(15) DEFAULT ' ' , " + ; 
				" ADD COLUMN `ecola_rd` VARCHAR(45) DEFAULT ' ' , " + ; 
				" ADD COLUMN `ecola_lh` VARCHAR(45) DEFAULT ' ' , " + ; 
				" ADD COLUMN `ecola_rdlh` VARCHAR(45) DEFAULT ' ' ; " )
				
*--- sea rd and rdlh fields addition -----------------------------------------------------------------
SQLEXEC(nconn, " ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `sea_rd` CHAR(15) DEFAULT ' ' , " + ; 
 		" ADD COLUMN `sea_rdlh` CHAR(15) DEFAULT ' ' ;") 
 		
SQLEXEC(nconn, "ALTER TABLE "+xpay+".`fixed_earnings` MODIFY COLUMN `idsched` INT(10) UNSIGNED DEFAULT 0 " + ; 
				" COMMENT '1 - per pay, 2 - every first period, 3 - every 2nd period', " + ;
				" ADD COLUMN `dayspara` DOUBLE(18,2) DEFAULT 15 AFTER `terminatedby`;")
				
SQLEXEC(nconn, "show errors",'e1error')
				
SQLEXEC(nconn, " CREATE TABLE "+xpay+".`13thMoSettings` ( " + ; 
				 " `id13thMoSettings` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
				 " `empnumber` CHAR(5) DEFAULT ' ', " + ; 
				 " `withMonthlyPay` INTEGER UNSIGNED DEFAULT 1, " + ; 
				 " PRIMARY KEY (`id13thMoSettings`)) ENGINE = InnoDB; ")
				
SQLEXEC(nconn, "ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `_3thMo` CHAR(15) DEFAULT 'E019' ;") 


*--- Other Incentive Leave -------------------------------------------------------------------------
SQLEXEC(nconn, " CREATE TABLE  "+xpay+".`incentiveLeave` ( " + ; 
				  " `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
				  " `acctNumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
				  " `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
				  " `amount` DOUBLE(18,4) NOT NULL DEFAULT 0, " + ; 
				  " `dTimeStamp` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', " + ; 
				  " PRIMARY KEY (`trn`, `acctNumber`, `empnumber`)) ENGINE = InnoDB; " ) 
				  
*--- Other TblTrn Archieved -------------------------------------------------------------------------
SQLEXEC(nconn, " CREATE TABLE  "+xpay+".`tbltranArchieved` ( " + ; 
				  " `TRN` varchar(12) NOT NULL DEFAULT '', " + ; 
				  " `acctNumber` varchar(5) NOT NULL, " + ; 
				  " `empNumber` varchar(5) NOT NULL, " + ; 
				  " `amount` double(10,4) NOT NULL, " + ; 
				  " `dTimeStamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00', " + ; 
				  " PRIMARY KEY (`TRN`,`acctNumber`,`empNumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " )

*--- Other TblTrn Archieved -------------------------------------------------------------------------
SQLEXEC(nconn, " ALTER TABLE "+xpay+".`usr` ADD COLUMN `ArchievedAccess` TINYINT UNSIGNED NOT NULL DEFAULT 0 ;")

*--- Other TblTrn Archieved -------------------------------------------------------------------------
SQLEXEC(nconn, " ALTER TABLE "+xpay+".`chartofacct` ADD COLUMN `status_` TINYINT UNSIGNED NOT NULL DEFAULT 1 ;")

msql = " ALTER TABLE " + xpis + ".`empmas` ADD COLUMN `ismaxsss` INTEGER UNSIGNED DEFAULT 0 AFTER `iswithPagibig`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql) 


*----- pis Additional field ------------------------------------------
	
msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `SDOSource` VARCHAR(100) NOT NULL DEFAULT '' AFTER `PixDir` , ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `SDOSaveTo` VARCHAR(100) NOT NULL DEFAULT ''  , ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 


msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `schemapis` VARCHAR(45) NOT NULL DEFAULT 'emeissecpis', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `schemapay` VARCHAR(45) NOT NULL DEFAULT 'pngpa_pay', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `shortname` varchar(45) NOT NULL DEFAULT 'PNGSA', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `schemaequip` VARCHAR(45) NOT NULL DEFAULT 'emeisseceis', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `acctno` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `TIN` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE  "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `SSS` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `PHIC` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `PAGIBIG` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `sssMemType` VARCHAR(45) NOT NULL DEFAULT '1', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `sssdocno` VARCHAR(45) NOT NULL DEFAULT ' ', ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE "+xpis+".`coinfo` " + ; 
		" ADD COLUMN `sssLocCode` VARCHAR(45) NOT NULL AFTER `sssdocno`, ENGINE = MyISAM;  " 					
SQLEXEC(nconn, msql) 


*---- Client Table fields integration for CTPA/SEA -----------------------------------------------------
msql = 	" ALTER TABLE "+xpis+".`client`  " + ;
		"  ADD COLUMN `seaRate` 		DOUBLE(10,2) NOT 	NULL DEFAULT 0 AFTER `withCTPA`, " + ;
		"  ADD COLUMN `withSea` 		INTEGER UNSIGNED 	NOT NULL DEFAULT 0 AFTER `seaRate`, ENGINE = MyISAM; "
SQLEXEC(nconn, msql) 
SQLEXEC(nconn, 'show errors','xerror') 


*--- ismaxSSS empmas ----------------------------------------------------------------------------------------
msql = "ALTER TABLE "+xpis+".`empmas` ADD COLUMN `ismaxSSS` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `fit_remarks`, ENGINE = MyISAM; " 
SQLEXEC(nconn, msql) 

msql = 	" ALTER TABLE " + xpay + ".`acctconfig` ADD COLUMN `ctpa` CHAR(5) NOT NULL DEFAULT 'E034' AFTER `_3thMo`, " + ;
		"  ADD COLUMN `ctpa_lh` CHAR(5) NOT NULL DEFAULT 'E035' AFTER `ctpa`, " + ;
		"  ADD COLUMN `sea` CHAR(5) NOT NULL DEFAULT 'E037' AFTER `ctpa_lh`, " + ;
		"  ADD COLUMN `sea_lh` CHAR(5) NOT NULL DEFAULT 'E038' AFTER `sea` " + ;
		" , ENGINE = MyISAM;"

SQLEXEC(nconn, msql) 
SQLEXEC(nconn, 'show errors','xerror') 

msql = "ALTER TABLE "+xpis+".`client` ADD COLUMN `payprd` CHAR(15) NOT NULL DEFAULT '', ENGINE = MyISAM;"
SQLEXEC(nconn, msql) 		 

*--- Additional fields in empmas ------------------------------------
msql = 	" ALTER TABLE  "+xpis+".`empmas` ADD COLUMN `istaxable` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `ismaxSSS`, " + ; 
		"  ADD COLUMN `isconfi` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `istaxable`, " + ; 
		"  ADD COLUMN `iswithSSS` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `isconfi`, " + ; 
		"  ADD COLUMN `iswithPHIC` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `iswithSSS`, " + ; 
		"  ADD COLUMN `iswithPagibig` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `iswithPHIC`, ENGINE = MyISAM; " 
SQLEXEC(nconn, msql) 		 

*--- 
msql = "ALTER TABLE  "+xpis+".`empstat` ADD COLUMN `isInPayroll` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `issuspended`, ENGINE = MyISAM; " 
SQLEXEC(nconn, msql) 		 

msql = " CREATE TABLE "+xpay+".`paymainhdr` ( " + ; 
		 "  `trn` CHAR(12) NOT NULL, " + ; 
		 "  `clrate` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		 "  `minrate` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		 "  `withSEA` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		 "  `SEARate` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		 "  `withCTPA` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		 "  `CTPARate` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		 "  `ecolaRevised` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		 "  `billrate` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		 "  `user` CHAR(25) NOT NULL DEFAULT ' ', " + ; 
		 "  `status` CHAR(10) NOT NULL DEFAULT 'New', " + ; 
		 "  `datecreated` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', " + ; 
		 "  `dateposted` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00', " + ; 
		 "  PRIMARY KEY(`trn`)) ENGINE = InnoDB; "
SQLEXEC(nconn, msql) 		 
		
msql = "CREATE TABLE "+xpay+".`paymaindtl` ( " + ; 
		 " `trn` CHAR(15) NOT NULL DEFAULT ' ', " + ; 
		 "  `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 "  `SSS` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `SSSer` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `pagibig` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `pagibiger` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `phic` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `phicer` DOUBLE(16,4) NOT NULL DEFAULT 0, " + ; 
		 "  `paystatus` CHAR(10) NOT NULL DEFAULT 0, " + ; 
		 "  `coid` CHAR(10) NOT NULL DEFAULT 0, " + ; 
		 "  `brid` CHAR(10) NOT NULL DEFAULT 0, " + ; 
		 "  `depid` CHAR(10) NOT NULL DEFAULT 0, " + ; 
		 "  `secid` CHAR(10) NOT NULL DEFAULT 0, " + ; 
		 "  `daywrk` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rn` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rnot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rd` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rdot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `lh` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `lhot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rdlh` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rdlhot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `sh` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `shot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rdsh` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  `rdshot` DOUBLE(10,2) NOT NULL DEFAULT 0, " + ; 
		 "  PRIMARY KEY(`trn`, `empnumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql) 	

msql = 	" ALTER TABLE "+xpay+".`paymaindtl` " + ; 
		"  ADD COLUMN `sea` 		DOUBLE(10,2) NOT NULL  DEFAULT 0, " + ;
		"  ADD COLUMN `sealh` 		DOUBLE(10,2) NOT NULL  DEFAULT 0, " + ;
		"  ADD COLUMN `seardlh` 	DOUBLE(10,2) NOT NULL  DEFAULT 0, " + ;
		"  ADD COLUMN `ctpa` 		DOUBLE(10,2) NOT NULL  DEFAULT 0, " + ;
		"  ADD COLUMN `ctpalh` 		DOUBLE(10,2) NOT NULL  DEFAULT 0, " + ;
		"  ADD COLUMN `ctpardlh` 	DOUBLE(10,2) NOT NULL  DEFAULT 0 " + ;
		" , ENGINE = InnoDB;	  " 
SQLEXEC(nconn, msql) 	

*--- paymaindtl setup **************************
msql = 	" create table " + xpay + ".paymaindtlSetup ( " + ; 
		"`idpaymaindtlsetup` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		"daywrk 	CHAR(5) NOT NULL default ' ', " + ; 
		"rn 		CHAR(5) NOT NULL default ' ', " + ; 
		"rnot 		CHAR(5) NOT NULL default ' ', " + ; 
		"rot 		CHAR(5) NOT NULL default ' ', " + ; 
		"rd 		CHAR(5) NOT NULL default ' ', " + ; 
		"rdot 		CHAR(5) NOT NULL default ' ', " + ; 
		"lh 		CHAR(5) NOT NULL default ' ', " + ; 
		"lhot		CHAR(5) NOT NULL default ' ', " + ; 
		"rdlh 		CHAR(5) NOT NULL default ' ', " + ; 
		"rdlhot 	CHAR(5) NOT NULL default ' ', " + ; 
		"sh 		CHAR(5) NOT NULL default ' ', " + ; 
		"shot 		CHAR(5) NOT NULL default ' ', " + ; 
		"rdsh 		CHAR(5) NOT NULL default ' ', " + ; 
		"rdshot 	CHAR(5) NOT NULL default ' ', " + ; 
		"sea 		CHAR(5) NOT NULL default ' ', " + ; 
		"sealh 		CHAR(5) NOT NULL default ' ', " + ; 
		"seardlh 	CHAR(5) NOT NULL default ' ', " + ; 
		"ctpa 		CHAR(5) NOT NULL default ' ', " + ; 
		"ctpalh 	CHAR(5) NOT NULL default ' ', " + ; 
		"ctpardlh 	CHAR(5) NOT NULL default ' ', " + ; 
		"SSSer 		CHAR(5) NOT NULL default ' ', " + ; 
		"pagibig 	CHAR(5) NOT NULL default ' ', " + ; 
		"pagibiger 	CHAR(5) NOT NULL default ' ', " + ; 
		"phic 		CHAR(5) NOT NULL default ' ', " + ; 
		"custom1 	CHAR(5) NOT NULL default ' ', " + ; 
		"custom2 	CHAR(5) NOT NULL default ' ', " + ; 
		"custom3 	CHAR(5) NOT NULL default ' ', " + ; 
		" PRIMARY KEY(`idpaymaindtlsetup`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql) 	  
 
msql = "select * from " + xpay + ".paymaindtlSetup " 
SQLEXEC(nconn, msql,'x')
IF 	rECCOUNT('x') = 0 
	msql = "insert into " + xpay + ".paymaindtlSetup (daywrk, rot) values ('E001','E002')"
	SQLEXEC(nconn, msql,'x')	
ENDIF 

*---- Custom rate to COA ----------------
msql = "ALTER TABLE "+xpay+".`chartofacct` ADD COLUMN `customRate` DOUBLE(12,4) NOT NULL DEFAULT 0 AFTER `status_`, ENGINE = MyISAM;" 
SQLEXEC(nconn, msql)

*--- 
msql = " ALTER TABLE "+xpay+".`paymaindtl` ADD COLUMN `absent` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `daywrk`, " + ; 
		 " ADD COLUMN `late` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `absent`, " + ; 
		 " ADD COLUMN `utime` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `late`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)

msql = " ALTER TABLE " + xpay + ".`paymaindtlsetup` " + ; 
			 " ADD COLUMN `absent` CHAR(5) NOT NULL DEFAULT ' ' AFTER `daywrk`, " + ; 
			 " ADD COLUMN `late` CHAR(5) NOT NULL DEFAULT ' ' AFTER `absent`, " + ; 
			 " ADD COLUMN `utime` CHAR(5) NOT NULL DEFAULT ' ' AFTER `late` " + ;
			" , ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)

msql = "ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `sss` CHAR(5) NOT NULL AFTER `ctpardlh` , ENGINE = InnoDB;"
SQLEXEC(nconn, msql)

msql = " ALTER TABLE "+xpay+".`paymaindtl` ADD COLUMN `custom1` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ctpardlh`, " + ; 
		 " ADD COLUMN `custom2` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `custom1`, " + ; 
		 " ADD COLUMN `custom3` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `custom2`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)


msql = 	" CREATE TABLE  "+xpay+".tmptbltran (`TRN` varchar(12) NOT NULL,  `acctNumber` varchar(5) NOT NULL,  " + ; 
		" `empNumber` varchar(5) NOT NULL,  `amount` double(10,4) NOT NULL,  `dTimeStamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',  " + ; 
		" `postedBy` varchar(45) DEFAULT NULL,  PRIMARY KEY (`TRN`,`acctNumber`,`empNumber`) USING BTREE) ENGINE=MyISAM DEFAULT CHARSET=utf8; " 
		
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')


*--- Salary Grade --------------------------------------------------
msql = 	" CREATE TABLE "+xpay+".`salGrade` ( " + ; 
		  " `sgcode` CHAR(10) NOT NULL, " + ; 
		  " `sgrade` VARCHAR(45) NOT NULL, " + ; 
		  " `monthlyRate` DOUBLE(12,4) NOT NULL, " + ; 
		  " `dailyRate` DOUBLE(12,4) NOT NULL, " + ; 
		  " `wtax` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		  " `wSSS` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		  " `wGSIS` INTEGER UNSIGNED NOT NULL DEFAULT 1, " + ; 
		  " `wPHIC` INTEGER UNSIGNED NOT NULL DEFAULT 1, " + ; 
		  " `wPagibig` INTEGER UNSIGNED NOT NULL DEFAULT 1, " + ; 
		  " `isLock` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ;
		  " PRIMARY KEY(`sgcode`))ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')


*--- 
msql = "ALTER TABLE " + xpis + ".`client` ADD COLUMN `sgcode` CHAR(10) NOT NULL DEFAULT ' ' AFTER `payprd` , ENGINE = MyISAM;"
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')

*--- 

msql = "ALTER TABLE "+xpis+".`empmas` ADD COLUMN `sgcode` CHAR(10) NOT NULL DEFAULT ' ', ENGINE = MyISAM;"
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')

*--- 
msql = "ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `Allowance` CHAR(5) NOT NULL DEFAULT ' ' , ENGINE = InnoDB ROW_FORMAT = DYNAMIC; " 
SQLEXEC(nconn, msql)

msql = "ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `CashBond` CHAR(5) NOT NULL DEFAULT ' ' , ENGINE = InnoDB ROW_FORMAT = DYNAMIC; " 
SQLEXEC(nconn, msql)

*--- Incentive Leave ------------------------
msql = "ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `IncentLeave` CHAR(5) NOT NULL DEFAULT ' ' AFTER `CashBond` , ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)

*--- GSIS fields on empmas -----------------------
msql = "ALTER TABLE "+xpis+".`empmas` ADD COLUMN `iswithGSIS` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `isWithSSS`, ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','dError')

*--- Meal Allowance Option --------------------
msql = " CREATE TABLE  "+xpay+".`mealallowopt` (`empnumber` varchar(10) NOT NULL, " + ; 
		"  `MealAllow` double(18,2) NOT NULL, " + ; 
		"  `isMgr` int(10) unsigned NOT NULL DEFAULT '0', " + ; 
		"  PRIMARY KEY (`empnumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; "	
SQLEXEC(nconn, msql)

msql = "ALTER TABLE " + xpay + ".`paymaindtlsetup` ADD COLUMN `mealAllowance` CHAR(5) NOT NULL DEFAULT ' ' , ENGINE = InnoDB;"
SQLEXEC(nconn, msql)

*--- Provision for Retirement -----------------------------------
msql = " CREATE TABLE  "+xpay+".`retirementopt` ( " + ; 
		" `empnumber` varchar(10) NOT NULL, " + ; 
  		" `withRetirement` int(10) unsigned NOT NULL, " + ; 
  		" PRIMARY KEY (`empnumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','dError')

msql = " ALTER TABLE "+XPAY+".`paymaindtlsetup` ADD COLUMN `ProvForRetirement` CHAR(5) NOT NULL DEFAULT ' ' AFTER `mealAllowance`, ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','dError')


*--- Free Uniform -----------------------------------------------
msql = "ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `FreeUniform` CHAR(5) NOT NULL DEFAULT ' ' , ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','dError')

*--- TRCA ------------------
msql = 	" CREATE TABLE  "+xpay+".`trca` (`EmpNumber` varchar(5) DEFAULT NULL, `Amount` double(12,2) DEFAULT NULL, `EarnRefNo` int(10) unsigned NOT NULL, " + ; 
		" PRIMARY KEY (`EarnRefNo`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 

SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','dError')

*---- 

msql = 	" ALTER TABLE "+xpay+".`fixed_earnings` MODIFY COLUMN `idsched` INTEGER UNSIGNED DEFAULT 0 COMMENT '1 - per pay, 2 - every first period, 3 - every 2nd period', " + ; 
		" ADD COLUMN `dayspara` DOUBLE(18,2) DEFAULT 15 , ENGINE = InnoDB;" 
SQLEXEC(nconn, msql)


*---- tmp Other Deductions -----------------		
msql = "create table "+xpay+".Tmptblotherdeductions SELECT * FROM "+xpay+".`tblotherdeductions` where 0 = 1 " 
SQLEXEC(nconn, msql)

*---- tmp Loans 
msql = "create table "+xpay+".TmpLoans SELECT * FROM "+xpay+".`loans` where 0 = 1 " 
SQLEXEC(nconn, msql)

msql = " ALTER TABLE "+xpay+".`tmploans` MODIFY COLUMN `DEDNCODE` VARCHAR(4) default ' ', " + ; 
		 " ADD COLUMN `trn` 	CHAR(12) NOT NULL AFTER `LoanAmt`, "  + ; 
		 " ADD PRIMARY KEY(number,`trn`, `DEDNCODE`), ENGINE = InnoDB; "
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')

*--- CVNo field in loans ---------------------------------
msql = "ALTER TABLE "+xpay+".`loans` ADD COLUMN `cvno` INTEGER UNSIGNED DEFAULT 0 , ENGINE = MyISAM;" 
SQLEXEC(nconn, msql)

*--
msql = "ALTER TABLE " + xpay + ".`loansref` ADD COLUMN `cvno` INTEGER UNSIGNED DEFAULT 0 AFTER `LoanAmt`, ENGINE = MyISAM;" 
SQLEXEC(nconn, msql)



*---- Temporary tblTranDtl ----------------------------------------
msql =  " CREATE TABLE  "+xpay+".`tmptbltrandtl` (  `TRN` varchar(12) NOT NULL,  " + ; 
		" `EmpNumber` varchar(5) NOT NULL,  `DtlCd` varchar(10) NOT NULL,  " + ; 
		" `nVal` double(10,4) NOT NULL,  PRIMARY KEY (`TRN`,`EmpNumber`,`DtlCd`)) " + ; 
		" ENGINE=MyISAM DEFAULT CHARSET=utf8; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')


*---- Undeduction Deduction -----------------------------------------
msql = "CREATE TABLE "+xpay+".`undedDeduction` ( " + ; 
		" `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
		" `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		" `acctnumber` CHAR(10) NOT NULL DEFAULT ' ', " + ; 
		" `amount` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		" PRIMARY KEY(`trn`) ) ENGINE = InnoDB;	" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')
		
msql = "CREATE TABLE "+xpay+".`tmpUndedDeduction` ( " + ; 
		" `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
		" `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		" `acctnumber` CHAR(10) NOT NULL DEFAULT ' ', " + ; 
		" `amount` DOUBLE(12,4) NOT NULL DEFAULT 0, " + ; 
		" PRIMARY KEY(`trn`) ) ENGINE = InnoDB;	" 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')

*---- Parameters for Year Other Deduction to display -------------------
msql = 	" ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `OtherDedYrDisplay` INTEGER UNSIGNED DEFAULT 2015 AFTER `sea_lh` " + ; 
		" , ENGINE = MyISAM;"
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror')

*--- Mandatory Deduction -----------------------------------------------
msql = " CREATE TABLE "+xpay+".`DedMandatory` ( " + ; 
		  " `idDedMandatory` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		  " `acctNumber` VARCHAR(45), " + ; 
		  " `ContAmt` DOUBLE(12,4), " + ; 
		  " `MaxAmt` DOUBLE(12,4), " + ; 
		  " `sched` INTEGER UNSIGNED COMMENT '1 - 1 to 15; 2 - 16 to end of month; 3 - both ', " + ; 
		  " `remarks` VARCHAR(200) DEFAULT ' ', " + ; 
		  " `status` CHAR(1) DEFAULT 'A' COMMENT 'A - Active, I - InActive; S - Stop', " + ; 
		  " PRIMARY KEY(`idDedMandatory`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)

*--- Mandatory Dededuction Transaction ----------------------------------
msql = " CREATE TABLE "+xpay+".`dedMandatory_Trans` ( " + ; 
		  " `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
		  " `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `acctnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `amount` DOUBLE(12,4) DEFAULT 0, " + ; 
		  " `islock` INTEGER UNSIGNED DEFAULT 0, " + ; 
		  " PRIMARY KEY(`trn`, `empnumber`, `acctnumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		  

*--- Fixed Earnings -----------------------------------------------------
msql = " CREATE TABLE  " + xpay + ".`fixed_earnings` (  `idfixed_earnings` int(10) unsigned NOT NULL AUTO_INCREMENT,  " + ; 
		" `empnumber` char(5) NOT NULL,  `dStart` date DEFAULT '0000-00-00',  `dEnd` date DEFAULT '0000-00-00',   " + ; 
		" `acctNumber` char(5) DEFAULT '',  `amount` double(18,4) DEFAULT '0.0000',   " + ; 
		" `idsched` int(10) unsigned DEFAULT '0' COMMENT '1 - per pay, 2 - every first period, 3 - every 2nd period',   " + ; 
		" `createdby` char(25) DEFAULT '',  `terminatedby` char(25) DEFAULT '',  `dayspara` double(18,2) DEFAULT '15.00',   " + ; 
		" PRIMARY KEY (`idfixed_earnings`)) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn, msql)
		
*--- Payroll Group History ------------------------------------------------
msql = " CREATE TABLE "+xpay+".`payGrp_movHistory` ( " + ; 
		  " `idpayGrp_movHistory` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		  " `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `clnumber` 	CHAR(5) DEFAULT ' ', " + ; 
		  " `datetime` 	DATETIME DEFAULT '0000-00-00 00:00:00', " + ; 
		  " `username` 	CHAR(25) DEFAULT '', " + ; 
		  " `Action` 	CHAR(1) DEFAULT '', " + ; 
		  " PRIMARY KEY(`idpayGrp_movHistory`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','createError')

*---- Salary Grade ------------------------------------------------------------
msql = 	" CREATE TABLE  "+xpay+".`salgrade` " + ;
		" (  `sgcode` char(10) NOT NULL,  `sgrade` varchar(45) NOT NULL,  `monthlyRate` double(12,4) NOT NULL,  ` " + ;
		" dailyRate` double(12,4) NOT NULL,  `wtax` int(10) unsigned NOT NULL DEFAULT '0',   " + ;
		" `wSSS` int(10) unsigned NOT NULL DEFAULT '0',  `wGSIS` int(10) unsigned NOT NULL DEFAULT '1',   " + ;
		" `wPHIC` int(10) unsigned NOT NULL DEFAULT '1',  `wPagibig` int(10) unsigned NOT NULL DEFAULT '1',   " + ;
		" `isLock` int(10) unsigned NOT NULL DEFAULT '0',  PRIMARY KEY (`sgcode`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn, msql)

*****************************************************************************************************************************************
**** Update 01 **************************************************************************************************************************
*****************************************************************************************************************************************
DO systemMenu

*--- Mandatory Dededuction Transaction ----------------------------------
msql = " CREATE TABLE "+xpay+".`dedMandatory_Trans` ( " + ; 
		  " `trn` CHAR(12) NOT NULL DEFAULT ' ', " + ; 
		  " `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `acctnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `amount` DOUBLE(12,4) DEFAULT 0, " + ; 
		  " `islock` INTEGER UNSIGNED DEFAULT 0, " + ; 
		  " PRIMARY KEY(`trn`, `empnumber`, `acctnumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		  


msql = " ALTER TABLE "+xpay+".`paymaindtl` " + ; 
		 " ADD COLUMN `nd` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `rdshot`, " + ; 
		 " ADD COLUMN `ndot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `nd`, " + ; 
		 " ADD COLUMN `ndlh` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndot`, " + ; 
		 " ADD COLUMN `ndlhot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndlh`, " + ; 
		 " ADD COLUMN `ndsh` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndlhot`, " + ; 
		 " ADD COLUMN `ndshot` DOUBLE(10,2) NOT NULL DEFAULT 0 AFTER `ndsh`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		  
		 
msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` " + ; 
		 " ADD COLUMN `nd`  	CHAR(5) DEFAULT ' ' AFTER `rdshot`, " + ; 
		 " ADD COLUMN `ndot` 	CHAR(5) DEFAULT ' ' AFTER `nd`, " + ; 
		 " ADD COLUMN `ndlh` 	CHAR(5) DEFAULT ' ' AFTER `ndot`, " + ; 
		 " ADD COLUMN `ndlhot` 	CHAR(5) DEFAULT ' ' AFTER `ndlh`, " + ; 
		 " ADD COLUMN `ndsh` 	CHAR(5) DEFAULT ' ' AFTER `ndlhot`, " + ; 
		 " ADD COLUMN `ndshot` 	CHAR(5) DEFAULT ' ' AFTER `ndsh`, ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')	

msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` " + ; 
		 " ADD COLUMN `DH`  		CHAR(5) DEFAULT ' ' AFTER `ndshot`, " + ; 
		 " ADD COLUMN `DHOT` 		CHAR(5) DEFAULT ' ' AFTER `dh`, " + ; 
		 " ADD COLUMN `RDDH` 		CHAR(5) DEFAULT ' ' AFTER `dhot`, " + ; 
		 " ADD COLUMN `RDDHOT` 		CHAR(5) DEFAULT ' ' AFTER `rddh`, " + ; 
		 " ADD COLUMN `NDDH` 		CHAR(5) DEFAULT ' ' AFTER `rddhot`, " + ; 
		 " ADD COLUMN `NDDHOT` 		CHAR(5) DEFAULT ' ' AFTER `nddh`, " + ;
		 " ADD COLUMN `NDRDDH` 		CHAR(5) DEFAULT ' ' AFTER `NDDHOT`, " + ; 
		 " ADD COLUMN `NDRDDHOT` 	CHAR(5) DEFAULT ' ' AFTER `NDRDDH`, " + ;
		 " ENGINE = InnoDB; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','xerror1')		

*--- Payroll Sources ---------------------------------------------------------
msql = " CREATE TABLE "+xpay+".`tbltranSource` ( " + ;
		 " `trn` CHAR(12) NOT NULL, " + ;
		 " `empnumber` CHAR(5) NOT NULL, " + ;
		 " `acctNumber` CHAR(5) NOT NULL, " + ;
		 " `amount` DOUBLE(12,4) NOT NULL, " + ;
		 " `source` CHAR(20) NOT NULL " + ;
		" ) ENGINE = InnoDB; "
SQLEXEC(nconn, msql)
msql = " CREATE TABLE "+xpay+".`tmptbltranSource` ( " + ;
		 " `trn` CHAR(12) NOT NULL, " + ;
		 " `empnumber` CHAR(5) NOT NULL, " + ;
		 " `acctNumber` CHAR(5) NOT NULL, " + ;
		 " `amount` DOUBLE(12,4) NOT NULL, " + ;
		 " `source` CHAR(20) NOT NULL " + ;
		" ) ENGINE = InnoDB; "
SQLEXEC(nconn, msql)

*msql = "ALTER TABLE "+xpay+".`tmppaysource` DROP PRIMARY KEY, ENGINE = InnoDB;" 
*SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'create database ' + xdb)

*---- ND RD ------------------------
msql = " ALTER TABLE "+xpay+".`paymaindtlsetup` ADD COLUMN `ndrd` CHAR(5) AFTER `ndot`, " + ; 
			" ADD COLUMN `ndrdot` CHAR(5) AFTER `ndrd`, " + ; 
			" ADD COLUMN `ndrdlh` CHAR(5) AFTER `ndrdot`, " + ; 
			" ADD COLUMN `ndrdlhot` CHAR(5) AFTER `ndrdlh`, " + ; 
			" ADD COLUMN `ndrdsh` CHAR(5) AFTER `ndrdlhot`, " + ; 
			" ADD COLUMN `ndrdshot` VARCHAR(45) AFTER `ndrdsh` " + ; 
			", ENGINE = InnoDB; "
SQLEXEC(nconn, msql)

*----
msql = " ALTER TABLE "+xpay+".`paymaindtl` ADD COLUMN `ndrd` DOUBLE(10,2) DEFAULT 0 AFTER `custom3`, " + ; 
			 " ADD COLUMN `ndrdot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrd`, " + ; 
			 " ADD COLUMN `ndrdlh` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdot`, " + ; 
			 " ADD COLUMN `ndrdlhot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdlh`, " + ; 
			 " ADD COLUMN `ndrdsh` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdlhot`, " + ; 
			 " ADD COLUMN `ndrdshot` DOUBLE(10,2) DEFAULT 0 AFTER `ndrdsh` " + ; 
			" , ENGINE = InnoDB; " 

SQLEXEC(nconn, msql)


*--------------------------------------------------------------------------
msql = " ALTER TABLE "+xpay+".`tmploans` MODIFY COLUMN `cvno` CHAR(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci, " + ;
		"  ADD COLUMN `trn` VARCHAR(12) DEFAULT ' ' AFTER `cvno`  " + ;
		" , ENGINE = InnoDB; "
SQLEXEC(nconn, msql)

*--------------------------------------------------------------------------
msql = 	" CREATE TABLE "+xpay+".`tmptblotherearnings` (  `trn` char(12) NOT NULL DEFAULT '',  " + ; 
		" `control_no` int(10) unsigned DEFAULT NULL,  `empNumber` varchar(5) NOT NULL DEFAULT '',    " + ; 
		" `acctNumber` varchar(5) NOT NULL DEFAULT '',  `amount` double(10,4) DEFAULT NULL,    " + ; 
		" PRIMARY KEY (`trn`,`empNumber`,`acctNumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1;  " 
SQLEXEC(nconn, msql)

