data Contact_history_merge;
	merge arec559.contact arec559.cmpgn;
	run;

data arec559.contact_history_merge;
	set Contact_history_merge;
	run;

/* Contact_history_merge = contact history + campaign type */
data arec559.contact_type;
  set arec559.Contact_history_merge;

/*  Channel Description    */

  if chnl_desc = 'Email'                         then d_chnl_email = 1;       else d_chnl_email = 0;
  if chnl_desc = 'DM - Direct Mail'              then d_chnl_dmail = 1;       else d_chnl_dmail = 0;
  if chnl_desc = 'OBTM - Outbound Telemarketing' then d_chnl_OBTM = 1;        else d_chnl_OBTM = 0;
  if chnl_desc = 'Statement Insert'              then d_chnl_stmt_insrt = 1;  else d_chnl_stmt_insrt = 0;
  if chnl_desc = 'Statement Message'             then d_chnl_stmt_msg = 1;    else d_chnl_stmt_msg = 0;

  if evnt_outcome_desc = 'Email OPEN'               then d_email_OPEN = 1;  else d_email_OPEN = 0;
  if evnt_outcome_desc = 'Email OPEN + Email CLICK' then d_email_CLICK = 1; else d_email_CLICK = 0;
  if evnt_outcome_desc = 'Email Optout'             then d_eml_Optout = 1;  else d_eml_Optout = 0;

/* Create cmpgn type and sub type dummy */

/*  Balance   */

  if  cmpgn_typ_desc = 'Balance' and cmpgn_sub_typ_desc = 'Line Increase' then d_line_increase = 1; else d_line_increase = 0;
  if (cmpgn_typ_desc = 'Balance' and cmpgn_sub_typ_desc = 'Lending on Charge (LO') or 
     (cmpgn_typ_desc = 'BALANCE' and cmpgn_sub_typ_desc = 'LOC-ACQUISITION') then d_loan_on_chrg = 1; else d_loan_on_chrg = 0;
  if (cmpgn_typ_desc = 'Balance' or cmpgn_typ_desc = 'BALANCE') then d_balance = 1; else d_balance = 0;

/*  Card    */

  if (cmpgn_typ_desc = 'Card' and cmpgn_sub_typ_desc = 'Cross Sell Across BU') or 
     (cmpgn_typ_desc = 'CARD' and cmpgn_sub_typ_desc = 'Cross Sell Across BU') then d_across_BU = 1; else d_across_BU = 0;
  if (cmpgn_typ_desc = 'Card' and cmpgn_sub_typ_desc = 'Upgrade') or 
     (cmpgn_typ_desc = 'CARD' and cmpgn_sub_typ_desc = 'Upgrade') then d_upgrade = 1; else d_upgrade = 0;
  if (cmpgn_typ_desc = 'Card' and cmpgn_sub_typ_desc = 'New Supp') then d_supp = 1; else d_supp = 0;
  if (cmpgn_typ_desc = 'Card' and cmpgn_sub_typ_desc = 'Cross Sell Within BU') then d_within_BU = 1; else d_within_BU = 0;
  if (cmpgn_typ_desc = 'Card' or cmpgn_typ_desc = 'CARD') then d_card = 1; else d_card = 0;

/*  MYSTIC    */

  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Other')          then d_ES_Other = 1;     else d_ES_Other = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Retail')         then d_Retail = 1;       else d_Retail = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Lodging')        then d_Lodging = 1;      else d_Lodging = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Restaurant')     then d_Restaurant = 1;   else d_Restaurant = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Cruise Line')    then d_Cruise_Line = 1;  else d_Cruise_Line = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Car Rental')     then d_Car_Rental = 1;   else d_Car_Rental = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Airline')        then d_Airline = 1;      else d_Airline = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Supermarkets')   then d_Supermrkt = 1;    else d_Supermrkt = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Furniture')      then d_Furniture = 1;    else d_Furniture = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Entertainment')  then d_Entertain = 1;    else d_Entertain = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Telecom')        then d_Telecom = 1;      else d_Telecom = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES MYSTIC/CHARITIES') then d_Charity = 1;      else d_Charity = 0;
  if (cmpgn_typ_desc = 'MYSTIC' and cmpgn_sub_typ_desc = 'ES - Travel Agency')  then d_Trvl_Agncy = 1;   else d_Trvl_Agncy = 0;
  if  cmpgn_typ_desc = 'MYSTIC' then d_MYSTIC = 1;   else d_MYSTIC = 0;

/*  Service    */

  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Web Enrollments')       then d_Web_Enroll = 1;   else d_Web_Enroll = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Personal Savings')      then d_Pers_Savings = 1; else d_Pers_Savings = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Books Products and Se') then d_Books = 1;        else d_Books = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'MarketVoice')           then d_Mkt_Voice = 1;    else d_Mkt_Voice = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Benefits Mailings')     then d_Ben_Mail = 1;     else d_Ben_Mail = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Market Research Surve') then d_Mkt_Res_Surv = 1; else d_Mkt_Res_Surv = 0;
  if (cmpgn_typ_desc = 'Service' and cmpgn_sub_typ_desc = 'Circulation Mailings')  then d_Circ_Mail = 1;    else d_Circ_Mail = 0;
  if  cmpgn_typ_desc = 'Service' then d_service = 1;    else d_service = 0;

/*  Spend    */

  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Benefit Reinforcement') or
     (cmpgn_typ_desc = 'SPEND' and cmpgn_sub_typ_desc = 'Benefit Reinforcement') then d_Ben_Reinforc = 1;  else d_Ben_Reinforc = 0;
  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Product Usage') or
     (cmpgn_typ_desc = 'SPEND' and cmpgn_sub_typ_desc = 'Product Usage')         then d_Prod_Usage = 1;    else d_Prod_Usage = 0;
  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Travel Offers')         then d_Travl_Offer = 1;   else d_Travl_Offer = 0;
  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Card Activation')       then d_Card_Actvat = 1;   else d_Card_Actvat = 0;
  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Ad Sales Mailings')     then d_Ad_Sales_Mail = 1; else d_Ad_Sales_Mail = 0;
  if (cmpgn_typ_desc = 'Spend' and cmpgn_sub_typ_desc = 'Travel Benefits / Fin') then d_Trvl_Ben_Fin = 1;  else d_Trvl_Ben_Fin = 0;
  if (cmpgn_typ_desc = 'Spend' or cmpgn_typ_desc = 'SPEND') then d_spend = 1;  else d_spend = 0;

