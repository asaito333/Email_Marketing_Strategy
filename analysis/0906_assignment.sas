PROC IMPORT DATAFILE="/home/asaito10/AREC559/p_c_spend_extract.csv"
		    OUT=spend
		    DBMS=csv
		    REPLACE;
RUN;

	
proc sql;
	create table spend1 as 
	select * ,
	 freq(cm11) as numids
	from spend
	group by cm11;
run;

proc means data=spend;
where spend_month=0;
run;

/*Create dummy for choice 1=choice 0=do nothing*/
data spend2;
	set spend1;
	if numids=24 then choice=0;
	if numids=25 then choice=1;
	run;
/*Devide into prior and after*/
data spend_prior;
	set spend2;
	if spend_month>-1 then delete;
	run;
data spend_after;
	set spend2;
	if spend_month<1 then delete;
	run;
/*Create cumulative amount*/
data spend_prior1;
	set spend_prior;
	by cm11;
	if first.cm11 then cumam_prior=0;
	cumam_prior+amount;
	if last.cm11 then output;
	drop amount;
run;
data spend_after1;
	set spend_after;
	by cm11;
	if first.cm11 then cumam_after=0;
	cumam_after+amount;
	if last.cm11 then output;
	drop amount;
run;	
/*Merge cum amount of prior and after*/
data spend3;
	merge spend_prior1 spend_after1;
	by cm11;
run;

/*Create cumulative number of transaction*/
data spend_prior2;
	set spend_prior;
	by cm11;
	if first.cm11 then cumtr_prior=0;
	cumtr_prior+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
	run;
data spend_after2;
	set spend_after;
	by cm11;
	if first.cm11 then cumtr_after=0;
	cumtr_after+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
	run;	
/*Merge cum trans for prior and after*/
data spend4;
	merge spend_prior2 spend_after2;
	by cm11;
run;

/*Merge cumamount and cumtrans into one dataset*/
/*Dataset: spend5*/
/*Variable:cm11 choice cumam_prior cumam_after cumtr_prior cumtr_after*/
data spend5;
	merge spend3 spend4;
	drop spend_month tran_cnt numids	amount;
	by cm11;
	run;

proc means data=spend5;run;
proc print data=spend5 (firstobs=1 obs=30); run;



/*Q3b; Create histograms for each group*/
proc univariate data=spend5; /*Choosers before event*/
	title "Choosers before event";
	where choice=1;
	var cumam_prior;
	histogram cumam_prior;
	run;	
proc univariate data=spend5; /*Choosers after event*/
	title "Choosers after event";
	where choice=1;
	var cumam_after;
	histogram cumam_after;
	run;		
proc univariate data=spend5; /*Do-nothing before event*/
	title "Do-nothing before event";
	where choice=0;
	var cumam_prior;
	histogram cumam_prior;
	run;		
proc univariate data=spend5; /*Do-nothing after event*/
	title "Do-nothing after event";
	where choice=0;
	var cumam_after;
	histogram cumam_after;
	run;		

/*Q3b; narrow down to ...*/
proc univariate data=spend5; /*Choosers before event*/
	title "Choosers before event";
	class choice;
	where cumam_prior between 0 and 1000;
	var cumam_prior;
	histogram cumam_prior/ endpoints=0 to 1000 by 100;
	run;	
proc univariate data=spend5;
	class choice;
	where cumam_after between 0 and 1000;
	var cumam_after;
	histogram cumam_after/ endpoints=0 to 1000 by 100;
	run;	


/*Q3c; Descriptive statistics*/
proc means data=spend5; /*Choosers before event*/
	title "Choosers before event";
	where choice=1;
	var cumam_prior;
	run;	
proc means data=spend5; /*Choosers after event*/
	title "Choosers after event";
	where choice=1;
	var cumam_after;
	run;		
proc means data=spend5; /*Do-nothing before event*/
	title "Do-nothing before event";
	where choice=0;
	var cumam_prior;
	run;		
proc means data=spend5; /*Do-nothing after event*/
	title "Do-nothing after event";
	where choice=0;
	var cumam_after;
	run;

proc means data=spend5;
where choice=0;
run;
proc means data=spend5;
where choice=1;
run;


proc print data=spend5 (firstobs=1 obs=30); run;
	
/*Work prior to MTG Sep8*/	
/*Create datasets only for choice/do nothing for prior/after */
data spend_choice_prior;
	set spend1;
	if numids=24 then delete;
	if spend_month>0 then delete;
	run;
