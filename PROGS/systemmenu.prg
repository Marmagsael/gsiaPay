msql = "CREATE TABLE  "+xpay+".`sysmenu` (  `idsysmenu` int(10) unsigned NOT NULL AUTO_INCREMENT,  " + ;
											" `sourcetype` char(15) DEFAULT NULL,    " + ;
											" `source` varchar(45) DEFAULT NULL,   " + ;
											" `name` varchar(80) DEFAULT NULL,   " + ;
											" `dispval` varchar(80) DEFAULT NULL,   " + ;
											" `barorder` int(10) unsigned DEFAULT '99',   " + ;
											" `priorityno` int(10) unsigned DEFAULT NULL,   " + ;
											" `Action` varchar(80) DEFAULT ' ',   " + ;
											" `withchild` int(10) unsigned DEFAULT '0',   " + ;
											" PRIMARY KEY (`idsysmenu`)) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; " 
SQLEXEC(nconn, msql)
SQLEXEC(nconn, 'show errors','MenuError')

*******************************************************************************************
*---- Main Menu ***************************************************************************
*******************************************************************************************
*-------- System --------------------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where source = '_MSYSMENU' and dispval = 'System'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 		dispval, 	barorder, 	priorityno, Action, withchild) " + ; 
			" Values 						 ( 'PAD', 	  '_MSYSMENU', 	'_System', 	'System', 	99, 		1, 			'', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Setup --------------------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where source = '_MSYSMENU' and dispval = 'Setup'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 		dispval, 	barorder, 	priorityno, Action, withchild) " + ; 
			" Values 						 ( 'PAD', 	  '_MSYSMENU', 	'_Setup', 	'Setup', 	99, 		1, 			'', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Transaction --------------------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where source = '_MSYSMENU' and dispval = 'Transaction'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 				dispval, 		barorder, 	priorityno, Action, withchild) " + ; 
			" Values 						 ( 'PAD', 	  '_MSYSMENU', 	'_Transaction', 	'Transaction', 	99, 		1, 			'', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Reports --------------------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where source = '_MSYSMENU' and dispval = 'Reports'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 				dispval, 		barorder, 	priorityno, Action, withchild) " + ; 
			" Values 						 ( 'PAD', 	  '_MSYSMENU', 	'_Reports', 		'Reports', 		99, 		1, 			'', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Account Configuration --------------------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where source = '_MSYSMENU' and dispval = 'Account Configuration'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 						dispval, 					barorder, 	priorityno, Action, withchild) " + ; 
			" Values 						 ( 'PAD', 	  '_MSYSMENU', 	'_AccountConfiguration', 	'Account Configuration', 	99, 		1, 			'', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 