run;

/*  32 Dummies for contact variable types and sub-types   */


/*   Create channel specific contact subtype dummies   */

data arec559.contact_subtyp_chnl;
  set arec559.contact_type;

/*  email contacts   */

  d_balance_E = d_balance*d_chnl_email;
  d_card_E = d_card*d_chnl_email;
  d_MYSTIC_E = d_MYSTIC*d_chnl_email;
  d_service_E = d_service*d_chnl_email;
  d_spend_E = d_spend*d_chnl_email;

  d_line_increase_E = d_line_increase*d_chnl_email;
  d_loan_on_chrg_E = d_loan_on_chrg*d_chnl_email;
  d_across_BU_E = d_across_BU*d_chnl_email;
  d_upgrade_E = d_upgrade*d_chnl_email;
  d_supp_E = d_supp*d_chnl_email;
  d_within_BU_E= d_within_BU*d_chnl_email;
  d_ES_Other_E = d_ES_Other*d_chnl_email;
  d_Retail_E = d_Retail*d_chnl_email;
  d_Lodging_E = d_Lodging*d_chnl_email;
  d_Restaurant_E = d_Restaurant*d_chnl_email;

  d_Car_Rental_E = d_Car_Rental*d_chnl_email;
  d_Airline_E = d_Airline*d_chnl_email;

  d_Trvl_Agncy_E = d_Trvl_Agncy*d_chnl_email;        
  d_Web_Enroll_E = d_Web_Enroll*d_chnl_email;
  d_Pers_Savings_E = d_Pers_Savings*d_chnl_email;

  d_Mkt_Voice_E = d_Mkt_Voice*d_chnl_email;

  d_Mkt_Res_Surv_E = d_Mkt_Res_Surv*d_chnl_email;
  d_Circ_Mail_E = d_Circ_Mail*d_chnl_email;
  d_Ben_Reinforc_E = d_Ben_Reinforc*d_chnl_email;
  d_Prod_Usage_E = d_Prod_Usage*d_chnl_email;
  d_Travl_Offer_E = d_Travl_Offer*d_chnl_email;
  d_Card_Actvat_E = d_Card_Actvat*d_chnl_email;

  d_Trvl_Ben_Fin_E = d_Trvl_Ben_Fin*d_chnl_email;

/*  direct mail contacts   */

  d_balance_D = d_balance*d_chnl_dmail;
  d_card_D = d_card*d_chnl_dmail;
  d_MYSTIC_D = d_MYSTIC*d_chnl_dmail;
  d_service_D = d_service*d_chnl_dmail;
  d_spend_D = d_spend*d_chnl_dmail;

  d_line_increase_D = d_line_increase*d_chnl_dmail;
  d_loan_on_chrg_D = d_loan_on_chrg*d_chnl_dmail;
  d_across_BU_D = d_across_BU*d_chnl_dmail;
  d_upgrade_D = d_upgrade*d_chnl_dmail;
  d_supp_D = d_supp*d_chnl_dmail;
  d_within_BU_E= d_within_BU*d_chnl_dmail;
  d_ES_Other_D = d_ES_Other*d_chnl_dmail;
  d_Retail_D = d_Retail*d_chnl_dmail;
  d_Lodging_D = d_Lodging*d_chnl_dmail;
  d_Restaurant_D = d_Restaurant*d_chnl_dmail;
  d_Cruise_Line_D = d_Cruise_Line*d_chnl_dmail;
  d_Car_Rental_D = d_Car_Rental*d_chnl_dmail;
  d_Airline_D = d_Airline*d_chnl_dmail;
  d_Supermrkt_D = d_Supermrkt*d_chnl_dmail;
  d_Furniture_D = d_Furniture*d_chnl_dmail;
  d_Entertain_D = d_Entertain*d_chnl_dmail;
  d_Telecom_D = d_Telecom*d_chnl_dmail;
  d_Charity_D = d_Charity*d_chnl_dmail;

  d_Pers_Savings_D = d_Pers_Savings*d_chnl_dmail;
  d_Books_D = d_Books*d_chnl_dmail;

  d_Ben_Mail_D = d_Ben_Mail*d_chnl_dmail;

  d_Circ_Mail_D = d_Circ_Mail*d_chnl_dmail;
  d_Ben_Reinforc_D = d_Ben_Reinforc*d_chnl_dmail;
  d_Prod_Usage_D = d_Prod_Usage*d_chnl_dmail;
  d_Travl_Offer_D = d_Travl_Offer*d_chnl_dmail;

  d_Ad_Sales_Mail_D = d_Ad_Sales_Mail*d_chnl_dmail;
  d_Trvl_Ben_Fin_D = d_Trvl_Ben_Fin*d_chnl_dmail;

/*  OBTM   */

  d_card_O = d_card*d_chnl_obtm;
  d_upgrade_O = d_upgrade*d_chnl_obtm;

/*  Statement Insert   */

  d_spend_SI = d_spend*d_chnl_stmt_insrt;
  d_Ben_Reinforc_SI = d_Ben_Reinforc*d_chnl_stmt_insrt;
  d_Prod_Usage_SI = d_Prod_Usage*d_chnl_stmt_insrt;

/*  Statement Message   */

  d_spend_SM = d_spend*d_chnl_stmt_msg;
  d_Ben_Reinforc_SM = d_Ben_Reinforc*d_chnl_stmt_msg;
  d_Prod_Usage_SM = d_Prod_Usage*d_chnl_stmt_msg;

