/* create dataset with type and type*chnl */



/*   Need to reduce sample to unique cm11 by using nodupkey    */

proc sort data=arec559.contact_subtyp_chnl_Rollup nodupkey out=contact_subtyp_chnl_Rollup;
  by cm11;
run;

proc contents data=contact_subtyp_chnl_Rollup;run;

/* create cross sectional from panel */
data before;
	set arec559.panel_lab2 (keep=cm11 spend transaction time);
	if time=1 then delete;
	if time=0 then spend_before=spend;
	if time=0 then transaction_before=transaction;
	drop spend;
	drop transaction;
	drop time;
run;

data after;
	set arec559.panel_lab2;
	if time=0 then delete;
	if time=1 then spend_after=spend;
	if time=1 then transaction_after=transaction;
	drop spend;
	drop transaction;
	drop time;
	run;

proc sql;
	create table cross as
	select *
	from after as a
	left join before as b
	on a.cm11=b.cm11
	order by cm11;
	run;

data arec559.cross;
	set cross;
	run;

/* Merge with cross sectional data */
proc sql;
	create table contact_subtyp_chnl_forlogit as
	select *
	from arec559.cross as a
	left join contact_subtyp_chnl_Rollup as b
	on a.cm11=b.cm11
	order by cm11;
	run;
/*  Need to convert missing values to zeros for those with no contact history   */

proc contents data=contact_subtyp_chnl_forlogit;run;

data contact_subtyp_chnl_forlogit2;
  set contact_subtyp_chnl_forlogit;
    if numdlvdates = . then no_contact = 1; else no_contact = 0;
