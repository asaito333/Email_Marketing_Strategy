/** Lab assignment 4 */

/*seg1: consumer/smallbusiness/charge, cent/gold/plat */
data arec559.segment_charge_con;
	set arec559.panel_lab2;
	where prod_pay_type_cd="CHARGE" and lob_cd^="OPEN";
	run;
	
data arec559.segment1;
	set arec559.panel_lab2;
	where prod_pay_type_cd="CHARGE" and (prod_perf_trk_cd_desc="BUSINESS CENTURION" or prod_perf_trk_cd_desc="BUSINESS GOLD" or
	prod_perf_trk_cd_desc="BUSINESS PLATINUM" or prod_perf_trk_cd_desc="BUSINESS REWARDS GOLD" or prod_perf_trk_cd_desc="CENTURION"
	or prod_perf_trk_cd_desc="GOLD" or prod_perf_trk_cd_desc="GOLD OPTIMA" or prod_perf_trk_cd_desc="PLAT BUS CREDIT CARD" or
	prod_perf_trk_cd_desc="PLATINUM" or prod_perf_trk_cd_desc="PLATINUM OPTIMA" or prod_perf_trk_cd_desc="PLATINUM PREFERRED" or
	prod_perf_trk_cd_desc="PLATINUM SAC");
	run;
	
/*seg2: consumer/smallbusiness/charge, all others */
data arec559.segment2;
	set arec559.panel_lab2;
	where prod_pay_type_cd="CHARGE" and (prod_perf_trk_cd_desc^="BUSINESS CENTURION" and prod_perf_trk_cd_desc^="BUSINESS GOLD" and
	prod_perf_trk_cd_desc^="BUSINESS PLATINUM" and prod_perf_trk_cd_desc^="BUSINESS REWARDS GOLD" and prod_perf_trk_cd_desc^="CENTURION"
	and prod_perf_trk_cd_desc^="GOLD" and prod_perf_trk_cd_desc^="GOLD OPTIMA" and prod_perf_trk_cd_desc^="PLAT BUS CREDIT CARD" and
	prod_perf_trk_cd_desc^="PLATINUM" and prod_perf_trk_cd_desc^="PLATINUM OPTIMA" and prod_perf_trk_cd_desc^="PLATINUM PREFERRED" and
	prod_perf_trk_cd_desc^="PLATINUM SAC");
	run;
	
/*seg3: consumer/lend/cobrand, costco */
data arec559.segment3;
	set arec559.panel_lab2;
	where lob_cd="CONSUMER" and prod_pay_type_cd="LENDING" and prod_grp_id="CO" and (prod_perf_trk_cd_desc="CCSG COSTCO" or
	prod_perf_trk_cd_desc="COSTCO BUSINESS" or prod_perf_trk_cd_desc="OPEN COSTCO");
	run;

/*seg4: consumer/lend/cobrand, all others */
data arec559.segment4;
	set arec559.panel_lab2;
	where lob_cd="CONSUMER" and prod_pay_type_cd="LENDING" and prod_grp_id="CO" and (prod_perf_trk_cd_desc^="CCSG COSTCO" and
	prod_perf_trk_cd_desc^="COSTCO BUSINESS" and prod_perf_trk_cd_desc^="OPEN COSTCO");
	run;

/*seg5: consumer/lend/proprietary, cent/plat */
data arec559.segment5;
	set arec559.panel_lab2;
	where (lob_cd="CONSUMER" and prod_pay_type_cd="LENDING" and prod_grp_id="PR") and (
	prod_perf_trk_cd_desc="CENTURION" or prod_perf_trk_cd_desc="PLATINUM" or prod_perf_trk_cd_desc="PLATINUM OPTIMA"
	or prod_perf_trk_cd_desc="PLATINUM PREFERRED");
	run;


/*seg6: consumer/lend/proprietary, all others */
data arec559.segment6;
	set arec559.panel_lab2;
	where lob_cd="CONSUMER" and prod_pay_type_cd="LENDING" and prod_grp_id="PR" and (
	prod_perf_trk_cd_desc^="CENTURION" and prod_perf_trk_cd_desc^="PLATINUM" and prod_perf_trk_cd_desc^="PLATINUM OPTIMA"
	and prod_perf_trk_cd_desc^="PLATINUM PREFERRED" and prod_perf_trk_cd_desc^="PLATINUM SAC");
	run;

/*seg7: consumer/charge/proprietary, cent/gold/plat */
data arec559.segment7;
	set arec559.panel_lab2;
	where lob_cd="CONSUMER" and prod_pay_type_cd="CHARGE" and prod_grp_id="PR" and (prod_perf_trk_cd_desc="BUSINESS CENTURIOMN" or prod_perf_trk_cd_desc="BUSINESS GOLD" or
	prod_perf_trk_cd_desc="BUSINESS PLATINUM" or prod_perf_trk_cd_desc="BUSINESS REWARDS GOLD" or prod_perf_trk_cd_desc="CENTURION"
	or prod_perf_trk_cd_desc="GOLD" or prod_perf_trk_cd_desc="GOLD OPTIMA" or prod_perf_trk_cd_desc="PLAT BUS CREDIT CARD" or
	prod_perf_trk_cd_desc="PLATINUM" or prod_perf_trk_cd_desc="PLATINUM OPTIMA" or prod_perf_trk_cd_desc="PLATINUM PREFERED" or
	prod_perf_trk_cd_desc="PLATINUM SAC");
	run;
	