/*  ---------------------  */
/*  email contacts OEPNED  */
/*  ---------------------  */

  d_balance_EOPN = d_balance*d_email_OPEN;
  d_card_EOPN  = d_card*d_email_OPEN;
  d_MYSTIC_EOPN = d_MYSTIC*d_email_OPEN;
  d_service_EOPN = d_service*d_email_OPEN;
  d_spend_EOPN = d_spend*d_email_OPEN;

  d_line_increase_EOPN = d_line_increase*d_email_OPEN;
  d_loan_on_chrg_EOPN = d_loan_on_chrg*d_email_OPEN;
  d_across_BU_EOPN = d_across_BU*d_email_OPEN;
  d_upgrade_EOPN = d_upgrade*d_email_OPEN;
  d_supp_EOPN = d_supp*d_email_OPEN;
  d_within_BU_EOPN = d_within_BU*d_email_OPEN;
  d_ES_Other_EOPN = d_ES_Other*d_email_OPEN;
  d_Retail_EOPN = d_Retail*d_email_OPEN;
  d_Lodging_EOPN = d_Lodging*d_email_OPEN;
  d_Restaurant_EOPN = d_Restaurant*d_email_OPEN;

  d_Car_Rental_EOPN = d_Car_Rental*d_email_OPEN;
  d_Airline_EOPN = d_Airline*d_email_OPEN;

  d_Trvl_Agncy_EOPN = d_Trvl_Agncy*d_email_OPEN;        
  d_Web_Enroll_EOPN = d_Web_Enroll*d_email_OPEN;
  d_Pers_Savings_EOPN = d_Pers_Savings*d_email_OPEN;

  d_Mkt_Voice_EOPN = d_Mkt_Voice*d_email_OPEN;

  d_Mkt_Res_Surv_EOPN = d_Mkt_Res_Surv*d_email_OPEN;
  d_Circ_Mail_EOPN = d_Circ_Mail*d_email_OPEN;
  d_Ben_Reinforc_EOPN = d_Ben_Reinforc*d_email_OPEN;
  d_Prod_Usage_EOPN = d_Prod_Usage*d_email_OPEN;
  d_Travl_Offer_EOPN = d_Travl_Offer*d_email_OPEN;
  d_Card_Actvat_EOPN = d_Card_Actvat*d_email_OPEN;

  d_Trvl_Ben_Fin_EOPN = d_Trvl_Ben_Fin*d_email_OPEN;

/*  -----------------------------  */
/*  email contacts OEPNED + CLICK  */
/*  -----------------------------  */

  d_balance_ECLK = d_balance*d_email_CLICK;
  d_card_ECLK  = d_card*d_email_CLICK;
  d_MYSTIC_ECLK = d_MYSTIC*d_email_CLICK;
  d_service_ECLK = d_service*d_email_CLICK;
  d_spend_ECLK = d_spend*d_email_CLICK;

  d_line_increase_ECLK = d_line_increase*d_email_CLICK;
  d_loan_on_chrg_ECLK = d_loan_on_chrg*d_email_CLICK;
  d_across_BU_ECLK = d_across_BU*d_email_CLICK;
  d_upgrade_ECLK = d_upgrade*d_email_CLICK;
  d_supp_ECLK = d_supp*d_email_CLICK;
  d_within_BU_ECLK = d_within_BU*d_email_CLICK;
  d_ES_Other_ECLK = d_ES_Other*d_email_CLICK;
  d_Retail_ECLK = d_Retail*d_email_CLICK;
  d_Lodging_ECLK = d_Lodging*d_email_CLICK;
  d_Restaurant_ECLK = d_Restaurant*d_email_CLICK;

  d_Car_Rental_ECLK = d_Car_Rental*d_email_CLICK;
  d_Airline_ECLK = d_Airline*d_email_CLICK;

  d_Trvl_Agncy_ECLK = d_Trvl_Agncy*d_email_CLICK;        
  d_Web_Enroll_ECLK = d_Web_Enroll*d_email_CLICK;
  d_Pers_Savings_ECLK = d_Pers_Savings*d_email_CLICK;

  d_Mkt_Voice_ECLK = d_Mkt_Voice*d_email_CLICK;

  d_Mkt_Res_Surv_ECLK = d_Mkt_Res_Surv*d_email_CLICK;
  d_Circ_Mail_ECLK = d_Circ_Mail*d_email_CLICK;
  d_Ben_Reinforc_ECLK = d_Ben_Reinforc*d_email_CLICK;
  d_Prod_Usage_ECLK = d_Prod_Usage*d_email_CLICK;
  d_Travl_Offer_ECLK = d_Travl_Offer*d_email_CLICK;
  d_Card_Actvat_ECLK = d_Card_Actvat*d_email_CLICK;

  d_Trvl_Ben_Fin_ECLK = d_Trvl_Ben_Fin*d_email_CLICK;

  run;


  /*   Roll up or aggregate to cross-sectional data by CM   */

/*  OJO:  Check for multiple contacts on the same day   */

/*XXXXXXXXX  include balance, card, MYSTIC, service & spend   XXXXXX   */



proc sql;
 create table contact_subtyp_chnl_Rollup as
   select * ,

/*  cmpgn_typ_desc count and percent  */

     sum(d_balance) as balance_cnt,
     sum(d_card) as card_cnt,
     sum(d_MYSTIC) as MYSTIC_cnt,
     sum(d_service) as service_cnt,
     sum(d_spend) as spend_cnt,

     sum(d_balance)/count(trans_dt) as balance_pct,
     sum(d_card)/count(trans_dt) as card_pct,
     sum(d_MYSTIC)/count(trans_dt) as MYSTIC_pct,
     sum(d_service)/count(trans_dt) as service_pct,
     sum(d_spend)/count(trans_dt) as spend_pct,