if	d_chnl_email	= . then	d_chnl_email	= 0;
if	d_chnl_dmail	= . then	d_chnl_dmail	= 0;
if	d_chnl_OBTM	= . then	d_chnl_OBTM	= 0;
if	d_chnl_stmt_insrt	= . then	d_chnl_stmt_insrt	= 0;
if	d_chnl_stmt_msg	= . then	d_chnl_stmt_msg	= 0;
if	d_email_OPEN	= . then	d_email_OPEN	= 0;
if	d_email_CLICK	= . then	d_email_CLICK	= 0;
if	d_eml_Optout	= . then	d_eml_Optout	= 0;
if	d_line_increase	= . then	d_line_increase	= 0;
if	d_loan_on_chrg	= . then	d_loan_on_chrg	= 0;
if	d_balance	= . then	d_balance	= 0;
if	d_across_BU	= . then	d_across_BU	= 0;
if	d_upgrade	= . then	d_upgrade	= 0;
if	d_supp	= . then	d_supp	= 0;
if	d_within_BU	= . then	d_within_BU	= 0;
if	d_card	= . then	d_card	= 0;
if	d_ES_Other	= . then	d_ES_Other	= 0;
if	d_Retail	= . then	d_Retail	= 0;
if	d_Lodging	= . then	d_Lodging	= 0;
if	d_Restaurant	= . then	d_Restaurant	= 0;
if	d_Cruise_Line	= . then	d_Cruise_Line	= 0;
if	d_Car_Rental	= . then	d_Car_Rental	= 0;
if	d_Airline	= . then	d_Airline	= 0;
if	d_Supermrkt	= . then	d_Supermrkt	= 0;
if	d_Furniture	= . then	d_Furniture	= 0;
if	d_Entertain	= . then	d_Entertain	= 0;
if	d_Telecom	= . then	d_Telecom	= 0;
if	d_Charity	= . then	d_Charity	= 0;
if	d_Trvl_Agncy	= . then	d_Trvl_Agncy	= 0;
if	d_MYSTIC	= . then	d_MYSTIC	= 0;
if	d_Web_Enroll	= . then	d_Web_Enroll	= 0;
if	d_Pers_Savings	= . then	d_Pers_Savings	= 0;
if	d_Books	= . then	d_Books	= 0;
if	d_Mkt_Voice	= . then	d_Mkt_Voice	= 0;
if	d_Ben_Mail	= . then	d_Ben_Mail	= 0;
if	d_Mkt_Res_Surv	= . then	d_Mkt_Res_Surv	= 0;
if	d_Circ_Mail	= . then	d_Circ_Mail	= 0;
if	d_service	= . then	d_service	= 0;
if	d_Ben_Reinforc	= . then	d_Ben_Reinforc	= 0;
if	d_Prod_Usage	= . then	d_Prod_Usage	= 0;
if	d_Travl_Offer	= . then	d_Travl_Offer	= 0;
if	d_Card_Actvat	= . then	d_Card_Actvat	= 0;
if	d_Ad_Sales_Mail	= . then	d_Ad_Sales_Mail	= 0;
if	d_Trvl_Ben_Fin	= . then	d_Trvl_Ben_Fin	= 0;
if	d_spend	= . then	d_spend	= 0;
if	d_balance_E	= . then	d_balance_E	= 0;
if	d_card_E	= . then	d_card_E	= 0;
if	d_MYSTIC_E	= . then	d_MYSTIC_E	= 0;
if	d_service_E	= . then	d_service_E	= 0;
if	d_spend_E	= . then	d_spend_E	= 0;
if	d_line_increase_E	= . then	d_line_increase_E	= 0;
if	d_loan_on_chrg_E	= . then	d_loan_on_chrg_E	= 0;
if	d_across_BU_E	= . then	d_across_BU_E	= 0;
if	d_upgrade_E	= . then	d_upgrade_E	= 0;
if	d_supp_E	= . then	d_supp_E	= 0;
if	d_within_BU_E	= . then	d_within_BU_E	= 0;
if	d_ES_Other_E	= . then	d_ES_Other_E	= 0;
if	d_Retail_E	= . then	d_Retail_E	= 0;
if	d_Lodging_E	= . then	d_Lodging_E	= 0;
if	d_Restaurant_E	= . then	d_Restaurant_E	= 0;
if	d_Car_Rental_E	= . then	d_Car_Rental_E	= 0;
if	d_Airline_E	= . then	d_Airline_E	= 0;
if	d_Trvl_Agncy_E	= . then	d_Trvl_Agncy_E	= 0;
if	d_Web_Enroll_E	= . then	d_Web_Enroll_E	= 0;
if	d_Pers_Savings_E	= . then	d_Pers_Savings_E	= 0;
if	d_Mkt_Voice_E	= . then	d_Mkt_Voice_E	= 0;
if	d_Mkt_Res_Surv_E	= . then	d_Mkt_Res_Surv_E	= 0;
if	d_Circ_Mail_E	= . then	d_Circ_Mail_E	= 0;
if	d_Ben_Reinforc_E	= . then	d_Ben_Reinforc_E	= 0;
if	d_Prod_Usage_E	= . then	d_Prod_Usage_E	= 0;
if	d_Travl_Offer_E	= . then	d_Travl_Offer_E	= 0;
if	d_Card_Actvat_E	= . then	d_Card_Actvat_E	= 0;
if	d_Trvl_Ben_Fin_E	= . then	d_Trvl_Ben_Fin_E	= 0;
if	d_balance_D	= . then	d_balance_D	= 0;
if	d_card_D	= . then	d_card_D	= 0;
if	d_MYSTIC_D	= . then	d_MYSTIC_D	= 0;
if	d_service_D	= . then	d_service_D	= 0;
if	d_spend_D	= . then	d_spend_D	= 0;
if	d_line_increase_D	= . then	d_line_increase_D	= 0;
if	d_loan_on_chrg_D	= . then	d_loan_on_chrg_D	= 0;
if	d_across_BU_D	= . then	d_across_BU_D	= 0;
if	d_upgrade_D	= . then	d_upgrade_D	= 0;
if	d_supp_D	= . then	d_supp_D	= 0;
if	d_ES_Other_D	= . then	d_ES_Other_D	= 0;
if	d_Retail_D	= . then	d_Retail_D	= 0;
if	d_Lodging_D	= . then	d_Lodging_D	= 0;
if	d_Restaurant_D	= . then	d_Restaurant_D	= 0;
if	d_Cruise_Line_D	= . then	d_Cruise_Line_D	= 0;
if	d_Car_Rental_D	= . then	d_Car_Rental_D	= 0;
if	d_Airline_D	= . then	d_Airline_D	= 0;
if	d_Supermrkt_D	= . then	d_Supermrkt_D	= 0;
if	d_Furniture_D	= . then	d_Furniture_D	= 0;
if	d_Entertain_D	= . then	d_Entertain_D	= 0;
if	d_Telecom_D	= . then	d_Telecom_D	= 0;
if	d_Charity_D	= . then	d_Charity_D	= 0;
if	d_Pers_Savings_D	= . then	d_Pers_Savings_D	= 0;
if	d_Books_D	= . then	d_Books_D	= 0;
if	d_Ben_Mail_D	= . then	d_Ben_Mail_D	= 0;
if	d_Circ_Mail_D	= . then	d_Circ_Mail_D	= 0;
if	d_Ben_Reinforc_D	= . then	d_Ben_Reinforc_D	= 0;
if	d_Prod_Usage_D	= . then	d_Prod_Usage_D	= 0;
if	d_Travl_Offer_D	= . then	d_Travl_Offer_D	= 0;
if	d_Ad_Sales_Mail_D	= . then	d_Ad_Sales_Mail_D	= 0;
if	d_Trvl_Ben_Fin_D	= . then	d_Trvl_Ben_Fin_D	= 0;
if	d_card_O	= . then	d_card_O	= 0;
if	d_upgrade_O	= . then	d_upgrade_O	= 0;
if	d_spend_SI	= . then	d_spend_SI	= 0;
if	d_Ben_Reinforc_SI	= . then	d_Ben_Reinforc_SI	= 0;
if	d_Prod_Usage_SI	= . then	d_Prod_Usage_SI	= 0;
if	d_spend_SM	= . then	d_spend_SM	= 0;
if	d_Ben_Reinforc_SM	= . then	d_Ben_Reinforc_SM	= 0;
if	d_Prod_Usage_SM	= . then	d_Prod_Usage_SM	= 0;
if	d_balance_EOPN	= . then	d_balance_EOPN	= 0;
if	d_card_EOPN	= . then	d_card_EOPN	= 0;
if	d_MYSTIC_EOPN	= . then	d_MYSTIC_EOPN	= 0;
if	d_service_EOPN	= . then	d_service_EOPN	= 0;
if	d_spend_EOPN	= . then	d_spend_EOPN	= 0;
if	d_line_increase_EOPN	= . then	d_line_increase_EOPN	= 0;
if	d_loan_on_chrg_EOPN	= . then	d_loan_on_chrg_EOPN	= 0;
if	d_across_BU_EOPN	= . then	d_across_BU_EOPN	= 0;
if	d_upgrade_EOPN	= . then	d_upgrade_EOPN	= 0;
if	d_supp_EOPN	= . then	d_supp_EOPN	= 0;
if	d_within_BU_EOPN	= . then	d_within_BU_EOPN	= 0;
if	d_ES_Other_EOPN	= . then	d_ES_Other_EOPN	= 0;
if	d_Retail_EOPN	= . then	d_Retail_EOPN	= 0;
if	d_Lodging_EOPN	= . then	d_Lodging_EOPN	= 0;
if	d_Restaurant_EOPN	= . then	d_Restaurant_EOPN	= 0;
if	d_Car_Rental_EOPN	= . then	d_Car_Rental_EOPN	= 0;
if	d_Airline_EOPN	= . then	d_Airline_EOPN	= 0;
if	d_Trvl_Agncy_EOPN	= . then	d_Trvl_Agncy_EOPN	= 0;
if	d_Web_Enroll_EOPN	= . then	d_Web_Enroll_EOPN	= 0;
if	d_Pers_Savings_EOPN	= . then	d_Pers_Savings_EOPN	= 0;
if	d_Mkt_Voice_EOPN	= . then	d_Mkt_Voice_EOPN	= 0;
if	d_Mkt_Res_Surv_EOPN	= . then	d_Mkt_Res_Surv_EOPN	= 0;
if	d_Circ_Mail_EOPN	= . then	d_Circ_Mail_EOPN	= 0;
if	d_Ben_Reinforc_EOPN	= . then	d_Ben_Reinforc_EOPN	= 0;
if	d_Prod_Usage_EOPN	= . then	d_Prod_Usage_EOPN	= 0;
if	d_Travl_Offer_EOPN	= . then	d_Travl_Offer_EOPN	= 0;
if	d_Card_Actvat_EOPN	= . then	d_Card_Actvat_EOPN	= 0;
if	d_Trvl_Ben_Fin_EOPN	= . then	d_Trvl_Ben_Fin_EOPN	= 0;
if	d_balance_ECLK	= . then	d_balance_ECLK	= 0;
if	d_card_ECLK	= . then	d_card_ECLK	= 0;
if	d_MYSTIC_ECLK	= . then	d_MYSTIC_ECLK	= 0;
if	d_service_ECLK	= . then	d_service_ECLK	= 0;
if	d_spend_ECLK	= . then	d_spend_ECLK	= 0;
if	d_line_increase_ECLK	= . then	d_line_increase_ECLK	= 0;
if	d_loan_on_chrg_ECLK	= . then	d_loan_on_chrg_ECLK	= 0;
if	d_across_BU_ECLK	= . then	d_across_BU_ECLK	= 0;
if	d_upgrade_ECLK	= . then	d_upgrade_ECLK	= 0;
if	d_supp_ECLK	= . then	d_supp_ECLK	= 0;
if	d_within_BU_ECLK	= . then	d_within_BU_ECLK	= 0;
if	d_ES_Other_ECLK	= . then	d_ES_Other_ECLK	= 0;
if	d_Retail_ECLK	= . then	d_Retail_ECLK	= 0;
if	d_Lodging_ECLK	= . then	d_Lodging_ECLK	= 0;
if	d_Restaurant_ECLK	= . then	d_Restaurant_ECLK	= 0;
if	d_Car_Rental_ECLK	= . then	d_Car_Rental_ECLK	= 0;
if	d_Airline_ECLK	= . then	d_Airline_ECLK	= 0;
if	d_Trvl_Agncy_ECLK	= . then	d_Trvl_Agncy_ECLK	= 0;
if	d_Web_Enroll_ECLK	= . then	d_Web_Enroll_ECLK	= 0;
if	d_Pers_Savings_ECLK	= . then	d_Pers_Savings_ECLK	= 0;
if	d_Mkt_Voice_ECLK	= . then	d_Mkt_Voice_ECLK	= 0;
if	d_Mkt_Res_Surv_ECLK	= . then	d_Mkt_Res_Surv_ECLK	= 0;
if	d_Circ_Mail_ECLK	= . then	d_Circ_Mail_ECLK	= 0;
if	d_Ben_Reinforc_ECLK	= . then	d_Ben_Reinforc_ECLK	= 0;
if	d_Prod_Usage_ECLK	= . then	d_Prod_Usage_ECLK	= 0;
if	d_Travl_Offer_ECLK	= . then	d_Travl_Offer_ECLK	= 0;
if	d_Card_Actvat_ECLK	= . then	d_Card_Actvat_ECLK	= 0;
if	d_Trvl_Ben_Fin_ECLK	= . then	d_Trvl_Ben_Fin_ECLK	= 0;
if	balance_cnt	= . then	balance_cnt	= 0;
if	card_cnt	= . then	card_cnt	= 0;
if	MYSTIC_cnt	= . then	MYSTIC_cnt	= 0;
if	service_cnt	= . then	service_cnt	= 0;
if	spend_cnt	= . then	spend_cnt	= 0;
if	balance_pct	= . then	balance_pct	= 0;
if	card_pct	= . then	card_pct	= 0;
if	MYSTIC_pct	= . then	MYSTIC_pct	= 0;
if	service_pct	= . then	service_pct	= 0;
if	spend_pct	= . then	spend_pct	= 0;
if	balance_E_cnt	= . then	balance_E_cnt	= 0;
if	card_E_cnt	= . then	card_E_cnt	= 0;
if	MYSTIC_E_cnt	= . then	MYSTIC_E_cnt	= 0;
if	service_E_cnt	= . then	service_E_cnt	= 0;
if	spend_E_cnt	= . then	spend_E_cnt	= 0;
if	balance_E_pct	= . then	balance_E_pct	= 0;
if	card_E_pct	= . then	card_E_pct	= 0;
if	MYSTIC_E_pct	= . then	MYSTIC_E_pct	= 0;
if	service_E_pct	= . then	service_E_pct	= 0;
if	spend_E_pct	= . then	spend_E_pct	= 0;
if	balance_D_cnt	= . then	balance_D_cnt	= 0;
if	card_D_cnt	= . then	card_D_cnt	= 0;
if	MYSTIC_D_cnt	= . then	MYSTIC_D_cnt	= 0;
if	service_D_cnt	= . then	service_D_cnt	= 0;
if	spend_D_cnt	= . then	spend_D_cnt	= 0;
if	balance_D_pct	= . then	balance_D_pct	= 0;
if	card_D_pct	= . then	card_D_pct	= 0;
if	MYSTIC_D_pct	= . then	MYSTIC_D_pct	= 0;
if	service_D_pct	= . then	service_D_pct	= 0;
if	spend_D_pct	= . then	spend_D_pct	= 0;
if	card_O_cnt	= . then	card_O_cnt	= 0;
if	spend_SI_cnt	= . then	spend_SI_cnt	= 0;
if	spend_SM_cnt	= . then	spend_SM_cnt	= 0;
if	card_O_pct	= . then	card_O_pct	= 0;
if	spend_SI_pct	= . then	spend_SI_pct	= 0;
if	spend_SM_pct	= . then	spend_SM_pct	= 0;
if	balance_EOPN_cnt	= . then	balance_EOPN_cnt	= 0;
if	card_EOPN_cnt	= . then	card_EOPN_cnt	= 0;
if	MYSTIC_EOPN_cnt	= . then	MYSTIC_EOPN_cnt	= 0;
if	service_EOPN_cnt	= . then	service_EOPN_cnt	= 0;
if	spend_EOPN_cnt	= . then	spend_EOPN_cnt	= 0;
if	balance_EOPN_pct	= . then	balance_EOPN_pct	= 0;
if	card_EOPN_pct	= . then	card_EOPN_pct	= 0;
if	MYSTIC_EOPN_pct	= . then	MYSTIC_EOPN_pct	= 0;
if	service_EOPN_pct	= . then	service_EOPN_pct	= 0;
if	spend_EOPN_pct	= . then	spend_EOPN_pct	= 0;
if	balance_ECLK_cnt	= . then	balance_ECLK_cnt	= 0;
if	card_ECLK_cnt	= . then	card_ECLK_cnt	= 0;
if	MYSTIC_ECLK_cnt	= . then	MYSTIC_ECLK_cnt	= 0;
if	service_ECLK_cnt	= . then	service_ECLK_cnt	= 0;
if	spend_ECLK_cnt	= . then	spend_ECLK_cnt	= 0;
if	balance_ECLK_pct	= . then	balance_ECLK_pct	= 0;
if	card_ECLK_pct	= . then	card_ECLK_pct	= 0;
if	MYSTIC_ECLK_pct	= . then	MYSTIC_ECLK_pct	= 0;
if	service_ECLK_pct	= . then	service_ECLK_pct	= 0;
if	spend_ECLK_pct	= . then	spend_ECLK_pct	= 0;
if	line_increase_cnt	= . then	line_increase_cnt	= 0;
if	loan_on_chrg_cnt	= . then	loan_on_chrg_cnt	= 0;
if	across_BU_cnt	= . then	across_BU_cnt	= 0;
if	upgrade_cnt	= . then	upgrade_cnt	= 0;
if	supp_cnt	= . then	supp_cnt	= 0;
if	within_BU_cnt	= . then	within_BU_cnt	= 0;
if	ES_Other_cnt	= . then	ES_Other_cnt	= 0;
if	Retail_cnt	= . then	Retail_cnt	= 0;
if	Lodging_cnt	= . then	Lodging_cnt	= 0;
if	Restaurant_cnt	= . then	Restaurant_cnt	= 0;
if	Cruise_Line_cnt	= . then	Cruise_Line_cnt	= 0;
if	Car_Rental_cnt	= . then	Car_Rental_cnt	= 0;
if	Airline_cnt	= . then	Airline_cnt	= 0;
if	Supermrkt_cnt	= . then	Supermrkt_cnt	= 0;
if	Furniture_cnt	= . then	Furniture_cnt	= 0;
if	Entertain_cnt	= . then	Entertain_cnt	= 0;
if	Telecom_cnt	= . then	Telecom_cnt	= 0;
if	Charity_cnt	= . then	Charity_cnt	= 0;
if	Trvl_Agncy_cnt	= . then	Trvl_Agncy_cnt	= 0;
if	Web_Enroll_cnt	= . then	Web_Enroll_cnt	= 0;
if	Pers_Savings_cnt	= . then	Pers_Savings_cnt	= 0;
if	Books_cnt	= . then	Books_cnt	= 0;
if	Mkt_Voice_cnt	= . then	Mkt_Voice_cnt	= 0;
if	Ben_Mail_cnt	= . then	Ben_Mail_cnt	= 0;
if	Mkt_Res_Surv_cnt	= . then	Mkt_Res_Surv_cnt	= 0;
if	Circ_Mail_cnt	= . then	Circ_Mail_cnt	= 0;
if	Ben_Reinforc_cnt	= . then	Ben_Reinforc_cnt	= 0;
if	Prod_Usage_cnt	= . then	Prod_Usage_cnt	= 0;
if	Travl_Offer_cnt	= . then	Travl_Offer_cnt	= 0;
if	Card_Actvat_cnt	= . then	Card_Actvat_cnt	= 0;
if	Ad_Sales_Mail_cnt	= . then	Ad_Sales_Mail_cnt	= 0;
if	Trvl_Ben_Fin_cnt	= . then	Trvl_Ben_Fin_cnt	= 0;
if	line_increase_pct	= . then	line_increase_pct	= 0;
if	loan_on_chrg_pct	= . then	loan_on_chrg_pct	= 0;
if	across_BU_pct	= . then	across_BU_pct	= 0;
if	upgrade_pct	= . then	upgrade_pct	= 0;
if	supp_pct	= . then	supp_pct	= 0;
if	within_BU_pct	= . then	within_BU_pct	= 0;
if	ES_Other_pct	= . then	ES_Other_pct	= 0;
if	Retail_pct	= . then	Retail_pct	= 0;
if	Lodging_pct	= . then	Lodging_pct	= 0;
if	Restaurant_pct	= . then	Restaurant_pct	= 0;
if	Cruise_Line_pct	= . then	Cruise_Line_pct	= 0;
if	Car_Rental_pct	= . then	Car_Rental_pct	= 0;
if	Airline_pct	= . then	Airline_pct	= 0;
if	Supermrkt_pct	= . then	Supermrkt_pct	= 0;
if	Furniture_pct	= . then	Furniture_pct	= 0;
if	Entertain_pct	= . then	Entertain_pct	= 0;
if	Telecom_pct	= . then	Telecom_pct	= 0;
if	Charity_pct	= . then	Charity_pct	= 0;
if	Trvl_Agncy_pct	= . then	Trvl_Agncy_pct	= 0;
if	Web_Enroll_pct	= . then	Web_Enroll_pct	= 0;
if	Pers_Savings_pct	= . then	Pers_Savings_pct	= 0;
if	Books_pct	= . then	Books_pct	= 0;
if	Mkt_Voice_pct	= . then	Mkt_Voice_pct	= 0;
if	Ben_Mail_pct	= . then	Ben_Mail_pct	= 0;
if	Mkt_Res_Surv_pct	= . then	Mkt_Res_Surv_pct	= 0;
if	Circ_Mail_pct	= . then	Circ_Mail_pct	= 0;
if	Ben_Reinforc_pct	= . then	Ben_Reinforc_pct	= 0;
if	Prod_Usage_pct	= . then	Prod_Usage_pct	= 0;
if	Travl_Offer_pct	= . then	Travl_Offer_pct	= 0;
if	Card_Actvat_pct	= . then	Card_Actvat_pct	= 0;
if	Ad_Sales_Mail_pct	= . then	Ad_Sales_Mail_pct	= 0;
if	Trvl_Ben_Fin_pct	= . then	Trvl_Ben_Fin_pct	= 0;
if	line_increase_e_cnt	= . then	line_increase_e_cnt	= 0;
if	loan_on_chrg_e_cnt	= . then	loan_on_chrg_e_cnt	= 0;
if	across_BU_e_cnt	= . then	across_BU_e_cnt	= 0;
if	upgrade_e_cnt	= . then	upgrade_e_cnt	= 0;
if	supp_e_cnt	= . then	supp_e_cnt	= 0;
if	within_BU_e_cnt	= . then	within_BU_e_cnt	= 0;
if	ES_Other_e_cnt	= . then	ES_Other_e_cnt	= 0;
if	Retail_e_cnt	= . then	Retail_e_cnt	= 0;
if	Lodging_e_cnt	= . then	Lodging_e_cnt	= 0;
if	Restaurant_e_cnt	= . then	Restaurant_e_cnt	= 0;
if	Car_Rental_e_cnt	= . then	Car_Rental_e_cnt	= 0;
if	Airline_e_cnt	= . then	Airline_e_cnt	= 0;
if	Trvl_Agncy_e_cnt	= . then	Trvl_Agncy_e_cnt	= 0;
if	Web_Enroll_e_cnt	= . then	Web_Enroll_e_cnt	= 0;
if	Pers_Savings_e_cnt	= . then	Pers_Savings_e_cnt	= 0;
if	Mkt_Voice_e_cnt	= . then	Mkt_Voice_e_cnt	= 0;
if	Mkt_Res_Surv_e_cnt	= . then	Mkt_Res_Surv_e_cnt	= 0;
if	Circ_Mail_e_cnt	= . then	Circ_Mail_e_cnt	= 0;
if	Ben_Reinforc_e_cnt	= . then	Ben_Reinforc_e_cnt	= 0;
if	Prod_Usage_e_cnt	= . then	Prod_Usage_e_cnt	= 0;
if	Travl_Offer_e_cnt	= . then	Travl_Offer_e_cnt	= 0;
if	Card_Actvat_e_cnt	= . then	Card_Actvat_e_cnt	= 0;
if	Trvl_Ben_Fin_e_cnt	= . then	Trvl_Ben_Fin_e_cnt	= 0;
if	line_increase_e_pct	= . then	line_increase_e_pct	= 0;
if	loan_on_chrg_e_pct	= . then	loan_on_chrg_e_pct	= 0;
if	across_BU_e_pct	= . then	across_BU_e_pct	= 0;
if	upgrade_e_pct	= . then	upgrade_e_pct	= 0;
if	supp_e_pct	= . then	supp_e_pct	= 0;
if	within_BU_e_pct	= . then	within_BU_e_pct	= 0;
if	ES_Other_e_pct	= . then	ES_Other_e_pct	= 0;
if	Retail_e_pct	= . then	Retail_e_pct	= 0;
if	Lodging_e_pct	= . then	Lodging_e_pct	= 0;
if	Restaurant_e_pct	= . then	Restaurant_e_pct	= 0;
if	Car_Rental_e_pct	= . then	Car_Rental_e_pct	= 0;
if	Airline_e_pct	= . then	Airline_e_pct	= 0;
if	Trvl_Agncy_e_pct	= . then	Trvl_Agncy_e_pct	= 0;
if	Web_Enroll_e_pct	= . then	Web_Enroll_e_pct	= 0;
if	Pers_Savings_e_pct	= . then	Pers_Savings_e_pct	= 0;
if	Mkt_Voice_e_pct	= . then	Mkt_Voice_e_pct	= 0;
if	Mkt_Res_Surv_e_pct	= . then	Mkt_Res_Surv_e_pct	= 0;
if	Circ_Mail_e_pct	= . then	Circ_Mail_e_pct	= 0;
if	Ben_Reinforc_e_pct	= . then	Ben_Reinforc_e_pct	= 0;
if	Prod_Usage_e_pct	= . then	Prod_Usage_e_pct	= 0;
if	Travl_Offer_e_pct	= . then	Travl_Offer_e_pct	= 0;
if	Card_Actvat_e_pct	= . then	Card_Actvat_e_pct	= 0;
if	Trvl_Ben_Fin_e_pct	= . then	Trvl_Ben_Fin_e_pct	= 0;
if	line_increase_D_cnt	= . then	line_increase_D_cnt	= 0;
if	loan_on_chrg_D_cnt	= . then	loan_on_chrg_D_cnt	= 0;
if	across_BU_D_cnt	= . then	across_BU_D_cnt	= 0;
if	upgrade_D_cnt	= . then	upgrade_D_cnt	= 0;
if	supp_D_cnt	= . then	supp_D_cnt	= 0;
if	ES_Other_D_cnt	= . then	ES_Other_D_cnt	= 0;
if	Retail_D_cnt	= . then	Retail_D_cnt	= 0;
if	Lodging_D_cnt	= . then	Lodging_D_cnt	= 0;
if	Restaurant_D_cnt	= . then	Restaurant_D_cnt	= 0;
if	Cruise_Line_D_cnt	= . then	Cruise_Line_D_cnt	= 0;
if	Car_Rental_D_cnt	= . then	Car_Rental_D_cnt	= 0;
if	Airline_D_cnt	= . then	Airline_D_cnt	= 0;
if	Supermrkt_D_cnt	= . then	Supermrkt_D_cnt	= 0;
if	Furniture_D_cnt	= . then	Furniture_D_cnt	= 0;
if	Entertain_D_cnt	= . then	Entertain_D_cnt	= 0;
if	Telecom_D_cnt	= . then	Telecom_D_cnt	= 0;
if	Charity_D_cnt	= . then	Charity_D_cnt	= 0;
if	Pers_Savings_D_cnt	= . then	Pers_Savings_D_cnt	= 0;
if	Books_D_cnt	= . then	Books_D_cnt	= 0;
if	Ben_Mail_D_cnt	= . then	Ben_Mail_D_cnt	= 0;
if	Circ_Mail_D_cnt	= . then	Circ_Mail_D_cnt	= 0;
if	Ben_Reinforc_D_cnt	= . then	Ben_Reinforc_D_cnt	= 0;
if	Prod_Usage_D_cnt	= . then	Prod_Usage_D_cnt	= 0;
if	Travl_Offer_D_cnt	= . then	Travl_Offer_D_cnt	= 0;
if	Ad_Sales_Mail_D_cnt	= . then	Ad_Sales_Mail_D_cnt	= 0;
if	Trvl_Ben_Fin_D_cnt	= . then	Trvl_Ben_Fin_D_cnt	= 0;
if	line_increase_D_pct	= . then	line_increase_D_pct	= 0;
if	loan_on_chrg_D_pct	= . then	loan_on_chrg_D_pct	= 0;
if	across_BU_D_pct	= . then	across_BU_D_pct	= 0;
if	upgrade_D_pct	= . then	upgrade_D_pct	= 0;
if	supp_D_pct	= . then	supp_D_pct	= 0;
if	ES_Other_D_pct	= . then	ES_Other_D_pct	= 0;
if	Retail_D_pct	= . then	Retail_D_pct	= 0;
if	Lodging_D_pct	= . then	Lodging_D_pct	= 0;
if	Restaurant_D_pct	= . then	Restaurant_D_pct	= 0;
if	Cruise_Line_D_pct	= . then	Cruise_Line_D_pct	= 0;
if	Car_Rental_D_pct	= . then	Car_Rental_D_pct	= 0;
if	Airline_D_pct	= . then	Airline_D_pct	= 0;
if	Supermrkt_D_pct	= . then	Supermrkt_D_pct	= 0;
if	Furniture_D_pct	= . then	Furniture_D_pct	= 0;
if	Entertain_D_pct	= . then	Entertain_D_pct	= 0;
if	Telecom_D_pct	= . then	Telecom_D_pct	= 0;
if	Charity_D_pct	= . then	Charity_D_pct	= 0;
if	Pers_Savings_D_pct	= . then	Pers_Savings_D_pct	= 0;
if	Books_D_pct	= . then	Books_D_pct	= 0;
if	Ben_Mail_D_pct	= . then	Ben_Mail_D_pct	= 0;
if	Circ_Mail_D_pct	= . then	Circ_Mail_D_pct	= 0;
if	Ben_Reinforc_D_pct	= . then	Ben_Reinforc_D_pct	= 0;
if	Prod_Usage_D_pct	= . then	Prod_Usage_D_pct	= 0;
if	Travl_Offer_D_pct	= . then	Travl_Offer_D_pct	= 0;
if	Ad_Sales_Mail_D_pct	= . then	Ad_Sales_Mail_D_pct	= 0;
if	Trvl_Ben_Fin_D_pct	= . then	Trvl_Ben_Fin_D_pct	= 0;
if	upgrade_O_cnt	= . then	upgrade_O_cnt	= 0;
if	Ben_Reinforc_SI_cnt	= . then	Ben_Reinforc_SI_cnt	= 0;
if	Prod_Usage_SI_cnt	= . then	Prod_Usage_SI_cnt	= 0;
if	Ben_Reinforc_SM_cnt	= . then	Ben_Reinforc_SM_cnt	= 0;
if	Prod_Usage_SM_cnt	= . then	Prod_Usage_SM_cnt	= 0;
if	upgrade_O_pct	= . then	upgrade_O_pct	= 0;
if	Ben_Reinforc_SI_pct	= . then	Ben_Reinforc_SI_pct	= 0;
if	Prod_Usage_SI_pct	= . then	Prod_Usage_SI_pct	= 0;
if	Ben_Reinforc_SM_pct	= . then	Ben_Reinforc_SM_pct	= 0;
if	Prod_Usage_SM_pct	= . then	Prod_Usage_SM_pct	= 0;
if	line_increase_EOPN_cnt	= . then	line_increase_EOPN_cnt	= 0;
if	loan_on_chrg_EOPN_cnt	= . then	loan_on_chrg_EOPN_cnt	= 0;
if	across_BU_EOPN_cnt	= . then	across_BU_EOPN_cnt	= 0;
if	upgrade_EOPN_cnt	= . then	upgrade_EOPN_cnt	= 0;
if	supp_EOPN_cnt	= . then	supp_EOPN_cnt	= 0;
if	within_BU_EOPN_cnt	= . then	within_BU_EOPN_cnt	= 0;
if	ES_Other_EOPN_cnt	= . then	ES_Other_EOPN_cnt	= 0;
if	Retail_EOPN_cnt	= . then	Retail_EOPN_cnt	= 0;
if	Lodging_EOPN_cnt	= . then	Lodging_EOPN_cnt	= 0;
if	Restaurant_EOPN_cnt	= . then	Restaurant_EOPN_cnt	= 0;
if	Car_Rental_EOPN_cnt	= . then	Car_Rental_EOPN_cnt	= 0;
if	Airline_EOPN_cnt	= . then	Airline_EOPN_cnt	= 0;
if	Trvl_Agncy_EOPN_cnt	= . then	Trvl_Agncy_EOPN_cnt	= 0;
if	Web_Enroll_EOPN_cnt	= . then	Web_Enroll_EOPN_cnt	= 0;
if	Pers_Savings_EOPN_cnt	= . then	Pers_Savings_EOPN_cnt	= 0;
if	Mkt_Voice_EOPN_cnt	= . then	Mkt_Voice_EOPN_cnt	= 0;
if	Mkt_Res_Surv_EOPN_cnt	= . then	Mkt_Res_Surv_EOPN_cnt	= 0;
if	Circ_Mail_EOPN_cnt	= . then	Circ_Mail_EOPN_cnt	= 0;
if	Ben_Reinforc_EOPN_cnt	= . then	Ben_Reinforc_EOPN_cnt	= 0;
if	Prod_Usage_EOPN_cnt	= . then	Prod_Usage_EOPN_cnt	= 0;
if	Travl_Offer_EOPN_cnt	= . then	Travl_Offer_EOPN_cnt	= 0;
if	Card_Actvat_EOPN_cnt	= . then	Card_Actvat_EOPN_cnt	= 0;
if	Trvl_Ben_Fin_EOPN_cnt	= . then	Trvl_Ben_Fin_EOPN_cnt	= 0;
if	line_increase_EOPN_pct	= . then	line_increase_EOPN_pct	= 0;
if	loan_on_chrg_EOPN_pct	= . then	loan_on_chrg_EOPN_pct	= 0;
if	across_BU_EOPN_pct	= . then	across_BU_EOPN_pct	= 0;
if	upgrade_EOPN_pct	= . then	upgrade_EOPN_pct	= 0;
if	supp_EOPN_pct	= . then	supp_EOPN_pct	= 0;
if	within_BU_EOPN_pct	= . then	within_BU_EOPN_pct	= 0;
if	ES_Other_EOPN_pct	= . then	ES_Other_EOPN_pct	= 0;
if	Retail_EOPN_pct	= . then	Retail_EOPN_pct	= 0;
if	Lodging_EOPN_pct	= . then	Lodging_EOPN_pct	= 0;
if	Restaurant_EOPN_pct	= . then	Restaurant_EOPN_pct	= 0;
if	Car_Rental_EOPN_pct	= . then	Car_Rental_EOPN_pct	= 0;
if	Airline_EOPN_pct	= . then	Airline_EOPN_pct	= 0;
if	Trvl_Agncy_EOPN_pct	= . then	Trvl_Agncy_EOPN_pct	= 0;
if	Web_Enroll_EOPN_pct	= . then	Web_Enroll_EOPN_pct	= 0;
if	Pers_Savings_EOPN_pct	= . then	Pers_Savings_EOPN_pct	= 0;
if	Mkt_Voice_EOPN_pct	= . then	Mkt_Voice_EOPN_pct	= 0;
if	Mkt_Res_Surv_EOPN_pct	= . then	Mkt_Res_Surv_EOPN_pct	= 0;
if	Circ_Mail_EOPN_pct	= . then	Circ_Mail_EOPN_pct	= 0;
if	Ben_Reinforc_EOPN_pct	= . then	Ben_Reinforc_EOPN_pct	= 0;
if	Prod_Usage_EOPN_pct	= . then	Prod_Usage_EOPN_pct	= 0;
if	Travl_Offer_EOPN_pct	= . then	Travl_Offer_EOPN_pct	= 0;
if	Card_Actvat_EOPN_pct	= . then	Card_Actvat_EOPN_pct	= 0;
if	Trvl_Ben_Fin_EOPN_pct	= . then	Trvl_Ben_Fin_EOPN_pct	= 0;
if	line_increase_ECLK_cnt	= . then	line_increase_ECLK_cnt	= 0;
if	loan_on_chrg_ECLK_cnt	= . then	loan_on_chrg_ECLK_cnt	= 0;
if	across_BU_ECLK_cnt	= . then	across_BU_ECLK_cnt	= 0;
if	upgrade_ECLK_cnt	= . then	upgrade_ECLK_cnt	= 0;
if	supp_ECLK_cnt	= . then	supp_ECLK_cnt	= 0;
if	within_BU_ECLK_cnt	= . then	within_BU_ECLK_cnt	= 0;
if	ES_Other_ECLK_cnt	= . then	ES_Other_ECLK_cnt	= 0;
if	Retail_ECLK_cnt	= . then	Retail_ECLK_cnt	= 0;
if	Lodging_ECLK_cnt	= . then	Lodging_ECLK_cnt	= 0;
if	Restaurant_ECLK_cnt	= . then	Restaurant_ECLK_cnt	= 0;
if	Car_Rental_ECLK_cnt	= . then	Car_Rental_ECLK_cnt	= 0;
if	Airline_ECLK_cnt	= . then	Airline_ECLK_cnt	= 0;
if	Trvl_Agncy_ECLK_cnt	= . then	Trvl_Agncy_ECLK_cnt	= 0;
if	Web_Enroll_ECLK_cnt	= . then	Web_Enroll_ECLK_cnt	= 0;
if	Pers_Savings_ECLK_cnt	= . then	Pers_Savings_ECLK_cnt	= 0;
if	Mkt_Voice_ECLK_cnt	= . then	Mkt_Voice_ECLK_cnt	= 0;
if	Mkt_Res_Surv_ECLK_cnt	= . then	Mkt_Res_Surv_ECLK_cnt	= 0;
if	Circ_Mail_ECLK_cnt	= . then	Circ_Mail_ECLK_cnt	= 0;
if	Ben_Reinforc_ECLK_cnt	= . then	Ben_Reinforc_ECLK_cnt	= 0;
if	Prod_Usage_ECLK_cnt	= . then	Prod_Usage_ECLK_cnt	= 0;
if	Travl_Offer_ECLK_cnt	= . then	Travl_Offer_ECLK_cnt	= 0;
if	Card_Actvat_ECLK_cnt	= . then	Card_Actvat_ECLK_cnt	= 0;
if	Trvl_Ben_Fin_ECLK_cnt	= . then	Trvl_Ben_Fin_ECLK_cnt	= 0;
if	line_increase_ECLK_pct	= . then	line_increase_ECLK_pct	= 0;
if	loan_on_chrg_ECLK_pct	= . then	loan_on_chrg_ECLK_pct	= 0;
if	across_BU_ECLK_pct	= . then	across_BU_ECLK_pct	= 0;
if	upgrade_ECLK_pct	= . then	upgrade_ECLK_pct	= 0;
if	supp_ECLK_pct	= . then	supp_ECLK_pct	= 0;
if	within_BU_ECLK_pct	= . then	within_BU_ECLK_pct	= 0;
if	ES_Other_ECLK_pct	= . then	ES_Other_ECLK_pct	= 0;
if	Retail_ECLK_pct	= . then	Retail_ECLK_pct	= 0;
if	Lodging_ECLK_pct	= . then	Lodging_ECLK_pct	= 0;
if	Restaurant_ECLK_pct	= . then	Restaurant_ECLK_pct	= 0;
if	Car_Rental_ECLK_pct	= . then	Car_Rental_ECLK_pct	= 0;
if	Airline_ECLK_pct	= . then	Airline_ECLK_pct	= 0;
if	Trvl_Agncy_ECLK_pct	= . then	Trvl_Agncy_ECLK_pct	= 0;
if	Web_Enroll_ECLK_pct	= . then	Web_Enroll_ECLK_pct	= 0;
if	Pers_Savings_ECLK_pct	= . then	Pers_Savings_ECLK_pct	= 0;
if	Mkt_Voice_ECLK_pct	= . then	Mkt_Voice_ECLK_pct	= 0;
if	Mkt_Res_Surv_ECLK_pct	= . then	Mkt_Res_Surv_ECLK_pct	= 0;
if	Circ_Mail_ECLK_pct	= . then	Circ_Mail_ECLK_pct	= 0;
if	Ben_Reinforc_ECLK_pct	= . then	Ben_Reinforc_ECLK_pct	= 0;
if	Prod_Usage_ECLK_pct	= . then	Prod_Usage_ECLK_pct	= 0;
if	Travl_Offer_ECLK_pct	= . then	Travl_Offer_ECLK_pct	= 0;
if	Card_Actvat_ECLK_pct	= . then	Card_Actvat_ECLK_pct	= 0;
if	Trvl_Ben_Fin_ECLK_pct	= . then	Trvl_Ben_Fin_ECLK_pct	= 0;