/*seg8: consumer/charge/proprietary, all others */
data arec559.segment8;
	set arec559.panel_lab2;
	where lob_cd="CONSUMER" and prod_pay_type_cd="CHARGE" and prod_grp_id="PR" and 
	(prod_perf_trk_cd_desc^="BUSINESS CENTURIOMN" and prod_perf_trk_cd_desc^="BUSINESS GOLD" and
	prod_perf_trk_cd_desc^="BUSINESS PLATINUM" and prod_perf_trk_cd_desc^="BUSINESS REWARDS GOLD" and prod_perf_trk_cd_desc^="CENTURION"
	and prod_perf_trk_cd_desc^="GOLD" and prod_perf_trk_cd_desc^="GOLD OPTIMA" and prod_perf_trk_cd_desc^="PLAT BUS CREDIT CARD" and
	prod_perf_trk_cd_desc^="PLATINUM" and prod_perf_trk_cd_desc^="PLATINUM OPTIMA" and prod_perf_trk_cd_desc^="PLATINUM PREFERED" and
	prod_perf_trk_cd_desc^="PLATINUM SAC");
	run;

/*seg9: small business/lend/cobrand */
data arec559.segment9;
	set arec559.panel_lab2;
	where lob_cd="OPEN" and prod_pay_type_cd="LENDING" and prod_grp_id="CO";
	run;
	
/*seg10: small business/lending/proprietary */
data arec559.segment10;
	set arec559.panel_lab2;
	where lob_cd="OPEN" and prod_pay_type_cd="LENDING" and prod_grp_id="PR";
	run;	

/* segment into chooser, nonchooser*/
data arec559.segment2_chooser;
	set arec559.segment2;
	where choice=1;
	run;
data arec559.segment2_non;
	set arec559.segment2;
	where choice=0;
	run;


proc means data=arec559.segment1_chooser ;
	var spend;run;
proc means data=arec559.segment1_non ;
	var spend;run;
proc means data=arec559.segment2_chooser ;
	var spend;run;
proc means data=arec559.segment2_non ;
	var spend;run;
proc means data=arec559.segment3_chooser ;
	var spend;run;
proc means data=arec559.segment3_non ;
	var spend;run;
proc means data=arec559.segment4_chooser ;
	var spend;run;
proc means data=arec559.segment4_non ;
	var spend;run;
proc means data=arec559.segment5_chooser ;
	var spend;run;
proc means data=arec559.segment5_non ;
	var spend;run;
proc means data=arec559.segment6_chooser ;
	var spend;run;
proc means data=arec559.segment6_non ;
	var spend;run;
proc means data=arec559.segment7_chooser ;
	var spend;run;
proc means data=arec559.segment7_non ;
	var spend;run;
proc means data=arec559.segment8_chooser ;
	var spend;run;
proc means data=arec559.segment8_non ;
	var spend;run;
proc means data=arec559.segment9_chooser ;
	var spend;run;
proc means data=arec559.segment9_non ;
	var spend;run;
proc means data=arec559.segment10_chooser ;
	var spend;run;
proc means data=arec559.segment10_non ;
	var spend;run;
								
		
	
		

/* check the levels of categorical variables*/
proc freq data=arec559.product nlevels;
	tables _all_ /noprint;
proc freq data=arec559.cmpgn nlevels;
	tables _all_ /noprint;
proc freq data=arec559.choice nlevels;
	tables _all_ /noprint;
proc freq data=arec559.contact nlevels;
	tables _all_ /noprint;
proc freq data=arec559.attributes nlevels;
	tables _all_/noprint;
run;	
proc freq data=arec559.nochoice nlevels;
	tables _all_ /noprint;
run;


	

/* check the categoris for each variables */
proc freq data=arec559.product;
	title "product";
	tables lob_cd;
	tables prod_pay_type_cd;
	tables prod_grp_id;
	tables prod_perf_trk_cd_desc;
run;
proc freq data=arec559.cmpgn;
	title "campaign";
	tables bu_mjr_desc;
	tables chnl_desc;
	tables cmpgn_addl_typ_desc;
	tables cmpgn_sub_typ_desc;
	tables cmpgn_typ_desc;
	tables crd_ofr_cons_friendly_desc;
	tables crd_ofr_lob_cd;
	tables crd_ofr_prod_grp_id;
	tables crd_ofr_prod_id;
	tables crd_ofr_prod_pay_typ_cd;
	tables crd_ofr_prod_perf_trk_cd_desc;
	tables data_src;
	tables ee_45_days_ind;
	tables ee_cmpgn_ind;
	tables hold_out_cd;
	tables load_flg;
	tables model_usage_ind;
	tables offer_business_unit_nm;
	tables offer_grp_nm;
	tables offer_lvl1_desc;
	tables offer_lvl2_desc;
	tables offer_lvl3_desc;
	tables other_details4_desc;
	tables parnt_chnl_desc;
proc freq data=arec559.contact;
	title "contact";
	tables chnl_dim_key;
	tables commun_orgn_dim_key;
	tables evnt_dim_key;
proc freq data=arec559.attributes;
	title "attributes";
	tables AGE_grp;
	tables CDSS;
	tables gender_cd;
	tables MR_ind;
	tables transactor_ind;
	tables fee_svc_count;
	tables myca_count;
	tables times_30_dpd_in_12_mnths;
	tables times_60_plus_dpd_in_12_mnths;
proc freq data=arec559.choice;
	title "choice";
	tables direct_mail_optout_ind_new ;
	tables direct_mail_optout_ind_prior ;
	tables email_optout_ind_new ;
	tables email_optout_ind_prior ;
	tables obtm_optout_ind_new ;
	tables obtm_optout_ind_prior ;
proc freq data=arec559.nochoice;
	title "nochoice";
	tables email_optout_ind;
	tables direct_mail_optout_ind;
	tables obtm_optout_ind;
run;

proc freq data=arec559.cmpgn;
	tables cmpgn_typ_desc*offer_grp_nm;
	run;