/*  cmpgn_typ_desc by email count and percent  */

     sum(d_balance_E) as balance_E_cnt,
     sum(d_card_E) as card_E_cnt,
     sum(d_MYSTIC_E) as MYSTIC_E_cnt,
     sum(d_service_E) as service_E_cnt,
     sum(d_spend_E) as spend_E_cnt,

     sum(d_balance_E)/count(trans_dt) as balance_E_pct,
     sum(d_card_E)/count(trans_dt) as card_E_pct,
     sum(d_MYSTIC_E)/count(trans_dt) as MYSTIC_E_pct,
     sum(d_service_E)/count(trans_dt) as service_E_pct,
     sum(d_spend_E)/count(trans_dt) as spend_E_pct,

/*  cmpgn_typ_desc by direct mail count and percent  */

     sum(d_balance_D) as balance_D_cnt,
     sum(d_card_D) as card_D_cnt,
     sum(d_MYSTIC_D) as MYSTIC_D_cnt,
     sum(d_service_D) as service_D_cnt,
     sum(d_spend_D) as spend_D_cnt,

     sum(d_balance_D)/count(trans_dt) as balance_D_pct,
     sum(d_card_D)/count(trans_dt) as card_D_pct,
     sum(d_MYSTIC_D)/count(trans_dt) as MYSTIC_D_pct,
     sum(d_service_D)/count(trans_dt) as service_D_pct,
     sum(d_spend_D)/count(trans_dt) as spend_D_pct,

/*  cmpgn_typ_desc by OBTM and Statement inserts & messages count and percent  */

     sum(d_card_O) as card_O_cnt,
     sum(d_spend_SI) as spend_SI_cnt,
     sum(d_spend_SM) as spend_SM_cnt,

     sum(d_card_O)/count(trans_dt) as card_O_pct,
     sum(d_spend_SI)/count(trans_dt) as spend_SI_pct,
     sum(d_spend_SM)/count(trans_dt) as spend_SM_pct,

/*  cmpgn_typ_desc by email OPEN count and percent  */

     sum(d_balance_EOPN) as balance_EOPN_cnt,
     sum(d_card_EOPN) as card_EOPN_cnt,
     sum(d_MYSTIC_EOPN) as MYSTIC_EOPN_cnt,
     sum(d_service_EOPN) as service_EOPN_cnt,
     sum(d_spend_EOPN) as spend_EOPN_cnt,

     sum(d_balance_EOPN)/count(d_chnl_email) as balance_EOPN_pct,
     sum(d_card_EOPN)/count(d_chnl_email) as card_EOPN_pct,
     sum(d_MYSTIC_EOPN)/count(d_chnl_email) as MYSTIC_EOPN_pct,
     sum(d_service_EOPN)/count(d_chnl_email) as service_EOPN_pct,
     sum(d_spend_EOPN)/count(d_chnl_email) as spend_EOPN_pct,

/*  cmpgn_typ_desc by email OPEN + CLICK count and percent  */

     sum(d_balance_ECLK) as balance_ECLK_cnt,
     sum(d_card_ECLK) as card_ECLK_cnt,
     sum(d_MYSTIC_ECLK) as MYSTIC_ECLK_cnt,
     sum(d_service_ECLK) as service_ECLK_cnt,
     sum(d_spend_ECLK) as spend_ECLK_cnt,

     sum(d_balance_ECLK)/count(d_chnl_email) as balance_ECLK_pct,
     sum(d_card_ECLK)/count(d_chnl_email) as card_ECLK_pct,
     sum(d_MYSTIC_ECLK)/count(d_chnl_email) as MYSTIC_ECLK_pct,
     sum(d_service_ECLK)/count(d_chnl_email) as service_ECLK_pct,
     sum(d_spend_ECLK)/count(d_chnl_email) as spend_ECLK_pct,

