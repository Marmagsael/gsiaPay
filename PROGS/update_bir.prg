msql = "update " + xpay + ".sysmenu set withChild = 1 where name = 'BIR' and dispval = 'BIR'" 
SQLEXEC(nconn, msql)
