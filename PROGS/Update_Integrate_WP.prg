msql = "CREATE DATABASE " + xtrucking  
SQLEXEC(nconn,msql) 

msql = " CREATE TABLE  " + xtrucking + ".`vehicle` ( " + ; 
		  " `plateno` 		CHAR(10) NOT NULL, " + ; 
		  " `mvfileno` 		CHAR(20), " + ; 
		  " `engineno` 		CHAR(20), " + ; 
		  " `chasisno` 		CHAR(20), " + ; 
		  " `denomination` 	CHAR(20), " + ; 
		  " `pistondisp` 	CHAR(20), " + ; 
		  " `cylinder` 		CHAR(20), " + ; 
		  " `fuel` 			CHAR(10), " + ; 
		  " `make` 			CHAR(40), " + ; 
		  " `series` 		CHAR(40), " + ; 
		  " `bodyType` 		VARCHAR(45), " + ; 
		  " `bodyno` 		CHAR(20), " + ; 
		  " `yearmodel` 	CHAR(4), " + ; 
		  " `grosswt` 		CHAR(20), " + ; 
		  " `netwt` 		CHAR(20), " + ; 
		  " `shippingwt` 	CHAR(20), " + ; 
		  " `netcapcity` 	CHAR(20), " + ; 
		  " `driver` 		CHAR(5), " + ; 
		  " `crno` 			CHAR(15), " + ; 
		  " `crdate` 		DATE DEFAULT '0000-00-00', " + ; 
		  " `orno` 			CHAR(15) DEFAULT ' ', " + ; 
		  " `ordate` 		DATE DEFAULT '0000-00-00', " + ; 
		  " `status` 		char(1) default 'A' , " + ; 
		  " PRIMARY KEY (`plateno`)	) ENGINE = InnoDB;"
SQLEXEC(nconn,msql)  

**---  Route table ------------------------------------------------------------------------**
msql = " CREATE TABLE "+xtrucking+".`route` ( " + ; 
	  " `idroute` 		INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
	  " `origin` 		VARCHAR(60), " + ; 
	  " `destination` 	VARCHAR(60), " + ; 
	  " `status` 		char(1) default 'A' , " + ; 
	  " PRIMARY KEY (`idroute`)) ENGINE = InnoDB;"
SQLEXEC(nconn,msql) 

*--- Trip table ----------------------------------------------------------------------------
msql = " CREATE TABLE "+xtrucking+".`trip` ( " + ; 
		 " `tripcode` 	CHAR(20) DEFAULT ' ', " + ; 
		 " `idroute` 	INTEGER UNSIGNED DEFAULT 0, " + ; 
		 " `etd` 		DATETIME DEFAULT '0000-00-00 00:00:00', " + ; 
		 " `eta` 		DATETIME DEFAULT '0000-00-00 00:00:00', " + ; 
		 " `etr` 		DATETIME DEFAULT '0000-00-00 00:00:00', " + ; 
		 " `created` 	DATETIME DEFAULT '0000-00-00 00:00:00', " + ; 
		 " `createdby` 	CHAR(25) DEFAULT ' ', " + ; 
		 " `status` 	CHAR(10) DEFAULT 'In-Transit', " + ; 
		 " PRIMARY KEY (`tripcode`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 
msql = " CREATE TABLE "+xtrucking+".`tripRem` ( " + ; 
		 " `tripcode` 	CHAR(20) DEFAULT ' ', " + ; 
		 " `Remarks` 	VARCHAR(100) DEFAULT '', " + ; 
		 " PRIMARY KEY (`tripcode`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 

*--- Trucking Account ----------------------------------------
msql = 	" CREATE TABLE "+xtrucking+".`truckingAcct` (`acctNumber` CHAR(5) NOT NULL, " + ; 
		"   PRIMARY KEY (`acctNumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 		
		
*--- Trip Budget Allocation ---------------------------------------------------------------
msql = " CREATE TABLE " + xtrucking + ".`trip_budgetAllocation` ( " + ; 
		  " `idbudgetAllocation` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		  " `tripcode` CHAR(20) NOT NULL, " + ; 
		  " `acctNumber` CHAR(5) NOT NULL, " + ; 
		  " `amount` DOUBLE(18,4) NOT NULL, " + ; 
		  " PRIMARY KEY (`idbudgetAllocation`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 	