*******************************************************************************************
*---- System ******************************************************************************
*******************************************************************************************
*-------- User Administration -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMUSERMGR'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 					dispval, 					barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_System', 	'_UserAdministration', 	'User Administration', 		99, 		2, 			'DO FORM FRMUSERMGR', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Change Password -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMCHANGEPASS'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 					dispval, 				barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_System', 	'_ChangePassword', 		'Change Password', 		99, 		2, 			'DO FORM FRMCHANGEPASS', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Log-Out -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM LOGIN'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					 ('BAR',      '_System', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
		
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 			dispval, 		barorder, 	priorityno, Action, 			withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_System', 	'_Logout', 		'Log-out', 		99, 		2, 			'DO FORM LOGIN', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*-------- Exit -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO Exit'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					 ('BAR',      '_System', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
		
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 			dispval, 		barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_System', 	'_Exit', 		'Exit', 		99, 		2, 			'DO exit', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*******************************************************************************************
*---- Setup ******************************************************************************
*******************************************************************************************
*-------- Employee Rate -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMEMPRATES'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 					dispval, 			barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Setup', 	'_EmployeeRate', 	'Employee Rate', 		99, 		2, 			'DO FORM FRMEMPRATES', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Surety Bond Quota -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMSBQUOTA'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 					dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Setup', 	'_SuretyBondQuota', 	'Surety Bond Quota', 	99, 		2, 			'DO FORM FRMSBQUOTA', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- SSS Table -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMSSSTABLE'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 			dispval, 		barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Setup', 	'_SSSTable', 	'SSS Table', 	99, 		2, 			'DO FORM FRMSSSTABLE', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- PHIC Table -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMPHICTABLE'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 			dispval, 		barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Setup', 	'_PHICTable', 	'PHIC Table', 	99, 		2, 			'DO FORM FRMPHICTABLE', 0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Rate Over Basic -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMOTSETUP'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 		dispval, 			barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Setup', 	'_ROB', 	'Rate Over BAsic', 	99, 		2, 			'DO FORM FRMOTSETUP', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Salary Grade -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form salaryGrade'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Setup', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 			dispval, 			barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_SalaryGrade', 'Salary Grade', 	99, 		2, 			'do form salaryGrade', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Account Entry -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMCHAROFACCT'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Setup', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 				dispval, 			barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_AccountsEntry', 	'Accounts Entry', 	99, 		2, 			'DO FORM FRMCHAROFACCT', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Accounts Mapping -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form AcctMapping'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 				dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_AccountsMapping', 	'Accounts Mapping', 99, 		2, 			'do form AcctMapping', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Payroll Content -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM PAYCONTENT'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 				dispval, 			barorder, 	priorityno, Action, 			withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_PayrollContent', 	'Payroll Content', 99, 		2, 			'DO FORM PAYCONTENT', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Deduction Order Setup -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM DEDUCTIONORDER'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 						dispval, 				 barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_DeductionOrderSetup', 	'Dedcution Order Setup', 99, 		2, 			'DO FORM DEDUCTIONORDER', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Annual Tax Matrix -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM TAX_MATRIX'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Setup', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 					dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_AnnualTaxMatrix', 	'Annual Tax Matrix', 	99, 		2, 			'DO FORM TAX_MATRIX', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Semi-Monthly Tax Matrix -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMSEMIMONTHLYTAX'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 						dispval, 					barorder, 	priorityno, Action, 						withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_SemiMonthlyTaxMatrix', 	'Semi-Monthly Tax Matrix', 	99, 		2, 			'DO FORM FRMSEMIMONTHLYTAX', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Account Code Entry -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMACCTCODE'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Setup', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 					dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_AccountCodeEntry', 	'Account Code Entry', 	99, 		2, 			'DO FORM FRMACCTCODE', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Minimum Rate Setup -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM FRMMINIMUMSETUP'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 					dispval, 				barorder, 	priorityno, Action, 							withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_MinimumRateSetup', 	'Minimum Rate Setup', 	99, 		2, 			'DO FORM FRMMINIMUMSETUP', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Payroll Status Visibilty -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form emp_status_visible_to_pay'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 	name, 						dispval, 						barorder, 	priorityno, Action, 								withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Setup', 	'_PayrollStatusVisibility', 'Payroll Status Visibility', 	99, 		2, 			'do form emp_status_visible_to_pay', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*******************************************************************************************
*---- Transaction ******************************************************************************
*******************************************************************************************
*-------- Earninigs -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'Earnings'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 			name, 			dispval, 			barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Transaction', 	'Earnings', 	'Earninigs', 		99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*-------- Deductions -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'Deductions'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 			name, 			dispval, 			barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Transaction', 	'Deductions', 	'Deductions', 		99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Payroll -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM PAYROLL4'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    		name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Transaction', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 		name, 			dispval, 	barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Transaction', '_Payroll', 	'Payroll', 	99, 		2, 			'DO FORM PAYROLL4', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- BIR -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'BIR'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    		name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_Transaction', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".sysmenu (sourcetype, source, 		name, 	dispval, 	barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 					   ( 'BAR', 	'_Transaction', 'BIR', 	'BIR', 		99, 		2, 			'', 		0);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- Earninigs ----------------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Earnings per Employee -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMEARNFINAL'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     name,  					dispval,             	 barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Earnings', '_EarningsperEmployee',   'Earnings per Employee', 99,       3,          'DO FORM FRMEARNFINAL', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Group Earnings -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMEARNINGS'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     name,  				dispval,            barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Earnings', '_GroupEarnings',    'Group Earnings', 	99,       3,          'DO FORM FRMEARNINGS', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Fixed Earnings -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form fixed_earnings'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     name,  				dispval,            barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Earnings', '_FixedEarnings',    'Fixed Earnings', 	99,       3,          'do form fixed_earnings', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

msql = "select * from " + xpay + ".sysmenu where action = 'do form frm13thMonth_ded_Setter'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     name,  				dispval,            barorder, priorityno, action,   						 withchild) ' + ; 
			" values 					 ('BAR',      'Earnings', '_FixedEarnings',    '13th Mo Salary', 	01,       3,          'do form frm13thMonth_ded_Setter', 0)"
	SQLEXEC(xconn,msql)
ENDIF 


*-------------------------------------------------------------------------------------------------------------*
*---- Deductions ----------------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Deduction per Employee -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMCANCELDEDN'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     	name,  						dispval,             	 	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Deductions', '_DeductionperEmployee',   	'Deduction per Employee', 	99,       3,          'DO FORM FRMCANCELDEDN', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Group Deduction -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDUCTIONS'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     	name,  					dispval,            barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Deductions', '_GroupDeduction',   	'Group Deduction', 	99,       3,          'DO FORM FRMDEDUCTIONS', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Partial Deduction -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPARTIALDED'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     	name,  					dispval,            	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Deductions', '_PartialDeduction',   	'Partial Deduction', 	99,       3,          'DO FORM FRMPARTIALDED', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Mandatory Deduction -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form ded_mandatory'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,     	name,  					dispval,            	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Deductions', '_MadatoryDeduction',   'Mandatory Deduction', 	99,       3,          'do form ded_mandatory', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------------------------------------------------------------------------------------------------------------*
*---- BIR ----------------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- BIR Fields Mapping -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form bir_fields_mapping'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   name,  						dispval,            barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'BIR', 	'_FieldsMapping',   	'BIR Fields Mapping', 	99,       3,          'do form bir_fields_mapping', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- BIR Data Migration -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form bir_empmas_migration'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   name,  					dispval,            barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'BIR', 	'_DataMigration',   	'Data Migration', 	99,       3,          'do form bir_empmas_migration', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- BIR Data Migration -------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form bir_excelUploading'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   name,  					dispval,            barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'BIR', 	'_Excel Upload',   		'Excel Upload', 	99,       3,          'do form bir_excelUploading', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*******************************************************************************************
*---- Transaction ******************************************************************************
*******************************************************************************************
*-------- Emp. Status Included in Payroll -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form payroll_employee_status_inclusion'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 							dispval, 								barorder, 	priorityno, Action, 										withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_EmpStatusIncludedInPayroll', 	'Emp. Status Included in Payroll', 		99, 		2, 			'do form payroll_employee_status_inclusion', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Meal Allowance -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM MEALALLOWANCECONFIG'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 				dispval, 				barorder, 	priorityno, Action, 						withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_MealAllowance', 	'Meal Allowance', 		99, 		2, 			'DO FORM MEALALLOWANCECONFIG', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Uniform -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM UNIFORMCONFIG'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 			dispval, 		barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_Uniform', 	'Uniform', 		99, 		2, 			'DO FORM UNIFORMCONFIG', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Provision for Retirement -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM RETIREMENTCONFIG'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 						dispval, 					barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_ProvisionForRetirement', 	'Provision for Retirement', 99, 		2, 			'DO FORM RETIREMENTCONFIG', 0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- OT Account Setup -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM ACCTOTCONFIG'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 				dispval, 			barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_OTAccountSetup', 	'OT Account Setup', 99, 		2, 			'DO FORM ACCTOTCONFIG', 0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Minimun Group Rate -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'DO FORM MINRATESETUP'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 					dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_MinimunClientRate', 	'Minimun Group Rate', 	99, 		2, 			'DO FORM MINRATESETUP', 0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Deduction Dressing Mgt -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form deduction_dressing_mgt'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 						dispval, 					barorder, 	priorityno, Action, 							withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_DeductionDressingMgt', 	'Deduction Dressing Mgt', 	99, 		2, 			'do form deduction_dressing_mgt', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- ECOLA Management -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form ecola_mgt'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				 name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_AccountConfiguration', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 					dispval, 				barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_ECOLAManagement', 	'ECOLA Management', 	99, 		2, 			'do form ecola_mgt', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- CTPA Management -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form ctpamgt'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 				dispval, 			barorder, 	priorityno, Action, 			withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_CTPAManagement', 	'CTPA Management', 	99, 		2, 			'do form ctpamgt', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- SEA Management -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form seamgt'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 				dispval, 			barorder, 	priorityno, Action, 			withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_SEAManagement', 	'SEA Management', 	99, 		2, 			'do form seamgt', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Record Archiever -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form RecordArchiever'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				 name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_AccountConfiguration', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 					dispval, 			barorder, 	priorityno, 	Action, 			withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_RecordArchiever', 	'Record Archiever', 	99, 	2, 				'do form RecordArchiever', 	0);	" 
	SQLEXEC(nconn, msql)
	
ENDIF 

msql = "select * from "+xpay+".sysmenu where action = 'do form archieve_transaction'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 						dispval, 				barorder, 	priorityno, 	Action, 							withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_TransactionArchiever', 	'Transation Archiver', 	104, 		2, 				'do form archieve_transaction', 	0);	" 
	SQLEXEC(nconn, msql)
endif 

*-------- Tax Setter -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form tax_mapper'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				 name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_AccountConfiguration', '',   		'\\-', 		  99,        2,          ' ', 		0)"
	SQLEXEC(xconn,msql)
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 			dispval, 		barorder, 	priorityno, Action, 				withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_TaxSetter', 	'Tax Setter', 	99, 		2, 			'do form tax_mapper', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Employee Account Exemption -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form  deduction_exemption_management'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 							dispval, 						barorder, 	priorityno, Action, 									withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_EmployeeAccountExemption', 	'Employee Account Exemption', 	99, 		2, 			'do form  deduction_exemption_management', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- 13th Month Settings -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where action = 'do form 13mosettings'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 					name, 					dispval, 				barorder, 	priorityno, Action, 					withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_AccountConfiguration', 	'_13thMonthSettings', 	'13th Month Settings', 	99, 		2, 			'do form 13mosettings', 	0);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*******************************************************************************************
*---- Reports ******************************************************************************
*******************************************************************************************
*-------- Earnings Report -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'EarningsReport'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 				dispval, 			barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'EarningsReport', 	'Earnings Report', 	99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Deduction Report -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'DeductionReport'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 				dispval, 			barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'DeductionReport', 	'Deduction Report', 99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Payroll Standard Report -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'PayrollStandardReport'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 						dispval, 					barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'PayrollStandardReport', 	'Payroll Standard Report', 	99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Payroll Government Report -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'PayrollGovernmentReport'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 						dispval, 						barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'PayrollGovernmentReport', 	'Payroll Government Report', 	99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- SSS,PHIC,PAGIBIG -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'SSSPHICPAGIBIG'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 				dispval, 				barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'SSSPHICPAGIBIG', 	'SSS,PHIC,PAGIBIG', 	99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 
*-------- Others -------------------------------------------------------------
msql = "select * from "+xpay+".sysmenu where name = 'Others'"
SQLEXEC(nconn, msql,'x')
IF 	RECCOUNT('x') = 0 
	msql = 	" Insert into "+xpay+".`sysmenu` (sourcetype, source, 		name, 		dispval, 	barorder, 	priorityno, Action, 	withchild) " + ; 
			" Values 						 ( 'BAR', 	  '_Reports', 	'Others', 	'Others', 	99, 		2, 			'', 		1);	" 
	SQLEXEC(nconn, msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- Earnings Report ----------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Earnings Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMEARNSUM'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  				dispval,            barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'EarningsReport', '_EarningsSummary',	'Earnings Summary', 99,       3,          'DO FORM FRMEARNSUM', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Earnings History ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMEARNSUMEMP'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  				dispval,            barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'EarningsReport', '_EarningsHistory',	'Earnings History', 99,       3,          'DO FORM FRMEARNSUMEMP', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Monthly Earnings Report ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMEARNMONTHLY'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  						dispval,            		barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'EarningsReport', '_MonthlyEarningsReport',	'Monthly Earnings Report', 	99,       3,          'DO FORM FRMEARNMONTHLY', 0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- Deduction Report ----------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Deduction Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDSUM'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   			name,  					dispval,            	barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'DeductionReport', 	'_DeductionsSummary',	'Deductions Summary', 	99,       3,          'DO FORM FRMDEDSUM', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Consolidated Deduction Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form rptdedsummary'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   			name,  						dispval,            				barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'DeductionReport', 	'_ConsoDeductionSummary',	'Consolidated Deduction Summary', 	99,       3,          'do form rptdedsummary', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- Deductions History ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDSUMEMP'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   			name,  					dispval,            	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'DeductionReport', 	'_DeductionsHistory',	'Deductions History', 	99,       3,          'DO FORM FRMDEDSUMEMP', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Monthly Deduction Report ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDMONTHLY'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   			name,  						dispval,            		barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'DeductionReport', 	'_MonthlyDeductionsReport',	'Monthly Deduction Report', 99,       3,          'DO FORM FRMDEDMONTHLY', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- Payroll Standard Report ----------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Payslip ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPS'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  		dispval,    barorder, priorityno, action,   		withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_Payslip',	'Payslip', 	01,       3,          'DO FORM FRMPS', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Payslip per Employee ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPSPEREMPLOYEE'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,    			barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_PayslipPerEmployee',	'Payslip per Employee', 02,       3,          'DO FORM FRMPSPEREMPLOYEE', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Bank Advice ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBANKADVISE'"
SQLEXEC(xconn,msql,'x')
IF 	RECCOUNT('x') = 0
	*msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_PayrollStandardReport', '',   		'\\-', 		   02,         3,          ' ', 		0)"
	*SQLEXEC(xconn,msql) 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  			dispval,    	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_BankAdvice',	'Bank Advice', 	08,       3,          'DO FORM FRMBANKADVISE', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Bank Charge ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBANKCHARGE'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  			dispval,    	barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_BankCharge',	'Bank Charge', 	10,       3,          'DO FORM FRMBANKCHARGE', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Bank Text File ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBANKTEXTFILE'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  				dispval,    		barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_BankTextFile',	'Bank Text File', 	9,        3,          'DO FORM FRMBANKTEXTFILE', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Payroll Register ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAYROLLREGISTER'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  				dispval,    		 	barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_PayrollRegister',	'Payroll Register', 	4,        3,          'DO FORM FRMPAYROLLREGISTER', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Payroll Register (Per Account) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAYROLLREGISTERPERACCT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  							dispval,    						barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_PayrollRegisterPerAccount',	'Payroll Register Per Account', 	5,        3,          'DO FORM FRMPAYROLLREGISTERPERACCT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Payroll Register Masterlist ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM payroll_summary4'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  							dispval,    					barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_PayrollRegisterMasterlist',	'Payroll Register Masterlist', 	6,        3,          'DO FORM payroll_summary4', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- Loan Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDSUM'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_PayrollStandardReport', '',   		'\\-', 		  99,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  			dispval,            barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_LoanSummary',	'Loan Summary', 	99,       3,          'do form loans_management', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Payroll Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMDEDSUM'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  				dispval,            barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_PayrollSummary',	'Payroll Summary', 	99,       3,          'do form payroll_register4', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- 13th Month Detailed------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13THMONTHDETAILED'"
SQLEXEC(xconn,msql,'x')
IF 	RECCOUNT('x') = 0
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      '_PayrollStandardReport', '',   		'\\-', 		  99,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,    			barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthDetailed',	'13th Month Detailed', 	12,       3,          'DO FORM FRM13THMONTHDETAILED', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Detailed (Per Client) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13DTLPERCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,            				barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMoDtlPerClient',	'13th Month Detailed per Group', 	14,       3,          'DO FORM FRM13DTLPERCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Detailed (Per Employee) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13DTLPEREMP'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  				dispval,            				barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMoDtlPerEmp',	'13th Month Detailed per Employee', 13,       3,          'DO FORM FRM13DTLPEREMP', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Summary ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13THMONTHSUMMARY'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,            	barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthSummary',	'13th Month Summary', 	16,       3,          'DO FORM FRM13THMONTHSUMMARY', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Summary (Per Client) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13SUMMARYCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  							dispval,            				barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthSummaryPerClient',	'13th Month Summary per Group', 	18,       3,          'DO FORM FRM13SUMMARYCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Summary (Per Employee) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13SUMMARYEMP'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  						dispval,            				barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthSummaryPerEmp',	'13th Month Summary per Employee', 	17,       3,          'DO FORM FRM13SUMMARYEMP', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Register ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM132REGISTER'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,            	barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthRegister',	'13th Month Register', 	20,       3,          'DO FORM FRM132REGISTER', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Register (Per Group) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRM13REGISTER'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  							dispval,            				barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthRegisterPerClient',	'13th Month Register Per Group', 	22,       3,          'DO FORM FRM13REGISTER', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 


*-------- 13th Month Voucher ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM frm13thmonthvoucher'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,            	barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthVoucher',	'13th Month Voucher', 	22,       3,          'DO FORM frm13thmonthvoucher', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- 13th Month Bank Advice ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBA13'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   				name,  					dispval,            		barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'PayrollStandardReport', 	'_13thMonthBankAdvice',	'13th Month Bank Advice', 	24,       3,          'DO FORM FRMBA13', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- Payroll Government Report ----------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*--------  Dressed Payslip ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form frmps_deduction_dressing'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   					name,  				dispval,            barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'PayrollGovernmentReport', 	'_DressedPayslip',	'Dressed Payslip', 	99,       3,          'do form frmps_deduction_dressing', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*--------  Payroll Register (per acct) ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form dressed_frmpayrollregisterperacct.scx'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   					name,  						dispval,            			barorder, priorityno, action,   										withchild) ' + ; 
			" values 					 ('BAR',      'PayrollGovernmentReport', 	'_PayrollRegisterPerAcct',	'Payroll Register (per acct)', 	99,       3,          'do form dressed_frmpayrollregisterperacct.scx', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*--------  Bank Advice ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form dressed_frmbankadvise.scx'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   					name,  			dispval,        barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'PayrollGovernmentReport', 	'_BankAdvice',	'Bank Advice', 	99,       3,          'do form dressed_frmbankadvise.scx', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*--------  Bank Text File ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form dressed_frmbanktextfile'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   					name,  				dispval,        	barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'PayrollGovernmentReport', 	'_BankTextFile',	'Bank Text File', 	99,       3,          'do form dressed_frmbanktextfile', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------------------------------------------------------------------------------------------------------------*
*---- SS,PHIC,PAGIBIG -------------------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Pagibig Contribution Summary ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAGIBIGCONTRIBUTION'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  								dispval,						barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PagibigContributionSummary',	'Pagibig Contribution Summary', 99,       3,          'DO FORM FRMPAGIBIGCONTRIBUTION', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Pagibig Contribution Remittance ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAGIBIGCONTREMIT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  							dispval,							barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PagibigContRemittance',	'Pagibig Contribution Remittance', 	99,       3,          'DO FORM FRMPAGIBIGCONTREMIT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Pagibig Contribution Remittance (per Group) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAGIBIGPERCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  								dispval,											barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PagibigContRemitPerClient',	'Pagibig Contribution Remittance (per Group)', 	99,       3,          'DO FORM FRMPAGIBIGPERCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Pagibig Loan Remittance ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPAGIBIGLOANREMIT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  							dispval,					barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PagibigLoanRemittance',	'Pagibig Loan Remittance', 	99,       3,          'DO FORM FRMPAGIBIGLOANREMIT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- HDMF Loan Remittance ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMHDMFLOANREMIT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,					barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_HDMFLoanRemittance',	'HDMF Loan Remittance', 	99,       3,          'DO FORM FRMHDMFLOANREMIT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- PhilHealth Contribution ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPHILHEALTHCONTRIBUTION'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    			name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      'SSSPHICPAGIBIG', 	'',   		'\\-', 		  99,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  							dispval,					barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PhilHealthContribution',	'PhilHealth Contribution', 	99,       3,          'DO FORM FRMPHILHEALTHCONTRIBUTION', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- PhilHealth Remittance (TEXT FILE) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPHICQUARTERLY'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  							dispval,								barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PHICRemittanceTEXTFILE',	'PhilHealth Remittance (TEXT FILE)', 	99,       3,          'DO FORM FRMPHICQUARTERLY', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- PhilHealth ER2 ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM PHIC_ER2'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,			barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_PhilHealthER2',	'PhilHealth ER2', 	99,       3,          'DO FORM PHIC_ER2', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- PhilHealth (monthly) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPHMO'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,				barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_PhilHealthMonthly',	'Monthly PHIC Report', 	99,       3,          'DO FORM FRMPHMO', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- PhilHealth (monthly per Group) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMPHMOPERCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  				dispval,					barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_PHICMoPerClient',	'PHIC Monthly per Group', 	99,       3,          'DO FORM FRMPHMOPERCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF
 
*-------- SSS R1-A ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM SSS_R1A'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    			name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      'SSSPHICPAGIBIG', 	'',   		'\\-', 		  99,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   			name,  		dispval,		barorder, priorityno, action,   			withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', 	'_SSSR1-A',	'SSS R1-A', 	99,       3,          'DO FORM SSS_R1A', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- SSS Loan Remittance ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMSSSLOANREMITTANCE'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  				dispval,				barorder, priorityno, action,   						withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_SSSLoanRemitt',	'SSS Loan Remittance', 	99,       3,          'DO FORM FRMSSSLOANREMITTANCE', 	0)"
	SQLEXEC(xconn,msql)