data spend_choice_after;
	set spend1;
	if numids=24 then delete;
	if spend_month<1 then delete;
	run;
data spend_dono_prior;
	set spend1;
	if numids=25 then delete;
	if spend_month>0 then delete;
	run;
data spend_dono_after;
	set spend1;
	if numids=25 then delete;
	if spend_month<1 then delete;
	run;
proc print data=spend_choice_prior (firstobs=1 obs=30);run;
proc print data=spend_choice_after (firstobs=1 obs=30);run;
proc print data=spend_dono_prior (firstobs=1 obs=30);run;
proc print data=spend_dono_after (firstobs=1 obs=30);run;


/**question3a-spending amount**/
data spend_choice_prior1;
	set spend_choice_prior;
	by cm11;
	if first.cm11 then cumam=0;
	cumam+amount;
	if last.cm11 then output;
	drop amount;
run;
data spend_choice_after1;
	set spend_choice_after;
	by cm11;
	if first.cm11 then cumam=0;
	cumam+amount;
	if last.cm11 then output;
	drop amount;
run;
data spend_dono_prior1;
	set spend_dono_prior;
	by cm11;
	if first.cm11 then cumam=0;
	cumam+amount;
	if last.cm11 then output;
	drop amount;
run;
data spend_dono_after1;
	set spend_dono_after;
	by cm11;
	if first.cm11 then cumam=0;
	cumam+amount;
	if last.cm11 then output;
	drop amount;
run;

/**question3a-tran count**/
data spend_choice_prior2;
	set spend_choice_prior;
	by cm11;
	if first.cm11 then cumtr=0;
	cumtr+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
run;
data spend_choice_after2;
	set spend_choice_after;
	by cm11;
	if first.cm11 then cumtr=0;
	cumtr+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
run;
data spend_dono_prior2;
	set spend_dono_prior;
	by cm11;
	if first.cm11 then cumtr=0;
	cumtr+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
run;
data spend_dono_after2;
	set spend_dono_after;
	by cm11;
	if first.cm11 then cumtr=0;
	cumtr+tran_cnt;
	if last.cm11 then output;
	drop tran_cnt;
run;



/*try for amount and transaction at the same time*/
data spend_dono_after1;
	set spend_dono_after;
	by cm11;
	if first.cm11 then cumam=0 cumtr=0;
	cumam+amount;
	cumtr+tran_cnt;
	if last.cm11 then output;
	drop amount tran_cnt;
run;

proc print data=spend_choice_prior;
where cm11=30000575467;run;
/*can't make cum amount&transaction at one dataset*/

proc print data=spend_choice_prior2 (firstobs=1 obs=30);run;
proc print data=spend_choice_after1 (firstobs=1 obs=30);run;
proc print data=spend_dono_prior1 (firstobs=1 obs=30);run;
proc print data=spend_dono_after1 (firstobs=1 obs=30);run;

/**question3b**/
/*for spending*/

proc univariate data=spend_choice_prior1;
	var cumam;run;
proc univariate data=spend_choice_after1;
	var cumam;run;
proc univariate data=spend_dono_prior1;
	var cumam;run;
proc univariate data=spend_dono_after1;
	var cumam;run;		
/*for transaction # */
proc univariate data=spend_choice_prior2;
	where cumtr between 0 and 1000;
	var cumtr;
	histogram cumtr/ endpoints=0 to 1000 by 50;run;
proc univariate data=spend_choice_after2;
	where cumtr between 0 and 1000;
	var cumtr;
	histogram cumtr/ endpoints=0 to 1000 by 50;run;
proc univariate data=spend_dono_prior2;
	where cumtr between 0 and 1000;
	var cumtr;
	histogram cumtr/ endpoints=0 to 1000 by 50;run;
proc univariate data=spend_dono_after2;
	where cumtr between 0 and 1000;
	var cumtr;
	histogram cumtr/ endpoints=0 to 1000 by 50;run;		

	
/*take a close look at... */
proc univariate data=spend_choice_after1;
	where cumam between 5000 and 35000;
	var cumam;
	histogram cumam/ endpoints= 5000 to 35000 by 1000;
	run;



/**question 4**/
/*get var prod_id from data choice*/
PROC IMPORT DATAFILE="/home/asaito10/AREC559/privacy_choice_cm_extract.xlsx"
		    OUT=choice
		    DBMS=XLSX
		    REPLACE;
RUN;
proc contents data=choice;run;
