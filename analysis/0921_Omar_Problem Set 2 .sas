libname amexraw '/folders/myfolders/AMEX RAW';

libname amexwork '/folders/myfolders/AMEX_working_files';

proc contents data=amexwork.aggregate_spending_before;run;

proc contents data=amexwork.aggregate_spending_after;run;


/*Question 5: Merging aggregated spending before and after with privacy choice,
product dimension and nochoice  */
proc contents data=amexraw.product_dimension; run;

proc freq data=amexraw.product_dimension levels;
tables lob_cd prod_pay_type_cd prod_grp_id/list;run; /*lob=line of business*/


/*Creating a temporary dataset without library name
 since sql doesn't merge with consecutive dots  */
data privacy_choice;
set amexraw.privacy_choice_cm_extract;run;


data product_dimension;
set amexraw.product_dimension;run;


proc contents data=amexwork.aggregate_spending_before;run;
proc contents data=privacy_choice;run;


data aggregate_spending_before;
set amexwork.aggregate_spending_before; run;

/* 399,967 rows and 19 columns */
proc sql;
create table merge1 as 
select*
from aggregate_spending_before
left join privacy_choice
 on aggregate_spending_before.cm11= privacy_choice.cm11;
quit;


/*now merging with product dimension  */

/*399,967 rows and 24 columns  */
proc sql;
create table merge2 as 
select*
from merge1
left join product_dimension
 on merge1.prod_id= product_dimension.prod_id;
quit;


proc freq data=merge2 levels;
tables lob_cd prod_pay_type_cd/list;run;

/*Spending by costumer type BEFORE  */
proc means data=merge2 n nmiss mean min max;
var totalspend totaltrans;where lob_cd='OPEN';run;

proc means data=merge2 n nmiss mean min max;
var totalspend totaltrans;where lob_cd='CONSUMER';run;

proc means data=merge2 n nmiss mean min max;
var totalspend totaltrans;where prod_pay_type_cd='LENDING';run;

proc means data=merge2 n nmiss mean min max;
var totalspend totaltrans;where prod_pay_type_cd='CHARGE'
;run;

proc contents data=merge2;run;
proc contents data=amexraw.nochoice;run; 
 
 proc means data=merge2 n nmiss mean min max sum;
 var email_optout_ind_new email_optout_ind_prior direct_mail_optout_ind_new 
 	direct_mail_optout_ind_prior
	obtm_optout_ind_new obtm_optout_ind_prior;run;
 
 
 data nochoice;
 set amexraw.nochoice;run;
 
 
 
/*Now merging with no choice   */
 
/*399967 rows and 27 columns.   */
 proc sql;
create table merge2b as 
select*
from merge2
left join nochoice
 on merge2.cm11= nochoice.cm11;
quit;
 
 
 
 proc means data=merge2b n nmiss mean min max sum;
 var email_optout_ind_new email_optout_ind_prior direct_mail_optout_ind_new 
 	direct_mail_optout_ind_prior
	obtm_optout_ind_new obtm_optout_ind_prior
    email_optout_ind
    direct_mail_optout_ind
    obtm_optout_ind;run;


proc contents data=merge2b;run;

/*Saving permanent dataset spending before +product dimension
choice and nochoice  */
data amexwork.spend_before_with_choice;
set merge2b;run;

proc contents data=amexwork.spend_after_with_choice;run;
proc contents data=amexwork.spend_before_with_choice;run;
/* ----------------------------------------------- */

data aggregate_spending_after;
set amexwork.aggregate_spending_after; run;

/* 399,967 rows and 19 columns */
proc sql;
create table merge3 as 
select*
from aggregate_spending_after
left join privacy_choice
 on aggregate_spending_after.cm11= privacy_choice.cm11;
quit;


/*now merging with product dimension  */

/*399,967 rows and 24 columns  */
proc sql;
create table merge4 as 
select*
from merge3
left join product_dimension
 on merge3.prod_id= product_dimension.prod_id;
quit;


proc freq data=merge4 levels;
tables lob_cd prod_pay_type_cd/list;run;

/*Spending by costumer type After  */
proc means data=merge4 n nmiss mean min max;
var totalspend totaltrans;where lob_cd='OPEN';run;

proc means data=merge4 n nmiss mean min max;
var totalspend totaltrans;where lob_cd='CONSUMER';run;

proc means data=merge4 n nmiss mean min max;
var totalspend totaltrans;where prod_pay_type_cd='LENDING';run;

proc means data=merge4 n nmiss mean min max;
var totalspend totaltrans;where prod_pay_type_cd='CHARGE'
;run;

