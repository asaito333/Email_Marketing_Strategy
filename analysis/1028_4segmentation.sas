/* Create segments for con/bus*charge/lend */

data arec559.segment_lend_bus;
	set arec559.segment9 arec559.segment10;
	run;
data arec559.segment_lend_con;
	set arec559.segment3 arec559.segment4 arec559.segment11;
	run;


/* PSM */

data PS_charge_con_1;
	set arec559.segment_charge_con;
	where time=0 and (email_optout_ind=0 or (email_optout_ind_prior=0 and email_optout_ind_new=1));
	run;
proc sql;
	create table PS_charge_con_2 as
	select *
	from PS_charge_con_1
	left join arec559.attributes as a
	on PS_charge_con_1.cm11=a.cm11;
	quit;

data arec559.PS_charge_con;
	set PS_charge_con_2;
	
	/* Create age dummy: default is [UKN] */
	if age_grp= '[18-24]' then age_18_24=1; else age_18_24=0;
	if age_grp= '[25-30]' then age_25_30=1; else age_25_30=0;
	if age_grp= '[31-35]' then age_31_35=1; else age_31_35=0;
	if age_grp= '[36-40]' then age_36_40=1; else age_36_40=0;
	if age_grp= '[41-50]' then age_41_50=1; else age_41_50=0;
	if age_grp= '[51-60]' then age_51_60=1; else age_51_60=0;
	if age_grp= '[61+]' then age_61_plus=1; else age_61_plus=0;

	/* Create CDSS dummy: default is NA */
	if cdss='A= 0 - 1' then credit_A=1; else credit_A=0;
	if cdss='B= >1 - 3' then credit_B=1; else credit_B=0;
	if cdss='C= >3 - 5' then credit_C=1; else credit_C=0;
	if cdss='D= >5 - 1' then credit_D=1; else credit_D=0;
	if cdss='E= >10 -' then credit_E=1; else credit_E=0;
	if cdss='F= >15' then credit_F=1; else credit_F=0;

	/* Create gender dummy: default is U */
	if gender_cd='F' then Female=1; else Female=0;
	if gender_cd='M' then Male=1; else Male=0;
	
	/* mr_ind dummy: default is No */
	if mr_ind='Y' then Member_rewards=1; else member_rewards=0;
	
	/* fee_svc_count: default is 0*/
	if fee_svc_count=1 then count1=1; else count1=0;
	if fee_svc_count=2 then count2=1; else count2=0;
	if fee_svc_count=3 then count3=1; else count3=0;
	if fee_svc_count=4 then count4=1; else count4=0;
	if fee_svc_count=5 then count5=1; else count5=0;
	if fee_svc_count=6 then count6=1; else count6=0;
	if fee_svc_count=8 then count8=1; else count8=0;
	
	/* myca_count: default is 0 */
	if myca_count=1 then myca1=1; else myca1=0;
	if myca_count=2 then myca2=1; else myca2=0;
	if myca_count=3 then myca3=1; else myca3=0;
	if myca_count=4 then myca4=1; else myca4=0;
	
	/* times_30_dpd_in_12_mnths: default is 0 */
	if times_30_dpd_in_12_mnths=1 then time301=1; else time301=0;
	if times_30_dpd_in_12_mnths=2 then time302=1; else time302=0;
	if times_30_dpd_in_12_mnths=3 then time303=1; else time303=0;
	if times_30_dpd_in_12_mnths=4 then time304=1; else time304=0;
	if times_30_dpd_in_12_mnths=5 then time305=1; else time305=0;
	if times_30_dpd_in_12_mnths=6 then time306=1; else time306=0;
	if times_30_dpd_in_12_mnths=7 then time307=1; else time307=0;
	if times_30_dpd_in_12_mnths=8 then time308=1; else time308=0;
	if times_30_dpd_in_12_mnths=9 then time309=1; else time309=0;
	if times_30_dpd_in_12_mnths=10 then time3010=1; else time3010=0;
	if times_30_dpd_in_12_mnths=11 then time3011=1; else time3011=0;
	
	/* times_60_plus_dpd_in_12_mnths: default is 0*/
	if times_60_plus_dpd_in_12_mnths=1 then time601=1; else time601=0;
	if times_60_plus_dpd_in_12_mnths=2 then time602=1; else time602=0;
	if times_60_plus_dpd_in_12_mnths=3 then time603=1; else time603=0;
	if times_60_plus_dpd_in_12_mnths=4 then time604=1; else time604=0;
	if times_60_plus_dpd_in_12_mnths=5 then time605=1; else time605=0;
	if times_60_plus_dpd_in_12_mnths=6 then time606=1; else time606=0;
	if times_60_plus_dpd_in_12_mnths=7 then time607=1; else time607=0;
	if times_60_plus_dpd_in_12_mnths=8 then time608=1; else time608=0;
	if times_60_plus_dpd_in_12_mnths=9 then time609=1; else time609=0;
	if times_60_plus_dpd_in_12_mnths=10 then time6010=1; else time6010=0;
	if times_60_plus_dpd_in_12_mnths=11 then time6011=1; else time6011=0;
	if times_60_plus_dpd_in_12_mnths=12 then time6012=1; else time6012=0;
	
	if lob_cd="OPEN" then open=1; else open=0;
	/* Create independent variable*/
	if (email_optout_ind_prior=0 and email_optout_ind_new=1) then OPTOUT=1;
	else OPTOUT=0;
	
	setupsq=setup_dt*setup_dt;
