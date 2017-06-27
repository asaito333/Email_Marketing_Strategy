# Email_Marketing_Strategy


Key business questions
---------------------------
1. What is the cost to American Express (AXP) of a Cardmembers' opt-out decision?
2. Can AXP influence a cardmembers' opt-out or opt-in decisions by understanding the key determinants of the decisions?

The values and numbers are not disclosed due to a nondisclosure agreement.

Analysis
-------------------------

### Segmentation
Business/Charge, Business/Lend, Consumer/Charge, and Consumer/Lend

### Propensity Score Matching
Propensity score from GBM


-> Macro is in file PSM(1)

```SAS
%include '/home/asaito10/AREC559_programs/PSMatching (1).sas';
%PSMatching(datatreatment = PS_charge_con_treatment, datacontrol = PS_charge_con_control, method = NN, 
	numberofcontrols = 1, caliper = , replacement = yes, out = matches);
  ```
### Difference in difference
after combining the treatment and control in one dataset, run differece-in-difference model to evaluate the treatment effect of opting out from email marketing.

```SAS
proc reg data=arec559.PS_charge_con_DiD;
	model spend=time choice interaction;
	run;
  ```