proc contents data=merge4;run;
proc contents data=amexraw.nochoice;run; 
 
 proc means data=merge4 n nmiss mean min max sum;
 var email_optout_ind_new email_optout_ind_prior direct_mail_optout_ind_new 
 	direct_mail_optout_ind_prior
	obtm_optout_ind_new obtm_optout_ind_prior;run;
 
 
 
 
/*Now merging with no choice   */
 
/*399967 rows and 27 columns.   */
 proc sql;
create table merge4b as 
select*
from merge4
left join nochoice
 on merge4.cm11= nochoice.cm11;
quit;
 
 
 proc means data=merge4b n nmiss mean min max sum;
 var email_optout_ind_new email_optout_ind_prior direct_mail_optout_ind_new 
 	direct_mail_optout_ind_prior
	obtm_optout_ind_new obtm_optout_ind_prior
    email_optout_ind
    direct_mail_optout_ind
    obtm_optout_ind;run;


proc contents data=merge4b;run;

/*Saving permanent dataset spending before +product dimension
choice and nochoice  */
data amexwork.spend_after_with_choice;
set merge4b;run;


proc contents data=amexwork.spend_after_with_choice;run;
/* MAKING DUMMIES FOR ALL CATEGORY VARIABLES */
proc freq data=amexwork.spend_before_with_choice;
tables lob_cd prod_grp_id prod_pay_type_cd/list;run;











/*QUESTION 1: checking consistency between transactions and spending  */
title 'Spending and Transactions Before';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; run;

title 'Spending and Transactions Before----Where transactions is positive';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans>0; run;

/*605 Transactions POsitive, negative spending  */
title 'Spending and Transactions Before----Where transactions is positive
and spending is negative';

proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans>0 and totalspend<0; run;











/*177,012  have zero transactions*/
title 'Spending and Transactions Before----Where transactions is 0';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans=0; run;


/*1,595 have negative spending  */
title 'Spending and Transactions Before----Where spending is negative';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0; run;

/*176,963 have zero spending  */
title 'Spending and Transactions Before----Where spending is 0';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0; run;


/**************************** AFTER ********************/
title 'Spending and Transactions AFTER--Where transactions is 0';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans=0; run;

title 'Spending and Transactions AFTER----Where transactions is positive';
proc means data=amexwork.spend_AFTER_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans>0; run;


/*119,006  have zero transactions*/
title 'Spending and Transactions after----Where transactions is 0';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans=0; run;


/*1,539 have negative spending  */
title 'Spending and Transactions after----Where spending is negative';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0; run;

/*720 Transactions POsitive negative spending  */
title 'Spending and Transactions after----Where transactions is positive
and spending is negative';

proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totaltrans>0 and totalspend<0; run;



/*120,080 have zero spending  */
title 'Spending and Transactions after----Where spending is 0';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0; run;

/*278,348 have positive spending  */
title 'Spending and Transactions after----Where spending is positive';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend>0; run;

/*******************Do nothings vs choosers before************  */


/* 120,546 do nothings with zero */
title 'Spending and Transactions before Do nothings----Where spending is 0';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0 and totalchooser=0; run;

/* 56,417 choosers have zero spending */
title 'Spending and Transactions before Choosers----Where spending is 0';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0 and totalchooser=1; run;

/* 1,070 do nothings with negatove */
title 'Spending and Transactions before Do nothings----Where spending is negative';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0 and totalchooser=0; run;

/* 525 choosers have negative */
title 'Spending and Transactions before Choosers----Where spending is 0';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0 and totalchooser=1; run;



/* 28,315 do nothings with POSITIVE */
title 'Spending and Transactions before Do nothings----Where spending is POSITIVE';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend>0 and totalchooser=0; run;

/* 193,094 choosers have POSITIVE */
title 'Spending and Transactions before Choosers----Where spending is POSITVE';
proc means data=amexwork.spend_before_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend>0 and totalchooser=1; run;




/*******************Do nothings vs choosers after************  */

/* 59,195 do nothings with zero */
title 'Spending and Transactions after Do nothings----Where spending is 0';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0 and totalchooser=0; run;

/* 60,885 choosers have zero spending */
title 'Spending and Transactions after Choosers----Where spending is 0';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend=0 and totalchooser=1; run;

/* 279 do nothings with negative */
title 'Spending and Transactions after Do nothings----Where spending is negative';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0 and totalchooser=0; run;