run;


	
/** Create PS by logit model **/

proc logistic data =arec559.PS_charge_con DESCENDING plots=none;
	model OPTOUT=credit_A credit_B credit_C credit_D credit_E credit_F
	Female Male
	Member_rewards
	age_18_24 age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_plus
	fee_svc_count 
	myca_count
	setup_dt 
	setupsq
	open /risklimits;
	output out = PS_charge_con_4 prob = pscore xbeta = xb;
run;

data PS_charge_con_treatment;
	set PS_charge_con_4 (rename = (cm11 = idT pscore = pscoreT));
	where choice=1;
	keep idT pscoreT;
run;
data PS_charge_con_control;
	set PS_charge_con_4 (rename = (cm11 = idC pscore = pscoreC));
	where choice=0;
	keep idC pscoreC;
run;

/** MATCHING!! **/
%include '/home/asaito10/AREC559_programs/PSMatching (1).sas';
%PSMatching(datatreatment = PS_charge_con_treatment, datacontrol = PS_charge_con_control, method = NN, 
	numberofcontrols = 1, caliper = , replacement = yes, out = matches);
	
data arec559.PS_charge_con_matches;
	set matches;
	run;
	
/* Merge control and treatment */

data PS_charge_con_c;
	set arec559.PS_charge_con_matches (keep=IdSelectedControl PScoreControl rename=(IdSelectedControl=cm11));
	run;
data PS_charge_con_t;
	set arec559.PS_charge_con_matches (keep=MatchedToTreatID PScoreTreat rename=(MatchedToTreatID=cm11));
	run;
data PS_charge_con_matched;
	set PS_charge_con_t PS_charge_con_c;
	run;

/* Merge matched data with panel data */
proc sql;
	create table PS_charge_con_DiD as
	select *
	from PS_charge_con_matched as a
	left join arec559.panel_lab2 as b
	on a.cm11=b.cm11;
	quit;

data arec559.PS_charge_con_DiD;
	set PS_charge_con_DiD;
	interaction=time*choice;run;
	

/* Run diffrence in difference */
proc reg data=arec559.PS_charge_con_DiD;
	model spend=time choice interaction;
	run;

/* descripitive statistics */
proc means data=arec559.PS_charge_con_did;
	var spend;
	class time choice;run;