ENDIF
*-------- SSS Contribution Remittance ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMSSSCONTREMIT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,							barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_SSSContRemittance',	'SSSS Contribution Remittance', 	99,       3,          'DO FORM FRMSSSCONTREMIT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF
*-------- SSS Contribution Remittance (Adjusted) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMSSSCONTREMIT2'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  						dispval,									barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_SSSContRemittanceAdj',	'SSS Contribution Remittance Adjusted', 	99,       3,          'DO FORM FRMSSSCONTREMIT2', 	0)"
	SQLEXEC(xconn,msql)
ENDIF
*-------- SSS Contribution Per Group ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMSSSCONTREMITPERCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,						barorder, priorityno, action,   							withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_SSSContPerclient',	'SSS Contribution per Group', 	99,       3,          'DO FORM FRMSSSCONTREMITPERCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF
*-------- SSS Payment Module ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form paymentsss'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  					dispval,				barorder, priorityno, action,   				withchild) ' + ; 
			" values 					 ('BAR',      'SSSPHICPAGIBIG', '_SSSPaymentModule',	'SSS Payment Module', 	99,       3,          'do form paymentsss', 	0)"
	SQLEXEC(xconn,msql)
ENDIF


*-------------------------------------------------------------------------------------------------------------*
*---- Others -------------------------------------------------------------------------------------------------*
*-------------------------------------------------------------------------------------------------------------*
*-------- Loan Summary ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form loans_management'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  			dispval,		barorder, priorityno, action,   					withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_LoanSummary',	'Loan Summary', 99,       3,          'do form loans_management', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Retirement ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form rptretirement'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  			dispval,		barorder, priorityno, 	action,   					withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_Retirement',	'Retirement', 99,       3,          	'do form rptretirement', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Grp Retirement ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form rptretirement_grp'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  				dispval,			barorder, priorityno, 	action,   						withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_GrpRetirement',	'Grp Retirement', 	99,       3,          	'do form rptretirement_grp', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Account Total ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMACCOUNTTOTALS'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  				dispval,			barorder, priorityno, 	action,   						withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_AccountTotal',	'Account Total', 	99,       3,          	'DO FORM FRMACCOUNTTOTALS', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Grand Total ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMTOTALDED'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  			dispval,		barorder, priorityno, 	action,   						withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_GrandTotal',	'Grand Total', 	99,       3,          	'DO FORM FRMTOTALDED', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Summary Per Group ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMSUMPERCLIENT'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  					dispval,				barorder, priorityno, 	action,   					withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_SummaryPerClient',	'Summary per Group', 	99,       3,          	'DO FORM FRMSUMPERCLIENT', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Witholding Tax Compliance Report ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMWTCR'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  						dispval,							barorder, priorityno, 	action,   			withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_WTaxComplianceReport',	'Witholding Tax Compliance Report', 99,       3,          	'DO FORM FRMWTCR', 	0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Balance Report (current) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBLANCEREP'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  						dispval,					barorder, priorityno, 	action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_BalanceReportCurrent',	'Balance Report Current', 	99,       3,          	'DO FORM FRMBLANCEREP', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Balance Report (By Date) ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'DO FORM FRMBLANCEREP2'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  							dispval,					barorder, priorityno, 	action,   				withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_BalanceReportCurrentByDate',	'Balance Report by Date', 	99,       3,          	'DO FORM FRMBLANCEREP2', 0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- COE---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form coe'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  	dispval,	barorder, priorityno, 	action,   		withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_COE',	'COE', 		99,       3,          	'do form coe',  0)"
	SQLEXEC(xconn,msql)