/* 1,260 choosers have negative */
title 'Spending and Transactions after Choosers----Where spending is Negative';
proc means data=amexwork.spend_after_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend<0 and totalchooser=1; run;


/* 28,315 do nothings with POSITIVE */
title 'Spending and Transactions before Do nothings----Where spending is POSITIVE';
proc means data=amexwork.spend_AFTER_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend>0 and totalchooser=0; run;

/* 193,094 choosers have POSITIVE */
title 'Spending and Transactions before Choosers----Where spending is POSITVE';
proc means data=amexwork.spend_AFTER_with_choice n nmiss mean median min max;
var totalspend totaltrans; where totalspend>0 and totalchooser=1; run;





/*Creating dataset with just afterspending and joining to before spending  */

data after;
set amexwork.spend_after_with_choice (keep=cm11 totalspend);
run;

data after2;
set after (rename=(totalspend=afterspend));
run;

proc contents data=after2;run;

data before;
set amexwork.spend_before_with_choice (rename= (totalspend=beforespend));
run;


/*399,967 rows and 28 columns.   */
 proc sql;
create table complete_spend as 
select*
from before
left join after2
 on before.cm11= after2.cm11;
quit;

/* 41 with negative spending before and after */
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where beforespend<0 and afterspend<0; run; 

/* 111,940 with zero spending before and after */
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where beforespend=0 and afterspend=0; run; 



/* 52,928 choosers with zero spending before and after */
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where beforespend=0 and afterspend=0
 and totalchooser=1;run; 
 
 
/* 59,012 do nothings with zero spending before and after */
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where beforespend=0 and afterspend=0
 and totalchooser=0;run; 
 
 
 
 
/* 994  Positive spending before and negative spending aftter 

out of which 971 are choosers*/

proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where beforespend>0 and afterspend<0
;run; 


proc contents data=amexwork.aggregated_contact;
run;

proc contents data=complete_spend;run;

/*Type of customer by choice either chooser or do nothing  */
proc freq data=complete_spend levels;
tables prod_pay_type_cd lob_cd/list;where totalchooser=0;run;
proc freq data=complete_spend levels;
tables prod_pay_type_cd lob_cd/list;where totalchooser=1;run;


title 'OPEN';
proc means data=complete_spend n nmiss mean min max ;
var beforespend afterspend; where lob_cd='OPEN';run;

title 'CONSUMER';
proc means data=complete_spend n nmiss mean min max ;
var beforespend afterspend; where lob_cd='CONSUMER';run;


title 'LENDING';
proc means data=complete_spend n nmiss mean min max ;
var beforespend afterspend; where prod_pay_type_cd='LENDING';run;

title 'CHARGE';
proc means data=complete_spend n nmiss mean min max ;
var beforespend afterspend; where prod_pay_type_cd='CHARGE';run;





/*****************PROBLEM 4******************************  */
title 'Average Spending for DO NOTHINGS';
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where totalchooser=0 and beforespend>0
and afterspend>0;run;


proc contents data=complete_spend;run;


title 'Average Spending for CHOOSERS';
proc means data=complete_spend n nmiss mean min max;
var beforespend afterspend; where totalchooser=1
and beforespend>0
and afterspend>0;run;


proc contents data=amexwork.spend_before_with_choice;run;
proc contents data=amexwork.spend_after_with_choice;run;

/*before appending datasets I will create a dummy for either before or after. I already have total
chooser  */

data before3;
set amexwork.spend_before_with_choice;
if cm11>0 then Before_dummy=1; else before_dummy=0;
run;

proc means data=before3 n nmiss sum min max;run;








data after3;
set amexwork.spend_after_with_choice;
if cm11>0 then Before_dummy=0; else before_dummy=1;
run;

proc means data=after3 n nmiss sum min max;var before_dummy;run;


/*appending  */

proc append base=before3 data=after3;
run;


proc contents data=before3;run;

proc means data=before3 n nmiss min max sum;
var before_dummy totalspend;run;


data difference;
set before3;
interaction_dummy=before_dummy*totalchooser;
run;

proc means data=difference n nmiss sum min max mean;
var interaction_dummy;run;


proc reg data=difference plots=none;
model totalspend= before_dummy totalchooser interaction_dummy;run;





/* Difference-indifference model for those who opted out of email and control */

data difference2;
set difference; where email_optout_ind=0 or 
				(email_optout_ind_prior=0 and email_optout_ind_new=1);
				run;
				
proc reg data=difference2 plots=none;
model totalspend= before_dummy totalchooser interaction_dummy;run;


proc contents data=difference;run;



