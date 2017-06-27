/*spend_lab2Q2; panel data*/
/*spend2_lab2Q2; cross sectional data*/
PROC IMPORT DATAFILE="/home/asaito10/AREC559/panel_data_for_Q4.xlsx"
		    OUT=arec559.spend_lab2Q2
		    DBMS=XLSX
		    REPLACE;
RUN;
PROC IMPORT DATAFILE="/home/asaito10/AREC559/spend_table_by_asumi.xlsx"
		    OUT=arec559.spend2_lab2Q2
		    DBMS=XLSX
		    REPLACE;
RUN;

/*Q2*/
proc means data=arec559.spend_lab2q2;
	title 'How many had no spend before the event in choosers?';
	where spend=0 and time=0 and choice=1;
	run;
proc means data=arec559.spend_lab2q2;
	title 'How many had no spend before the event in do-nothing?';
	where spend=0 and time=0 and choice=0;
	run;	
proc means data=arec559.spend_lab2q2;
	title 'How many had no spend after the event in choosers?';
	where spend=0 and time=1 and choice=1;
	run;
proc means data=arec559.spend_lab2q2;
	title 'How many had no spend after the event in do-nothing?';
	where spend=0 and time=1 and choice=0;
	run;	
proc means data=arec559.spend2_lab2q2;
	title 'How many had no spend both before/after the event in choosers?';
	where cumam_prior=0 and cumam_after=0 and choice=1;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had no spend both before/after the event in do-nothing?';
	where cumam_prior=0 and cumam_after=0 and choice=0;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend both before/after the event in choosers?';
	where cumam_prior<0 and cumam_after<0 and choice=1;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend both before/after the event in do-nothing?';
	where cumam_prior<0 and cumam_after<0 and choice=0;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend before the event in chooosers?';
	where cumam_prior<0 and choice=1;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend before the event in do-nothing?';
	where cumam_prior<0 and choice=0;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend after the event in choosers?';
	where cumam_after<0 and choice=1;
	run;
proc means data=arec559.spend2_lab2q2;
	title 'How many had negative spend after the event in do-nothing?';
	where cumam_after<0 and choice=0;
	run;


/*Q4*/
/*Merge datasets*/
/*Merge spend2_lab2q2 + choice by cm11*/
proc means data=arec559.spend2_lab2q2 n;run;
proc means data=arec559.choice n;run;
data spend_choice;
	merge arec559.spend2_lab2q2 arec559.choice;
	by cm11;
	run;
proc print data=spend_choice (firstobs=1 obs=30);run;
proc means data=arec559.nochoice n;run;
proc means data=arec559.product; run;

/*Merge spend_choice + product by prod_id */
PROC IMPORT DATAFILE="/home/asaito10/AREC559/product_dimension.csv"
		    OUT=prdct
		    DBMS=csv
		    REPLACE;
RUN;
proc sql;
	create table scp as
	select *
	from spend_choice
	left join prdct
	on spend_choice.prod_id	= prdct.prod_id;
	quit;

/*Merge scp + nochoice by cm11*/
data nocho;
	set arec559.nochoice;
	run;
proc sql;
	create table scpno as
	select *
	from scp
	left joint nocho
	on scp.cm11 = nocho.cm11;
	quit;

/*Make it as panel data*/
data before;
	set scpno;
	spend=cumam_prior;
	transaction=cumtr_prior;
	time=0;
	drop cumam_prior cumam_after cumtr_prior cumtr_after;
	run;
data after;
	set scpno;
	spend=cumam_after;
	transaction=cumtr_after;
	time=1;
	drop cumam_prior cumam_after cumtr_prior cumtr_after;
	run;
proc append base=before data=after;
proc sort data=before;
	by cm11;
	run;
/*Name panel_lab2, and save it*/
data arec559.panel_lab2;
	set before;
	run;
data arec559.panel_lab2;
	set arec559.panel_lab2;
	interaction=time*choice;
	run;

/*Run regression*/
proc reg data=arec559.panel_lab2;
	title "DiD for C)email opt in to in T)email opt in to out";
	where email_optout_ind=0 or (email_optout_ind_prior=0 and email_optout_ind_new=1);
	model spend=time choice interaction;
	test choice+interaction>0;
	run;

proc means data=arec559.panel_lab2;
	where email_optout_ind=0 and time=0 and spend>0;
	var spend;
	run;

/*means*/	
proc means data=arec559.panel_lab2;
	where email_optout_ind=0 and time=1 and spend>0;
	var spend;
	run;
			
proc means data=arec559.panel_lab2;
	where email_optout_ind_prior=0 and email_optout_ind_new=1 and time=0;
	var spend;
	run;
	