run;

data arec559.contact_subtyp_chnl_forlogit2;
	set contact_subtyp_chnl_forlogit2;run;

proc sql;
	create table cross_attributes as 
	select *
	from contact_subtyp_chnl_forlogit2 as a
	left join arec559.attributes as b
	on a.cm11=b.cm11;
	quit;

/* create demographic dummy */
data contact_subtyp_chnl_forlogit3;
  set cross_attributes;
   if age_grp = '[18-24]' then age_18_24 = 1;  else age_18_24 = 0;
   if age_grp = '[25-30]' then age_25_30 = 1;  else age_25_30 = 0;
   if age_grp = '[31-35]' then age_31_35 = 1;  else age_31_35 = 0;
   if age_grp = '[36-40]' then age_36_40 = 1;  else age_36_40= 0;
   if age_grp = '[41-50]' then age_41_50 = 1;  else age_41_50 = 0;
   if age_grp = '[51-60]' then age_51_60 = 1;  else age_51_60 = 0;
   if age_grp = '[61+]'   then age_61_ovr = 1; else age_61_ovr = 0;
   if age_grp = '[UKN]'   then age_UKN = 1;    else age_UKN = 0;

   if gender_cd = 'M' then d_male = 1;   else d_male = 0;
   if gender_cd = 'F' then d_female = 1; else d_female = 0;
   if gender_cd = 'U' then gend_UKN = 1; else gend_UKN = 0;

   if cdss = 'A= 0 - 1'  then d_cdss_0_1 = 1;  else d_cdss_0_1 = 0;
   if cdss = 'B= >1 - 3' then d_cdss_1_3 = 1;  else d_cdss_1_3 = 0;
   if cdss = 'C= >3 - 5' then d_cdss_3_5 = 1;  else d_cdss_3_5 = 0;
   if cdss = 'D= >5 - 1' then d_cdss_5_10 = 1; else d_cdss_5_10 = 0;
   if cdss = 'E= >10 -'  then d_cdss_10 = 1;   else d_cdss_10 = 0;
   if cdss = 'F= >15'    then d_cdss_15 = 1;   else d_cdss_15 = 0;
   if cdss = 'NA'        then d_cdss_NA = 1;   else d_cdss_NA = 0;

   if mr_ind = 'Y' then d_MR = 1; else d_MR = 0;

   if choice_ind = 'Y' then d_choice = 1; else d_choice = 0;

   if lob_cd = 'OPEN' then d_open = 1; else d_open = 0;
   setup_dt_sq = setup_dt**2;

   if (email_optout_ind_prior = 0 and email_optout_ind_new = 1)             then d_chs_email_out = 1;  else d_chs_email_out = 0;
   if (direct_mail_optout_ind_prior = 0 and direct_mail_optout_ind_new = 1) then d_chs_dmail_out = 1;  else d_chs_dmail_out = 0;
   if (obtm_optout_ind_prior = 0 and obtm_optout_ind_new = 1)               then d_chs_obtm_out = 1;   else d_chs_obtm_out = 0;

   No_choice_email_in = 1 - email_optout_ind;
   No_choice_dmail_in = 1 - direct_mail_optout_ind;
   No_choice_obtm_in =  1 - obtm_optout_ind;

   if (email_optout_ind_prior = 0 and email_optout_ind_new = 0) then d_email_in_in = 1;   else d_email_in_in = 0;
   if (email_optout_ind_prior = 1 and email_optout_ind_new = 0) then d_email_out_in = 1;  else d_email_out_in = 0;
   if (email_optout_ind_prior = 0 and email_optout_ind_new = 1) then d_email_in_out = 1;  else d_email_in_out = 0;
   if (email_optout_ind_prior = 1 and email_optout_ind_new = 1) then d_email_out_out = 1; else d_email_out_out = 0;

   if (direct_mail_optout_ind_prior = 0 and direct_mail_optout_ind_new = 0) then d_dmail_in_in = 1;   else d_dmail_in_in = 0;
   if (direct_mail_optout_ind_prior = 1 and direct_mail_optout_ind_new = 0) then d_dmail_out_in = 1;  else d_dmail_out_in = 0;
   if (direct_mail_optout_ind_prior = 0 and direct_mail_optout_ind_new = 1) then d_dmail_in_out = 1;  else d_dmail_in_out = 0;
   if (direct_mail_optout_ind_prior = 1 and direct_mail_optout_ind_new = 1) then d_dmail_out_out = 1; else d_dmail_out_out = 0;

   if (obtm_optout_ind_prior = 0 and obtm_optout_ind_new = 0) then d_obtm_in_in = 1;   else d_obtm_in_in = 0;
   if (obtm_optout_ind_prior = 1 and obtm_optout_ind_new = 0) then d_obtm_out_in = 1;  else d_obtm_out_in = 0;
   if (obtm_optout_ind_prior = 0 and obtm_optout_ind_new = 1) then d_obtm_in_out = 1;  else d_obtm_in_out = 0;
   if (obtm_optout_ind_prior = 1 and obtm_optout_ind_new = 1) then d_obtm_out_out = 1; else d_obtm_out_out = 0;

   if(email_optout_ind_prior or direct_mail_optout_ind_prior or obtm_optout_ind_prior) then any_opt_out_prior = 1; else any_opt_out_prior = 0;
   if(email_optout_ind_new or direct_mail_optout_ind_new or obtm_optout_ind_new) then any_opt_out_new = 1; else any_opt_out_new = 0;

   if(email_optout_ind or direct_mail_optout_ind or obtm_optout_ind) then any_opt_out = 1; else any_opt_out = 0;

   if numdlvdates = . then numdlvdates = 0;

   num_contacts = numdlvdates;
   num_contacts_sq = numdlvdates**2;
   num_contacts_cu = numdlvdates**3;

   if num_contacts = 0 then no_contact = 1; else no_contact = 0;