*--- Trip Actual Expenses ----------------------------------------------------------------------
msql = " CREATE TABLE " + xtrucking + ".`trip_ActualExpenses` ( " + ; 
	   " `idtrip_ActualExpenses` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
	   " `tripcode` CHAR(20) DEFAULT ' ', " + ; 
	   " `acctNumber` CHAR(5) DEFAULT ' ', " + ; 
	   " `price` DOUBLE(18,4) DEFAULT 0, " + ; 
	   " `uom` CHAR(10) DEFAULT ' ', " + ; 
	   " `qty` DOUBLE(12,4) DEFAULT 0, " + ; 
	   " PRIMARY KEY (`idtrip_ActualExpenses`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 	

*--- Trucker Masterfile -----------------------------------------------------------------------
msql = 	" CREATE TABLE "+xtrucking+".`trucker` ( " + ; 
	  	" `empnumber` CHAR(5) NOT NULL, " + ; 
	  	" `idRole` INTEGER UNSIGNED DEFAULT 0, " + ; 
	  	" PRIMARY KEY (`empnumber`)	)	ENGINE = InnoDB; " 
SQLEXEC(nconn,msql) 	

*--- Trucker Role -----------------------------------------------------------------------
msql = 	" CREATE TABLE `trucking`.`TruckerRole` ( " + ;
		  " `idTruckerRole` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ;
		  " `Role` VARCHAR(45) NOT NULL, " + ;
		  " PRIMARY KEY (`idTruckerRole`))ENGINE = InnoDB " 
SQLEXEC(nconn,msql) 	

*--- Trip Personnel --------------------------------------------------------------------
msql = 	" CREATE TABLE " + xtrucking + ".`trip_personnel` ( " + ; 
		" `tripcode` CHAR(20) NOT NULL, " + ; 
		"   `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		"   `idrole` INTEGER UNSIGNED DEFAULT 0, " + ; 
		"   PRIMARY KEY (`tripcode`, `empnumber`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)

*--- Trucker Assignment ---------------------------------------------------------------
msql = " CREATE TABLE " + xtrucking + ".`trucker_assignment` ( " + ; 
		 " `empnumber` CHAR(5) NOT NULL, " + ; 
		 " `plateno` CHAR(10) NOT NULL DEFAULT ' ', " + ; 
		 " `idrole` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		 " PRIMARY KEY (`empnumber`, `plateno`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)

*--- Trip Deduction ------------------------------------------------------------------
msql =	" CREATE TABLE " + xtrucking + ".`trip_emp_ded` ( " + ; 
		"   `tripcode` CHAR(20) NOT NULL, " + ; 
		"   `empnumber` CHAR(5) DEFAULT ' ', " + ; 
		"   `acctNumber` CHAR(5) DEFAULT ' ', " + ; 
		"   `amount` DOUBLE(18,4) DEFAULT 0, " + ; 
		"   PRIMARY KEY (`tripcode`, `empnumber`, `acctNumber`)	)ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)

*--- Trip Payment --------------------------------------------------------------------
msql = " CREATE TABLE " + xtrucking + ".`trip_payRates` ( " + ; 
		 " `idtrip_payRates` 	INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		 " `tripcode` 			CHAR(20) NOT NULL, " + ; 
		 "  `empnumber` 		CHAR(5) 		DEFAULT ' ', " + ; 
		 "  `acctNumber` 		CHAR(5) 		DEFAULT ' ', " + ; 
		 "  `rates` 			DOUBLE(18,4) 	DEFAULT 0, " + ; 
		 "  `qty` 				DOUBLE(18,4) 	DEFAULT 0, " + ; 
		 "  PRIMARY KEY (`idtrip_payRates`)) ENGINE = InnoDB " 
SQLEXEC(nconn,msql)
		  
		
*--- TRucking mark in payroll group -------------------------------------------------------
msql = "ALTER TABLE "+xpis+".`client` ADD COLUMN `isTrucking` INTEGER UNSIGNED DEFAULT 0 AFTER `sgcode`" 	  	
SQLEXEC(nconn,msql)

*--- Lump mark in payroll group -------------------------------------------------------
msql = "ALTER TABLE "+xpis+".`client` ADD COLUMN `isLumpsum` INTEGER UNSIGNED DEFAULT 0 " 	  	
SQLEXEC(nconn,msql)

*--- Trucking Group ----------------------------------------------------------------------------------
msql = " CREATE TABLE " + xtrucking + ".`paygrp` ( " + ; 
		 " `clnumber` 		CHAR(5) 		NOT NULL DEFAULT ' ', " + ; 
		 " `empnumber` 		CHAR(5) 		NOT NULL DEFAULT ' ', " + ; 
		 " `rate` 			DOUBLE(18,2) 	NOT NULL DEFAULT 0, " + ; 
		 "  PRIMARY KEY (`clnumber`, `empnumber`)) ENGINE = InnoDB "