ENDIF 
*-------- Quit Claims ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form FRMAR'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  			dispval,		barorder, priorityno, 	action,   			withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_QuitClaims',	'Quit Claims', 	99,       3,          	'DO FORM FRMAR',  	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- Manhour Report ---------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form rep_dutyrendered'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   	name,  		dispval,		 barorder, priorityno, 	action,   					withchild) ' + ; 
			" values 					 ('BAR',      'Others', 	'_ManHour',	'Duty Rendered', 99,       3,          	'DO FORM rep_dutyrendered', 0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- Payslip Divider ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where barorder = 3 and source = 'PayrollStandardReport' " 
SQLEXEC(xconn,msql,'x')
IF 	RECCOUNT('x') = 0
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,       barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      'PayrollStandardReport',  '',   		'\\-', 		  3,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
ENDIF

*-------- Payroll Register Divider ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where barorder = 7 and source = 'PayrollStandardReport' " 
SQLEXEC(xconn,msql,'x')
IF 	RECCOUNT('x') = 0
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,      barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      'PayrollStandardReport',  '',   		'\\-', 		  7,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
ENDIF

*-------- Bank Advise Divider ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where barorder = 11 and source = 'PayrollStandardReport' " 
SQLEXEC(xconn,msql,'x')
IF 	RECCOUNT('x') = 0
	msql = 	' insert into '+xpay+'.sysmenu (sourceType, source,    				  name, 		dispval,      barorder, priorityno, action,     withchild) ' + ; 
			" values 					   ('BAR',      'PayrollStandardReport',  '',   		'\\-', 		  11,        3,          ' ', 		0)"
	SQLEXEC(xconn,msql) 
ENDIF

*-------- rETRO pAY ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form retro_pay'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  			dispval,				barorder, priorityno, 	action,   				withchild) ' + ; 
			" values 					 ('BAR',      '_Transaction', 	'_RetroPay',	'Retro-Pay Calculator', 99,       2,          	'DO FORM retro_pay',  	0)"
	SQLEXEC(xconn,msql)
ENDIF 

*-------- rETRO pAY ------------------------------------------------------------------------------------
msql = "select * from " + xpay + ".sysmenu where action = 'do form retro_pay_days'"
SQLEXEC(xconn,msql,'x')
IF RECCOUNT('x') = 0 
	msql = 'insert into '+xpay+'.sysmenu (sourceType, source,   		name,  			dispval,					   		barorder, priorityno, 	action,   					withchild) ' + ; 
			" values 					 ('BAR',      '_Transaction', 	'_RetroPayDays',	'Retro-Pay Calculator (Days)', 	99,       2,          	'DO FORM retro_pay_days',  	0)"
	SQLEXEC(xconn,msql)
ENDIF 