run;


data arec559.contact_for_logit;
	set contact_subtyp_chnl_forlogit3;run;

	

	/* d_chs_email_out=1 means choosers in -> out*/
	/* No_choice_email_in=1 means do-no in */
data chooser_email;
  	set arec559.contact_for_logit; 
	where (d_email_in_out = 1 or No_choice_email_in = 1);
run;


/*segmentation*/
data arec559.contact_bus_charge;
	set chooser_email;
	where lob_cd = 'OPEN' and prod_pay_type_cd = 'CHARGE';
	run;
data arec559.contact_bus_lend;
	set chooser_email;
	where lob_cd = 'OPEN' and prod_pay_type_cd = 'LENDING';
	run;
data arec559.contact_con_charge;
	set chooser_email;
	where lob_cd = 'CONSUMER' and prod_pay_type_cd = 'CHARGE';
	run;
data arec559.contact_con_lend;
	set chooser_email;
	where lob_cd = 'CONSUMER' and prod_pay_type_cd = 'LENDING';
	run;

proc means data=arec559.contact_bus_charge;
	title 'bus charge';
	var d_email_in_out No_choice_email_in choice;
	run;
proc means data=arec559.contact_bus_lend;
	title 'bus lend';
	var d_email_in_out No_choice_email_in choice;
	run;
