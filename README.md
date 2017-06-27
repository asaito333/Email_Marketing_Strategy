# Email_Marketing_Strategy


Key business questions
---------------------------
1. What is the cost to American Express (AXP) of a Cardmembers' opt-out decision?
2. Can AXP influence a cardmembers' opt-out or opt-in decisions by understanding the key determinants of the decisions?

The values and numbers are not disclosed due to a nondisclosure agreement.

Analysis
-------------------------

### 1. Cost of opting out?

9 datasets are megerged based on cardmember ID, product Id, and other index variables. 

Cost is evaluated as a spending. To eliminate the seasonality of spending, we aggregated spend in each month to annual spend.

#### Segmentation
Cardmembers are segmented in 4 categories based on their card types: Business/Charge, Business/Lend, Consumer/Charge, and Consumer/Lend
```SAS
data arec559.segment_charge_con;
	set arec559.panel_lab2;
	where prod_pay_type_cd="CHARGE" and lob_cd^="OPEN";
	run;
```

#### Propensity Score Matching
Compute propensity score using gradient boosting
```R
gbm.PS_charge_conR <-gbm(OPTOUT~credit_A+credit_B+credit_C+credit_D+credit_E+credit_F+Female+Male+
      Member_rewards+age_18_24+age_25_30+age_31_35+age_36_40+age_41_50+age_51_60+age_61_plus+
      fee_svc_count+myca_count+open+setup_dt+setupsq,data=PS_charge_conR,distribution = "bernoulli",
    n.trees=20000,shrinkage=0.001,interaction.depth=1,bag.fraction=0.5,train.fraction=1.0,cv.folds=5,
    n.minobsinnode=10,verbose=F)
p1<-predict(gbm.PS_charge_conR, type="response")
```

Match the propensity score between treatment (people who made choice to opt out) and control (people who did not make choice on opting out).

[Matching Macro](https://github.com/asaito333/Email_Marketing_Strategy/blob/master/analysis/PSMatching%20(1).sas)

```SAS
%include '/home/asaito10/AREC559_programs/PSMatching (1).sas';
%PSMatching(datatreatment = PS_charge_con_treatment, datacontrol = PS_charge_con_control, method = NN, 
	numberofcontrols = 1, caliper = , replacement = yes, out = matches);
  ```
#### Difference in difference
After combining the treatment and control in one dataset, run differece-in-difference model to evaluate the treatment effect of opting out from email marketing. (time and choice are dummy variales, interaction = time * choice )

```SAS
proc reg data=arec559.PS_charge_con_DiD;
	model spend=time choice interaction;
	run;
  ```

#### Results
For consumers, there were significant treatment effect (A-B and C-D) on opting out. "Before/After" means before/after the cardmember opted out from email marketing. For the control group who did not change the email subscription, the Before is the first year and After is the second year of dataset which includes two years of spending information.

![slide1](https://user-images.githubusercontent.com/29264214/27613812-9710a81e-5b52-11e7-8da3-3404fa0f2873.jpg)


### 2. How to affect on opting-out decision?


