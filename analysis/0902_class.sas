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

/*check when customers made the choice of optin-out*/
proc contents data=choice;
run;

/*the distribution of decsion making time*/
/*univariate analysis to chose choice date*/
proc univariate data=choice;
	var choice_dt; /*calender number is shown different, googl it*/
	run;
/*at least 25% of cm = do-nothing*/
/*For do-nothing, choice date is 12/29/99*/
/*Get rid of do-nothing from data*/
data choice1;
	set choice;
	where choice_dt<2936547;
	run;
proc univariate data=choice1;
	var choice_dt;
	run;
/*Tha range of decision making is 3/1/14 to 8/28/14 */
/*Show in histogram*/
proc univariate data=choice1;
	var choice_dt;
	histogram choice_dt;
	run;
/*Narrow down the range of histogram into the decison making time*/
/*per day*/
proc univariate data=choice1;
	var choice_dt;
	histogram choice_dt/ midpoints= 19783 to 19963 by 1;
	run;
/*per week*/
proc univariate data=choice1;
	var choice_dt;
	histogram choice_dt/ midpoints= 19783 to 19963 by 7;
	run;
/*per month*/
proc univariate data=choice1;
	var choice_dt;
	histogram choice_dt/ midpoints= 19783 to 19963 by 30;
	run;

/*Count duplicates*/
/*By counting how many times each cm contacted*/
/*By creating var `numids` showing the number of # of frequency that*/
/*same cm11 appeared*/
proc sql;
	creat table num_dupes as 
	select * ,
	 freq(cm11) as numids
	from contact_history
	group by cm11;
run;
/*Show how many times each numids appeared on the data*/
proc freq data=num_dupes;
	tables numids / list nocum;
run;
/*Export to excel, devide frequency by numids*/
/*Get the actual # of contact appeared*/
