proc contents data=arec559.contact;run;
proc sort data=arec559.contact;
	by cm11 trans_dt;run;
proc print data=arec559.contact;
	where cm11=30000056946;
	run;

/*If the negative spenders are all lending cm?*/
proc print data=arec559.panel_lab2 (obs=500);
	where spend<0;
	var prod_pay_type_cd;
	run;