SQLEXEC(nconn,msql)		

*-------------------------------------
msql = "ALTER TABLE "+xpay+".`tmploans` ADD COLUMN `trn` CHAR(12) DEFAULT ' ' " 
SQLEXEC(nconn,msql)		

msql =  " ALTER TABLE "+xpay+".`loansref` ADD COLUMN `loanAmt` DOUBLE(18,4) NOT NULL DEFAULT 0, " + ; 
		" ADD COLUMN `cvno` INTEGER UNSIGNED NOT NULL DEFAULT 0 AFTER `loanAmt`, ROW_FORMAT = DYNAMIC;"
SQLEXEC(nconn,msql)		

*--- loan vs temploans -----------------------------------------------------------------------------------
*!*	msql = "select * from loans where 0=1" 
*!*	SQLEXEC(nconn,msql,'loans')


*!*	msql = "select * from tmploans where 0=1" 
*!*	SQLEXEC(nconn,msql,'loans')

*!*	
		
*---- Create Schema of Lumpsum pay ---------------------------------------
mlumpsum = ALLTRIM(NVL(fileloc.schemalumpsum,''))
IF !EMPTY(mlumpsum)
	SQLEXEC(nconn,'create database if not exists ' + mlumpsum  )
	SQLEXEC(nconn,'show errors','serror')	
ENDIF 

msql =  " CREATE TABLE  " + xlumpsum + ".`ls_acct` (  `acctNumber` char(5) NOT NULL,  " + ; 
		" PRIMARY KEY (`acctNumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn,msql)		

*--- Lumpsum personnel ------------------------------------------------------
msql = 	" CREATE TABLE  "+xlumpsum+".`lspersonnel` " + ; 
		" (`empnumber` char(5) NOT NULL ,  " + ; 
		" PRIMARY KEY (`empnumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn,msql)		

*--- Payroll Group -----------------------------------------------------------
msql =  " CREATE TABLE  " + xlumpsum + ".`paygrp` (  `clnumber` char(5) NOT NULL DEFAULT '',  " + ; 
		" `empnumber` char(5) NOT NULL DEFAULT '',  `rate` double(18,2) NOT NULL DEFAULT '0.00',  " + ; 
		" PRIMARY KEY (`clnumber`,`empnumber`)) ENGINE=InnoDB DEFAULT CHARSET=latin1; " 
SQLEXEC(nconn,msql)		


*--- UOM table ---------------------------------------------------------------
msql = " CREATE TABLE " + xpay + ".`uom` (`single` CHAR(10) NOT NULL, " + ; 
  		" `multi` CHAR(10) NOT NULL,PRIMARY KEY (`single`))ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)		

msql =  "insert into " + xpay + ".uom values ('hr','hrs'), ('day','days'),  ('pc','pcs'),  ('pck','pcks'), " + ; 
		" ('lot', 'lots'),  ('trip','trips')" 		
SQLEXEC(nconn,msql)		

*--- Lumpsum Employee Rate -------------------------------------
msql = " CREATE TABLE " + xlumpsum + ".`empRate` ( " + ; 
		 " `empnumber` 	CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 " `acctNumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 " `amount` 	DOUBLE(12,2) NOT NULL DEFAULT 0, " + ; 
		 " `uom` 		CHAR(10) NOT NULL, " + ; 
		 " PRIMARY KEY (`empnumber`, `acctNumber`)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)		
	
*--- Schema AMS ----------------------------------------------------
msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schemapis` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)

msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schemapay` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)

msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schemaams` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)
		
msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schemalumpsum` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)

msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schematruc` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)

msql =  " ALTER TABLE " + xpis + ".`coinfo` " + ; 
		" ADD COLUMN `schemaipay` VARCHAR(45), ENGINE = InnoDB;	" 
SQLEXEC(nconn,msql)


*--- Payroll Source of tbltran ---------------------------------
msql = "ALTER TABLE " + xpay + ".`tbltran` ADD COLUMN `source` CHAR(5) DEFAULT 'main', ENGINE = InnoDB;" 
SQLEXEC(nconn,msql)