proc means data=arec559.contact_con_charge;
	title 'con charge';
	var d_email_in_out No_choice_email_in choice;
	run;
proc means data=arec559.contact_con_lend;
	title 'con lend';
	var d_email_in_out No_choice_email_in choice;
	run;


/*  Now group variables for easier runs on models   */

%let demog_vbls = age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count d_open;

%let cmpgn_typ_cnt = balance_cnt card_cnt MYSTIC_cnt service_cnt spend_cnt;
%let cmpgn_typ_pct = balance_pct card_pct MYSTIC_pct service_pct spend_pct;
%let cmpgn_typ_chnl_cnt=balance_E_cnt card_E_cnt MYSTIC_E_cnt service_E_cnt spend_E_cnt balance_D_cnt card_D_cnt MYSTIC_D_cnt
     				    service_D_cnt spend_D_cnt card_O_cnt spend_SI_cnt spend_SM_cnt; 
%let cmpgn_typ_chnl_pct=balance_E_pct card_E_pct MYSTIC_E_pct service_E_pct spend_E_pct balance_D_pct card_D_pct MYSTIC_D_pct 
						service_D_pct spend_D_pct card_O_pct spend_SI_pct spend_SM_pct;

%let all_pct =age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count d_open
                   balance_pct card_pct MYSTIC_pct service_pct spend_pct
                   balance_E_pct card_E_pct MYSTIC_E_pct service_E_pct spend_E_pct balance_D_pct card_D_pct MYSTIC_D_pct 
				   service_D_pct spend_D_pct card_O_pct spend_SI_pct spend_SM_pct;
                   