/*  cmpgn_sub_typ_desc count and percent  */

     sum(d_line_increase) as line_increase_cnt,
     sum(d_loan_on_chrg) as loan_on_chrg_cnt,
     sum(d_across_BU) as across_BU_cnt,
     sum(d_upgrade) as upgrade_cnt,
     sum(d_supp) as supp_cnt,
     sum(d_within_BU) as within_BU_cnt,
     sum(d_ES_Other) as ES_Other_cnt,
     sum(d_Retail) as Retail_cnt,
     sum(d_Lodging) as Lodging_cnt,
     sum(d_Restaurant) as Restaurant_cnt,
     sum(d_Cruise_Line) as Cruise_Line_cnt,
     sum(d_Car_Rental) as Car_Rental_cnt,
     sum(d_Airline) as Airline_cnt,
     sum(d_Supermrkt) as Supermrkt_cnt,
     sum(d_Furniture) as Furniture_cnt,
     sum(d_Entertain) as Entertain_cnt,
     sum(d_Telecom) as Telecom_cnt,
     sum(d_Charity) as Charity_cnt,
     sum(d_Trvl_Agncy) as Trvl_Agncy_cnt,
     sum(d_Web_Enroll) as Web_Enroll_cnt,
     sum(d_Pers_Savings) as Pers_Savings_cnt,
     sum(d_Books) as Books_cnt,
     sum(d_Mkt_Voice) as Mkt_Voice_cnt,
     sum(d_Ben_Mail) as Ben_Mail_cnt,
     sum(d_Mkt_Res_Surv) as Mkt_Res_Surv_cnt,
     sum(d_Circ_Mail) as Circ_Mail_cnt,
     sum(d_Ben_Reinforc) as Ben_Reinforc_cnt,
     sum(d_Prod_Usage) as Prod_Usage_cnt,
     sum(d_Travl_Offer) as Travl_Offer_cnt,
     sum(d_Card_Actvat) as Card_Actvat_cnt,
     sum(d_Ad_Sales_Mail) as Ad_Sales_Mail_cnt,
     sum(d_Trvl_Ben_Fin) as Trvl_Ben_Fin_cnt,

     sum(d_line_increase)/count(trans_dt) as line_increase_pct,
     sum(d_loan_on_chrg)/count(trans_dt) as loan_on_chrg_pct,
     sum(d_across_BU)/count(trans_dt) as across_BU_pct,
     sum(d_upgrade)/count(trans_dt) as upgrade_pct,
     sum(d_supp)/count(trans_dt) as supp_pct,
     sum(d_within_BU)/count(trans_dt) as within_BU_pct,
     sum(d_ES_Other)/count(trans_dt) as ES_Other_pct,
     sum(d_Retail)/count(trans_dt) as Retail_pct,
     sum(d_Lodging)/count(trans_dt) as Lodging_pct,
     sum(d_Restaurant)/count(trans_dt) as Restaurant_pct,
     sum(d_Cruise_Line)/count(trans_dt) as Cruise_Line_pct,
     sum(d_Car_Rental)/count(trans_dt) as Car_Rental_pct,
     sum(d_Airline)/count(trans_dt) as Airline_pct,
     sum(d_Supermrkt)/count(trans_dt) as Supermrkt_pct,
     sum(d_Furniture)/count(trans_dt) as Furniture_pct,
     sum(d_Entertain)/count(trans_dt) as Entertain_pct,
     sum(d_Telecom)/count(trans_dt) as Telecom_pct,
     sum(d_Charity)/count(trans_dt) as Charity_pct,
     sum(d_Trvl_Agncy)/count(trans_dt) as Trvl_Agncy_pct,
     sum(d_Web_Enroll)/count(trans_dt) as Web_Enroll_pct,
     sum(d_Pers_Savings)/count(trans_dt) as Pers_Savings_pct,
     sum(d_Books)/count(trans_dt) as Books_pct,
     sum(d_Mkt_Voice)/count(trans_dt) as Mkt_Voice_pct,
     sum(d_Ben_Mail)/count(trans_dt) as Ben_Mail_pct,
     sum(d_Mkt_Res_Surv)/count(trans_dt) as Mkt_Res_Surv_pct,
     sum(d_Circ_Mail)/count(trans_dt) as Circ_Mail_pct,
     sum(d_Ben_Reinforc)/count(trans_dt) as Ben_Reinforc_pct,
     sum(d_Prod_Usage)/count(trans_dt) as Prod_Usage_pct,
     sum(d_Travl_Offer)/count(trans_dt) as Travl_Offer_pct,
     sum(d_Card_Actvat)/count(trans_dt) as Card_Actvat_pct,
     sum(d_Ad_Sales_Mail)/count(trans_dt) as Ad_Sales_Mail_pct,
     sum(d_Trvl_Ben_Fin)/count(trans_dt) as Trvl_Ben_Fin_pct,

/*  email count and percentage   */

     sum(d_line_increase_E) as line_increase_e_cnt,
     sum(d_loan_on_chrg_E) as loan_on_chrg_e_cnt,
     sum(d_across_BU_E) as across_BU_e_cnt,
     sum(d_upgrade_E) as upgrade_e_cnt,
     sum(d_supp_E) as supp_e_cnt,
     sum(d_within_BU_E) as within_BU_e_cnt,
     sum(d_ES_Other_E) as ES_Other_e_cnt,
     sum(d_Retail_E) as Retail_e_cnt,
     sum(d_Lodging_E) as Lodging_e_cnt,
     sum(d_Restaurant_E) as Restaurant_e_cnt,
     sum(d_Car_Rental_E) as Car_Rental_e_cnt,
     sum(d_Airline_E) as Airline_e_cnt,
     sum(d_Trvl_Agncy_E) as Trvl_Agncy_e_cnt,
     sum(d_Web_Enroll_E) as Web_Enroll_e_cnt,
     sum(d_Pers_Savings_E) as Pers_Savings_e_cnt,
     sum(d_Mkt_Voice_E) as Mkt_Voice_e_cnt,
     sum(d_Mkt_Res_Surv_E) as Mkt_Res_Surv_e_cnt,
     sum(d_Circ_Mail_E) as Circ_Mail_e_cnt,
     sum(d_Ben_Reinforc_E) as Ben_Reinforc_e_cnt,
     sum(d_Prod_Usage_E) as Prod_Usage_e_cnt,
     sum(d_Travl_Offer_E) as Travl_Offer_e_cnt,
     sum(d_Card_Actvat_E) as Card_Actvat_e_cnt,
     sum(d_Trvl_Ben_Fin_E) as Trvl_Ben_Fin_e_cnt,

     sum(d_line_increase_E)/count(trans_dt) as line_increase_e_pct,
     sum(d_loan_on_chrg_E)/count(trans_dt) as loan_on_chrg_e_pct,
     sum(d_across_BU_E)/count(trans_dt) as across_BU_e_pct,
     sum(d_upgrade_E)/count(trans_dt) as upgrade_e_pct,
     sum(d_supp_E)/count(trans_dt) as supp_e_pct,
     sum(d_within_BU_E)/count(trans_dt) as within_BU_e_pct,
     sum(d_ES_Other_E)/count(trans_dt) as ES_Other_e_pct,
     sum(d_Retail_E)/count(trans_dt) as Retail_e_pct,
     sum(d_Lodging_E)/count(trans_dt) as Lodging_e_pct,
     sum(d_Restaurant_E)/count(trans_dt) as Restaurant_e_pct,
     sum(d_Car_Rental_E)/count(trans_dt) as Car_Rental_e_pct,
     sum(d_Airline_E)/count(trans_dt) as Airline_e_pct,
     sum(d_Trvl_Agncy_E)/count(trans_dt) as Trvl_Agncy_e_pct,
     sum(d_Web_Enroll_E)/count(trans_dt) as Web_Enroll_e_pct,
     sum(d_Pers_Savings_E)/count(trans_dt) as Pers_Savings_e_pct,
     sum(d_Mkt_Voice_E)/count(trans_dt) as Mkt_Voice_e_pct,
     sum(d_Mkt_Res_Surv_E)/count(trans_dt) as Mkt_Res_Surv_e_pct,
     sum(d_Circ_Mail_E)/count(trans_dt) as Circ_Mail_e_pct,
     sum(d_Ben_Reinforc_E)/count(trans_dt) as Ben_Reinforc_e_pct,
     sum(d_Prod_Usage_E)/count(trans_dt) as Prod_Usage_e_pct,
     sum(d_Travl_Offer_E)/count(trans_dt) as Travl_Offer_e_pct,
     sum(d_Card_Actvat_E)/count(trans_dt) as Card_Actvat_e_pct,
     sum(d_Trvl_Ben_Fin_E)/count(trans_dt) as Trvl_Ben_Fin_e_pct,