*--- lumpsum tbltran ------------------------------------------
msql = " CREATE TABLE " + xlumpsum + ".`tbltran` ( " + ; 
		 "  `trn` CHAR(12) NOT NULL, " + ; 
		 "  `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 "  `acctNumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 "  `labor` DOUBLE(12,2) DEFAULT 0, " + ; 
		 "  `rate` DOUBLE(12,2) DEFAULT 0, " + ; 
		 "  `uom` CHAR(10) DEFAULT ' ', " + ; 
		 "  `amount` DOUBLE(12,4) DEFAULT 0, " + ; 
		 "  PRIMARY KEY(`trn`, `empnumber`, `acctNumber`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	
SQLEXEC(nconn,'show errors','eerror')	


msql = " CREATE TABLE " + xlumpsum + ".`tmptbltran` ( " + ; 
		 "  `trn` CHAR(12) NOT NULL, " + ; 
		 "  `empnumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 "  `acctNumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 "  `labor` DOUBLE(12,2) DEFAULT 0, " + ; 
		 "  `rate` DOUBLE(12,2) DEFAULT 0, " + ; 
		 "  `uom` CHAR(10) DEFAULT ' ', " + ; 
		 "  `amount` DOUBLE(12,4) DEFAULT 0, " + ; 
		 "  PRIMARY KEY(`trn`, `empnumber`, `acctNumber`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	


*--- Increase Lenght to Loans fields ----------------------
msql =  " ALTER TABLE " + xpay + ".`loans` MODIFY COLUMN `ENCODEDT` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL, " + ; 
		" MODIFY COLUMN `CHANGEDT` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL " + ; 
		" , ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)	

*--- Increase Lenght to tmpLoans fields ----------------------
msql =  " ALTER TABLE " + xpay + ".`tmploans` MODIFY COLUMN `ENCODEDT` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL, " + ; 
		" MODIFY COLUMN `CHANGEDT` VARCHAR(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL " + ; 
		" , ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)	

**--- UOM to tbltrandtl ----------------------------------------
msql =  " ALTER TABLE " + xpay + ".`tbltrandtl` ADD COLUMN `UOM` CHAR(10) DEFAULT 'hr' AFTER `nVal`, ENGINE = InnoDB;" 
SQLEXEC(nconn,msql)	
msql =  " ALTER TABLE " + xpay + ".`tmptbltrandtl` ADD COLUMN `UOM` CHAR(10) DEFAULT 'hr' AFTER `nVal`, ENGINE = InnoDB;" 
SQLEXEC(nconn,msql)	


*--- 
msql =  " ALTER TABLE " + xpay + ".`tblotherearnings` ADD COLUMN `effective` " + ; 
		" DATE DEFAULT '0000-00-00' AFTER `CONTROL_NO`, " + ; 
		" ADD COLUMN `contproc` INTEGER UNSIGNED DEFAULT 0 AFTER `effective` , ENGINE = InnoDB;" 
SQLEXEC(nconn,msql)	

msql =  " ALTER TABLE " + xpay + ".`paymainhdr` ADD COLUMN `attStart` DATE NOT NULL DEFAULT '0000-00-00' , " + ;
		"  ADD COLUMN `attEnd` DATE NOT NULL DEFAULT '0000-00-00' , ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)	

*--- Audit Trail --------------------------------------------------
msql = "CREATE TABLE " + xpay + ".`audit_trail` ( " + ; 
	  " `idaudit_trail` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
	  " `tdate` DATETIME NOT NULL, " + ; 
	  " `source` CHAR(5) NOT NULL, " + ; 
	  " `action` CHAR(45) NOT NULL, " + ; 
	  " `userName` CHAR(25) NOT NULL, " + ; 
	  " PRIMARY KEY (`idaudit_trail`))ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	

*--- Hdr Project Based Manual Allocation *------------------
msql = " CREATE TABLE "+xlumpsum+".`PBMAHdr` ( " + ;
		  " `projcode` 		CHAR(15) NOT NULL, " + ; 
		  " `descr` 			CHAR(50), " + ;
		  " `paygrp` 		CHAR(5), " + ;
		  " `yr` 			char(4), " + ;
		  " `mo` 			CHAR(2), " + ;
		  " `prd` 			CHAR(2), " + ;
		  " `acctNumber` 	CHAR(5), " + ;
		  " `status` 		CHAR(10), " + ;
		  " PRIMARY KEY (`projcode`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	


