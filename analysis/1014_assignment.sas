
proc means data=arec559.segment1 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment1 Non choosers";
	run;
proc means data=arec559.segment1 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment1 Choosers";
	run;
	
proc means data=arec559.segment2 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment2 Non choosers";
	run;
proc means data=arec559.segment2 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment2 Choosers";
	run;

proc means data=arec559.segment3 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment3 Non choosers";
	run;
proc means data=arec559.segment3 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment3 Choosers";
	run;
	
proc means data=arec559.segment4 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment4 Non choosers";
	run;
proc means data=arec559.segment4 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment4 Choosers";
	run;

proc means data=arec559.segment5 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment5 Non choosers";
	run;
proc means data=arec559.segment5 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment5 Choosers";
	run;
	
proc means data=arec559.segment6 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment6 Non choosers";
	run;
proc means data=arec559.segment6 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment6 Choosers";
	run;
	
proc means data=arec559.segment9 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment9 Non choosers";
	run;
proc means data=arec559.segment9 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment9 Choosers";
	run;
	
proc means data=arec559.segment10 n;
	where email_optout_ind=0; 
	var cm11;
	title "segment10 Non choosers";
	run;
proc means data=arec559.segment10 n;
	where email_optout_ind_prior=0 and email_optout_ind_new=1; 
	var cm11; 
	title "segment10 Choosers";
	run;
	