/*  Direct mail count and percentage  */

     sum(d_line_increase_D) as line_increase_D_cnt,
     sum(d_loan_on_chrg_D) as loan_on_chrg_D_cnt,
     sum(d_across_BU_D) as across_BU_D_cnt,
     sum(d_upgrade_D) as upgrade_D_cnt,
     sum(d_supp_D) as supp_D_cnt,
     sum(d_ES_Other_D) as ES_Other_D_cnt,
     sum(d_Retail_D) as Retail_D_cnt,
     sum(d_Lodging_D) as Lodging_D_cnt,
     sum(d_Restaurant_D) as Restaurant_D_cnt,
     sum(d_Cruise_Line_D) as Cruise_Line_D_cnt,
     sum(d_Car_Rental_D) as Car_Rental_D_cnt,
     sum(d_Airline_D) as Airline_D_cnt,
     sum(d_Supermrkt_D) as Supermrkt_D_cnt,
     sum(d_Furniture_D) as Furniture_D_cnt,
     sum(d_Entertain_D) as Entertain_D_cnt,
     sum(d_Telecom_D) as Telecom_D_cnt,
     sum(d_Charity_D) as Charity_D_cnt,
     sum(d_Pers_Savings_D) as Pers_Savings_D_cnt,
     sum(d_Books_D) as Books_D_cnt,
     sum(d_Ben_Mail_D) as Ben_Mail_D_cnt,
     sum(d_Circ_Mail_D) as Circ_Mail_D_cnt,
     sum(d_Ben_Reinforc_D) as Ben_Reinforc_D_cnt,
     sum(d_Prod_Usage_D) as Prod_Usage_D_cnt,
     sum(d_Travl_Offer_D) as Travl_Offer_D_cnt,
     sum(d_Ad_Sales_Mail_D) as Ad_Sales_Mail_D_cnt,
     sum(d_Trvl_Ben_Fin_D) as Trvl_Ben_Fin_D_cnt,

     sum(d_line_increase_D)/count(trans_dt) as line_increase_D_pct,
     sum(d_loan_on_chrg_D)/count(trans_dt) as loan_on_chrg_D_pct,
     sum(d_across_BU_D)/count(trans_dt) as across_BU_D_pct,
     sum(d_upgrade_D)/count(trans_dt) as upgrade_D_pct,
     sum(d_supp_D)/count(trans_dt) as supp_D_pct,
     sum(d_ES_Other_D)/count(trans_dt) as ES_Other_D_pct,
     sum(d_Retail_D)/count(trans_dt) as Retail_D_pct,
     sum(d_Lodging_D)/count(trans_dt) as Lodging_D_pct,
     sum(d_Restaurant_D)/count(trans_dt) as Restaurant_D_pct,
     sum(d_Cruise_Line_D)/count(trans_dt) as Cruise_Line_D_pct,
     sum(d_Car_Rental_D)/count(trans_dt) as Car_Rental_D_pct,
     sum(d_Airline_D)/count(trans_dt) as Airline_D_pct,
     sum(d_Supermrkt_D)/count(trans_dt) as Supermrkt_D_pct,
     sum(d_Furniture_D)/count(trans_dt) as Furniture_D_pct,
     sum(d_Entertain_D)/count(trans_dt) as Entertain_D_pct,
     sum(d_Telecom_D)/count(trans_dt) as Telecom_D_pct,
     sum(d_Charity_D)/count(trans_dt) as Charity_D_pct,
     sum(d_Pers_Savings_D)/count(trans_dt) as Pers_Savings_D_pct,
     sum(d_Books_D)/count(trans_dt) as Books_D_pct,
     sum(d_Ben_Mail_D)/count(trans_dt) as Ben_Mail_D_pct,
     sum(d_Circ_Mail_D)/count(trans_dt) as Circ_Mail_D_pct,
     sum(d_Ben_Reinforc_D)/count(trans_dt) as Ben_Reinforc_D_pct,
     sum(d_Prod_Usage_D)/count(trans_dt) as Prod_Usage_D_pct,
     sum(d_Travl_Offer_D)/count(trans_dt) as Travl_Offer_D_pct,
     sum(d_Ad_Sales_Mail_D)/count(trans_dt) as Ad_Sales_Mail_D_pct,
     sum(d_Trvl_Ben_Fin_D)/count(trans_dt) as Trvl_Ben_Fin_D_pct,

/*  OBTM, statement inserts and messages   */

     sum(d_upgrade_O) as upgrade_O_cnt,
     sum(d_Ben_Reinforc_SI) as Ben_Reinforc_SI_cnt,
     sum(d_Prod_Usage_SI) as Prod_Usage_SI_cnt,
     sum(d_Ben_Reinforc_SM) as Ben_Reinforc_SM_cnt,
     sum(d_Prod_Usage_SM) as Prod_Usage_SM_cnt,

     sum(d_upgrade_O)/count(trans_dt) as upgrade_O_pct,
     sum(d_Ben_Reinforc_SI)/count(trans_dt) as Ben_Reinforc_SI_pct,
     sum(d_Prod_Usage_SI)/count(trans_dt) as Prod_Usage_SI_pct,
     sum(d_Ben_Reinforc_SM)/count(trans_dt) as Ben_Reinforc_SM_pct,
     sum(d_Prod_Usage_SM)/count(trans_dt) as Prod_Usage_SM_pct,