/*	Variables for each segment without colinearity	*/

/*	bus charge	*/
%let buscharge_typ=age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq  
                   myca_count fee_svc_count 
                   balance_pct card_pct;
                   
%let buscharge_typ_chnl= age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq
                   myca_count fee_svc_count
                   balance_pct card_pct ;
                   

/*	bus lend	*/
%let buslend_typ=age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count 
                    card_pct MYSTIC_pct service_pct spend_pct;
                   
%let buslend_typ_chnl=age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count 
                    card_pct MYSTIC_pct service_pct spend_pct;
                  
               

/*	con charge	*/
%let concharge_typ =age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq 
                   myca_count fee_svc_count 
                   balance_pct card_pct MYSTIC_pct service_pct spend_pct;
%let concharge_typ_chnl =age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   		d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq  
                    	myca_count fee_svc_count
						balance_pct card_pct MYSTIC_pct service_pct spend_pct
						balance_E_pct card_E_pct MYSTIC_E_pct service_E_pct spend_E_pct  card_D_pct  
						spend_D_pct  spend_SI_pct ;


/* con lend */
%let conlend_typ =age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count
                   balance_pct card_pct MYSTIC_pct service_pct spend_pct;

%let conlend_typ_chnl =age_25_30 age_31_35 age_36_40 age_41_50 age_51_60 age_61_ovr age_UKN d_female gend_UKN d_MR
                   d_cdss_0_1  d_cdss_1_3 d_cdss_3_5 d_cdss_5_10 d_cdss_10 d_cdss_15 setup_dt setup_dt_sq times_30_dpd_in_12_mnths 
                   times_60_plus_dpd_in_12_mnths myca_count fee_svc_count 
				   alance_pct card_pct MYSTIC_pct service_pct spend_pct
				   balance_E_pct card_E_pct MYSTIC_E_pct service_E_pct spend_E_pct  card_D_pct  
				    spend_D_pct  spend_SI_pct;











