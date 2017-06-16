PS_charge_con<- read.csv("/Users/asumi/Desktop/Rstudio/AREC559/PS_charge_con.csv")
library(gbm)
set.seed(3000)

#create dataframe with vars for GBM
PS_charge_con$setup_dt <- as.numeric(PS_charge_con$setup_dt)
myvars <- c("OPTOUT","credit_A","credit_B","credit_C","credit_D","credit_E","credit_F","Female","Male",
            "Member_rewards","age_18_24","age_25_30","age_31_35","age_36_40","age_41_50","age_51_60",
            "age_61_plus","fee_svc_count","myca_count","open","setup_dt")
PS_charge_conR <- PS_charge_con[myvars]
PS_charge_conR$setupsq <- (PS_charge_conR$setup_dt)^2

#Run gradian boosting method for logit model
start.PS_charge_con <-proc.time()
gbm.PS_charge_conR <-gbm(OPTOUT~credit_A+credit_B+credit_C+credit_D+credit_E+credit_F+Female+Male+
      Member_rewards+age_18_24+age_25_30+age_31_35+age_36_40+age_41_50+age_51_60+age_61_plus+
      fee_svc_count+myca_count+open+setup_dt+setupsq,data=PS_charge_conR,distribution = "bernoulli",
    n.trees=20000,shrinkage=0.001,interaction.depth=1,bag.fraction=0.5,train.fraction=1.0,cv.folds=5,
    n.minobsinnode=10,verbose=F)
finish.PS_charge_con <-proc.time()
elapsed.time.PS_charge_con <-finish.PS_charge_con-start.PS_charge_con
print(elapsed.time.PS_charge_con)

#Export dataframe to csv
p1<-predict(gbm.PS_charge_conR, type="response")
PS_charge_conR$Pscore<-p1
write.csv(PS_charge_conR, file="/Users/asumi/Desktop/Rstudio/AREC559/PS_charge_con_gbm.csv")