/*  Open email count and percentages   */

     sum(d_line_increase_EOPN) as line_increase_EOPN_cnt,
     sum(d_loan_on_chrg_EOPN) as loan_on_chrg_EOPN_cnt,
     sum(d_across_BU_EOPN) as across_BU_EOPN_cnt,
     sum(d_upgrade_EOPN) as upgrade_EOPN_cnt,
     sum(d_supp_EOPN) as supp_EOPN_cnt,
     sum(d_within_BU_EOPN) as within_BU_EOPN_cnt,
     sum(d_ES_Other_EOPN) as ES_Other_EOPN_cnt,
     sum(d_Retail_EOPN) as Retail_EOPN_cnt,
     sum(d_Lodging_EOPN) as Lodging_EOPN_cnt,
     sum(d_Restaurant_EOPN) as Restaurant_EOPN_cnt,
     sum(d_Car_Rental_EOPN) as Car_Rental_EOPN_cnt,
     sum(d_Airline_EOPN) as Airline_EOPN_cnt,
     sum(d_Trvl_Agncy_EOPN) as Trvl_Agncy_EOPN_cnt,
     sum(d_Web_Enroll_EOPN) as Web_Enroll_EOPN_cnt,
     sum(d_Pers_Savings_EOPN) as Pers_Savings_EOPN_cnt,
     sum(d_Mkt_Voice_EOPN) as Mkt_Voice_EOPN_cnt,
     sum(d_Mkt_Res_Surv_EOPN) as Mkt_Res_Surv_EOPN_cnt,
     sum(d_Circ_Mail_EOPN) as Circ_Mail_EOPN_cnt,
     sum(d_Ben_Reinforc_EOPN) as Ben_Reinforc_EOPN_cnt,
     sum(d_Prod_Usage_EOPN) as Prod_Usage_EOPN_cnt,
     sum(d_Travl_Offer_EOPN) as Travl_Offer_EOPN_cnt,
     sum(d_Card_Actvat_EOPN) as Card_Actvat_EOPN_cnt,
     sum(d_Trvl_Ben_Fin_EOPN) as Trvl_Ben_Fin_EOPN_cnt,

/*  Calculate as a percentage of email contacts   */

     sum(d_line_increase_EOPN)/count(d_chnl_email) as line_increase_EOPN_pct,
     sum(d_loan_on_chrg_EOPN)/count(d_chnl_email) as loan_on_chrg_EOPN_pct,
     sum(d_across_BU_EOPN)/count(d_chnl_email) as across_BU_EOPN_pct,
     sum(d_upgrade_EOPN)/count(d_chnl_email) as upgrade_EOPN_pct,
     sum(d_supp_EOPN)/count(d_chnl_email) as supp_EOPN_pct,
     sum(d_within_BU_EOPN)/count(d_chnl_email) as within_BU_EOPN_pct,
     sum(d_ES_Other_EOPN)/count(d_chnl_email) as ES_Other_EOPN_pct,
     sum(d_Retail_EOPN)/count(d_chnl_email) as Retail_EOPN_pct,
     sum(d_Lodging_EOPN)/count(d_chnl_email) as Lodging_EOPN_pct,
     sum(d_Restaurant_EOPN)/count(d_chnl_email) as Restaurant_EOPN_pct,
     sum(d_Car_Rental_EOPN)/count(d_chnl_email) as Car_Rental_EOPN_pct,
     sum(d_Airline_EOPN)/count(d_chnl_email) as Airline_EOPN_pct,
     sum(d_Trvl_Agncy_EOPN)/count(d_chnl_email) as Trvl_Agncy_EOPN_pct,
     sum(d_Web_Enroll_EOPN)/count(d_chnl_email) as Web_Enroll_EOPN_pct,
     sum(d_Pers_Savings_EOPN)/count(d_chnl_email) as Pers_Savings_EOPN_pct,
     sum(d_Mkt_Voice_EOPN)/count(d_chnl_email) as Mkt_Voice_EOPN_pct,
     sum(d_Mkt_Res_Surv_EOPN)/count(d_chnl_email) as Mkt_Res_Surv_EOPN_pct,
     sum(d_Circ_Mail_EOPN)/count(d_chnl_email) as Circ_Mail_EOPN_pct,
     sum(d_Ben_Reinforc_EOPN)/count(d_chnl_email) as Ben_Reinforc_EOPN_pct,
     sum(d_Prod_Usage_EOPN)/count(d_chnl_email) as Prod_Usage_EOPN_pct,
     sum(d_Travl_Offer_EOPN)/count(d_chnl_email) as Travl_Offer_EOPN_pct,
     sum(d_Card_Actvat_EOPN)/count(d_chnl_email) as Card_Actvat_EOPN_pct,
     sum(d_Trvl_Ben_Fin_EOPN)/count(d_chnl_email) as Trvl_Ben_Fin_EOPN_pct,