/* RUN LOGIT MODEL*/

/*  Number of Contacts Only  */

proc logistic data =arec559.contact_bus_charge DESCENDING;
title 'bus charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu;
run;
proc logistic data = arec559.contact_bus_lend DESCENDING;
	title 'bus lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu;
run;
proc logistic data = arec559.contact_con_charge DESCENDING;
title 'con charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu;
run;
proc logistic data = arec559.contact_con_lend DESCENDING;
title 'con lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu;
run;

/*  Number of Contacts Only + Demographics  */

proc logistic data = arec559.contact_bus_charge DESCENDING;
title 'bus charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &demog_vbls;
run;
proc logistic data =arec559.contact_bus_lend DESCENDING;
	title 'bus lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &demog_vbls;
run;
proc logistic data =arec559.contact_con_charge DESCENDING;
title 'con charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &demog_vbls;
run;
proc logistic data =arec559.contact_con_lend DESCENDING;
title 'con lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &demog_vbls;
run;


/*  Percent camppaign type  */

proc logistic data = arec559.contact_bus_charge DESCENDING;
title 'bus charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &buscharge_typ;
run;
proc logistic data = arec559.contact_bus_lend DESCENDING;
	title 'bus lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &buslend_typ;
run;
proc logistic data = arec559.contact_con_charge DESCENDING;
title 'con charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &concharge_typ;
run;
proc logistic data = arec559.contact_con_lend DESCENDING;
title 'con lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &concharge_typ;
run;

/*   Cmpgn typ chnl */
proc logistic data = arec559.contact_bus_charge DESCENDING;
title 'bus charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &buscharge_typ_chnl;
run;
proc logistic data = arec559.contact_bus_lend DESCENDING;
	title 'bus lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &buslend_typ_chnl;
run;
proc logistic data = arec559.contact_con_charge DESCENDING;
title 'con charge';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &concharge_typ_chnl;
run;
proc logistic data = arec559.contact_con_lend DESCENDING;
title 'con lend';
  model d_email_in_out = num_contacts num_contacts_sq num_contacts_cu &concharge_typ_chnl;
run;

proc means data=arec559.contact_con_charge;
var balance_pct;run;


proc freq data=arec559.contact_con_charge;
	tables d_balance;
	tables d_card;
	tables d_MYSTIC;
	tables d_spend;
	tables d_service;
	run;
proc means data=arec559.contact_con_charge;
	var balance_pct card_pct MYSTIC_pct service_pct spend_pct;
	run;
