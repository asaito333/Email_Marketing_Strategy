/**Import datasets**/

PROC IMPORT DATAFILE="/home/asaito10/AREC559/privacy_choice_cm_extract.xlsx"
		    OUT=choice
		    DBMS=XLSX
		    REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/asaito10/AREC559/p_c_contact_history.csv"
		    OUT=contact_history
		    DBMS=csv
		    REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/asaito10/AREC559/p_c_spend_extract.csv"
		    OUT=spend
		    DBMS=csv
		    REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/asaito10/AREC559/p_c_attributes.csv"
		    OUT=attributes
		    DBMS=csv
		    REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/asaito10/AREC559/p_c_cmpgn_dimension.csv"
		    OUT=cmpgn
		    DBMS=csv
		    REPLACE;
RUN;

PROC IMPORT DATAFILE="/home/asaito10/AREC559/nochoice_pop_mkting_indicators_as_of_20140801.csv"
		    OUT=nochoice
		    DBMS=csv
		    REPLACE;
RUN;

/*table for Venn diagram of optin status*/
proc freq data=choice;
table direct_mail_optout_ind_prior*email_optout_ind_prior*obtm_optout_ind_prior/list;
run;
proc freq data=choice;
table direct_mail_optout_ind_new*email_optout_ind_new*obtm_optout_ind_new/list;
run;

/*table for inin, inout,..., table*/
proc freq data=choice;
table direct_mail_optout_ind_prior*direct_mail_optout_ind_new/list;
run;
proc freq data=choice;
table email_optout_ind_prior*email_optout_ind_new/list;
run;
proc freq data=choice;
table obtm_optout_ind_prior*obtm_optout_ind_new/list;
run;

/*confirm if cm11 is unique*/
proc contents data=nochoice;run;

/*table for optin status for 'do-nothing'*/
proc freq data=nochoice;
table direct_mail_optout_ind*email_optout_ind*obtm_optout_ind/list;
 run;

/*self study*/
proc contents data=spend; run;
proc contents data=contact_history; run;
proc contents data=cmpgn; run;
proc contents data=attributes; run;
proc contents data=nochoice; run;

data spend1;
	set spend;
	if cm11 ne 30000056946 then delete;
	run;
proc contents data=spend1;
run;
proc print data=spend1;
run;
data contact_history1;
	set contact_history;
	if cm11 ne 30000056946 then delete;
	run;
proc contents data=contact_history1;
run;
proc sort data=contact_history1;
 by trans_dt;
 run;
proc print data=contact_history1;
run;
proc sort data=contact_history;
by trans_dt;
 run;
proc print data=contact_history (firstobs = 1 obs = 1);
run;