/*  Opend + Click email count and percentages   */

     sum(d_line_increase_ECLK) as line_increase_ECLK_cnt,
     sum(d_loan_on_chrg_ECLK) as loan_on_chrg_ECLK_cnt,
     sum(d_across_BU_ECLK) as across_BU_ECLK_cnt,
     sum(d_upgrade_ECLK) as upgrade_ECLK_cnt,
     sum(d_supp_ECLK) as supp_ECLK_cnt,
     sum(d_within_BU_ECLK) as within_BU_ECLK_cnt,
     sum(d_ES_Other_ECLK) as ES_Other_ECLK_cnt,
     sum(d_Retail_ECLK) as Retail_ECLK_cnt,
     sum(d_Lodging_ECLK) as Lodging_ECLK_cnt,
     sum(d_Restaurant_ECLK) as Restaurant_ECLK_cnt,
     sum(d_Car_Rental_ECLK) as Car_Rental_ECLK_cnt,
     sum(d_Airline_ECLK) as Airline_ECLK_cnt,
     sum(d_Trvl_Agncy_ECLK) as Trvl_Agncy_ECLK_cnt,
     sum(d_Web_Enroll_ECLK) as Web_Enroll_ECLK_cnt,
     sum(d_Pers_Savings_ECLK) as Pers_Savings_ECLK_cnt,
     sum(d_Mkt_Voice_ECLK) as Mkt_Voice_ECLK_cnt,
     sum(d_Mkt_Res_Surv_ECLK) as Mkt_Res_Surv_ECLK_cnt,
     sum(d_Circ_Mail_ECLK) as Circ_Mail_ECLK_cnt,
     sum(d_Ben_Reinforc_ECLK) as Ben_Reinforc_ECLK_cnt,
     sum(d_Prod_Usage_ECLK) as Prod_Usage_ECLK_cnt,
     sum(d_Travl_Offer_ECLK) as Travl_Offer_ECLK_cnt,
     sum(d_Card_Actvat_ECLK) as Card_Actvat_ECLK_cnt,
     sum(d_Trvl_Ben_Fin_ECLK) as Trvl_Ben_Fin_ECLK_cnt,

     sum(d_line_increase_ECLK)/count(d_chnl_email) as line_increase_ECLK_pct,
     sum(d_loan_on_chrg_ECLK)/count(d_chnl_email) as loan_on_chrg_ECLK_pct,
     sum(d_across_BU_ECLK)/count(d_chnl_email) as across_BU_ECLK_pct,
     sum(d_upgrade_ECLK)/count(d_chnl_email) as upgrade_ECLK_pct,
     sum(d_supp_ECLK)/count(d_chnl_email) as supp_ECLK_pct,
     sum(d_within_BU_ECLK)/count(d_chnl_email) as within_BU_ECLK_pct,
     sum(d_ES_Other_ECLK)/count(d_chnl_email) as ES_Other_ECLK_pct,
     sum(d_Retail_ECLK)/count(d_chnl_email) as Retail_ECLK_pct,
     sum(d_Lodging_ECLK)/count(d_chnl_email) as Lodging_ECLK_pct,
     sum(d_Restaurant_ECLK)/count(d_chnl_email) as Restaurant_ECLK_pct,
     sum(d_Car_Rental_ECLK)/count(d_chnl_email) as Car_Rental_ECLK_pct,
     sum(d_Airline_ECLK)/count(d_chnl_email) as Airline_ECLK_pct,
     sum(d_Trvl_Agncy_ECLK)/count(d_chnl_email) as Trvl_Agncy_ECLK_pct,
     sum(d_Web_Enroll_ECLK)/count(d_chnl_email) as Web_Enroll_ECLK_pct,
     sum(d_Pers_Savings_ECLK)/count(d_chnl_email) as Pers_Savings_ECLK_pct,
     sum(d_Mkt_Voice_ECLK)/count(d_chnl_email) as Mkt_Voice_ECLK_pct,
     sum(d_Mkt_Res_Surv_ECLK)/count(d_chnl_email) as Mkt_Res_Surv_ECLK_pct,
     sum(d_Circ_Mail_ECLK)/count(d_chnl_email) as Circ_Mail_ECLK_pct,
     sum(d_Ben_Reinforc_ECLK)/count(d_chnl_email) as Ben_Reinforc_ECLK_pct,
     sum(d_Prod_Usage_ECLK)/count(d_chnl_email) as Prod_Usage_ECLK_pct,
     sum(d_Travl_Offer_ECLK)/count(d_chnl_email) as Travl_Offer_ECLK_pct,
     sum(d_Card_Actvat_ECLK)/count(d_chnl_email) as Card_Actvat_ECLK_pct,
     sum(d_Trvl_Ben_Fin_ECLK)/count(d_chnl_email) as Trvl_Ben_Fin_ECLK_pct,

     count(trans_dt) as numdlvdates
         
   from arec559.contact_subtyp_chnl
   group by cm11;
quit;


data arec559.contact_subtyp_chnl_Rollup;
	set contact_subtyp_chnl_Rollup;run;



/* merge with choice */
data choice_for_merge;
	set arec559.choice (keep=cm11 choice_dt choice_ind );
	run;

proc sql;
	create table contact_subtyp_chnl_Rollup2 as
   select *
   from  arec559.contact_subtyp_chnl_Rollup as a
   left join choice_for_merge as b
   on a.cm11=b.cm11;
quit;
   
data arec559.contact_subtyp_chnl_Rollup2;
	set contact_subtyp_chnl_Rollup2 ;run;

 





/* add temporal variables */

data choice_dt;
	set arec559.choice (keep=cm11 choice_dt choice_ind);
	format choice_dt mmddyy10.;
	if choice_ind="N" then date_nochoice=19966;
	else date_nochoice="";
	run;
data choice_dt2;
	set choice_dt (keep=cm11 date_nochoice);
	run;

proc sql;
	create table contact_subtyp_chnl_Rollup3 as
	select *
	from arec559.contact_subtyp_chnl_Rollup2 as a
	left join choice_dt2 as b
	on a.cm11=b.cm11;
	quit;


data arec559.contact_with_temporal2;
	set contact_subtyp_chnl_Rollup3;
	if choice_ind="Y" then days_between=intck("day",trans_dt,choice_dt);
	else if choice_ind="N" then days_between=intck("day",trans_dt,date_nochoice);
	if days_between<=180 then d_last6m=1; else d_last6m=0;
	if days_between<=90 then d_last90=1; else d_last90=0;
	if days_between<=30 then d_last30=1; else d_last30=0;
	if days_between<=10 then d_last10=1; else d_last10=0;
	if days_between<=7 then d_last7=1; else d_last7=0;
	if days_between<=3 then d_last3=1; else d_last3=0;
	run;

proc sql;
 create table contact_subtyp_chnl_Rollup4 as
   select * ,

   sum(d_last6m) as last6m_cnt,
   sum(d_last90) as last90_cnt,
   sum(d_last30) as last30_cnt,
   sum(d_last10) as last10_cnt,
   sum(d_last7) as last7_cnt,
   sum(d_last3) as last3_cnt,

   from arec559.contact_with_temporal2
   group by cm11;
quit;

/* save contact_subtyp_chnl_Rollup4 before quiting */