*--- Dtl Personnel (Project Based Manual Allocation) *------------------
msql = " CREATE TABLE "+xlumpsum+".`PBMADtlPer` ( " + ;
		  " `projcode` 		CHAR(15) NOT NULL, " + ; 
		  " `empnumber` 	CHAR(5), " + ;
		  " `amount` 		double(10,4), " + ;
		  " PRIMARY KEY (`projcode`,`empnumber`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	


*--- Dtl Project (Project Based Manual Allocation) *------------------
msql = " CREATE TABLE "+xlumpsum+".`PBMADtlProj` ( " + ;
		  " `projcode` 		CHAR(15) NOT NULL, " + ; 
		  " `ProjName` 		CHAR(25), " + ;
		  " `amount` 		double(10,4), " + ;
		  " PRIMARY KEY (`projcode`,`ProjName`)) ENGINE = InnoDB; "
SQLEXEC(nconn,msql)	

*-----  Default Account of Project Based Allocation -----------------***
msql = "ALTER TABLE "+xpay+".`acctconfig` ADD COLUMN `projBDefAcct` CHAR(5) Default '' " 
SQLEXEC(nconn,msql)	



**************************************************************************
*** Temporay table *******************************************************
**************************************************************************
	*--- Dtl Personnel (Project Based Manual Allocation) *------------------
	msql = " CREATE TABLE "+xlumpsum+".`TmpPBMADtlPer` ( " + ;
			  " `projcode` 		CHAR(15) NOT NULL, " + ; 
			  " `yr` 			char(4), " + ;
			  " `mo` 			CHAR(2), " + ;
			  " `prd` 			CHAR(2), " + ;
			  " `empnumber` 	CHAR(5), " + ;
			  " `amount` 		double(10,4), " + ;
			  " PRIMARY KEY (`projcode`,`empnumber`)) ENGINE = InnoDB; "
	SQLEXEC(nconn,msql)	


	*--- Dtl Project (Project Based Manual Allocation) *------------------
	msql = " CREATE TABLE "+xlumpsum+".`TmpPBMADtlProj` ( " + ;
			  " `projcode` 		CHAR(15) NOT NULL, " + ; 
			  " `ProjName` 		CHAR(25), " + ;
			  " `yr` 			char(4), " + ;
			  " `mo` 			CHAR(2), " + ;
			  " `prd` 			CHAR(2), " + ;
			  " `amount` 		double(10,4), " + ;
			  " PRIMARY KEY (`projcode`,`ProjName`)) ENGINE = InnoDB; "
	SQLEXEC(nconn,msql)	
**************************************************************************
**************************************************************************
**************************************************************************

*--- Lumpsum Tax Rate ------------------------------------------------------
msql = " CREATE TABLE "+xlumpsum+".`taxType` ( " + ; 
		 " `idTaxType` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT, " + ; 
		 " `descr` CHAR(15) NOT NULL DEFAULT ' ', " + ; 
		 " `rate` INTEGER UNSIGNED NOT NULL DEFAULT 0, " + ; 
		 " `acctNumber` CHAR(5) NOT NULL DEFAULT ' ', " + ; 
		 " PRIMARY KEY (`idTaxType`))ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)	


msql = " ALTER TABLE `paylumpsum`.`pbmahdr` ADD COLUMN `idTaxType` INTEGER UNSIGNED DEFAULT 0 , " + ;
		 " ADD COLUMN `TaxRAte` INTEGER UNSIGNED DEFAULT 0 , " + ;
		 " ADD COLUMN `taxAcct` CHAR(5) DEFAULT ' ' " 
SQLEXEC(nconn,msql)	


*---- Project based deductions -------------------------------------------------------
msql = " CREATE TABLE " + xlumpsum + ".`pbDeduction` ( " + ; 
		  " `yr` 		 INTEGER UNSIGNED DEFAULT 0, " + ; 
		  " `mo` 		 CHAR(2) DEFAULT '00',  " + ; 
		  " `prd` 		 CHAR(2) DEFAULT '00', " + ; 
		  " `empnumber`  CHAR(5) DEFAULT ' ', " + ; 
		  " `acctnumber` CHAR(5) DEFAULT ' ', " + ; 
		  " `amount` 	 DECIMAL(18,4) DEFAULT 0, " + ; 
		  " `status` 	 CHAR(1) DEFAULT 'N',  " + ; 
		  " PRIMARY KEY (`yr`, `prd`, `mo`, `empnumber`, acctnumber)) ENGINE = InnoDB; " 
SQLEXEC(nconn,msql)	
SQLEXEC(nconn,'show errors','lsderror')	


		  

		 