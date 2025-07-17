
************************************************************************;
* GOGO PP BP trajectories preliminary models
* Goal - fit trajectoy models with binary HTN as outcome
* Created 9.19.2023
* Programmer: Kait Stanhope (kaitlyn.keirsey.stanhope@emory.edu)
* Modified: October 2023, Meredith Dixon (meredith.a.dixon@emory.edu)
************************************************************************; 

libname b "C:\Users\madixon\iCloudDrive\Documents\Meredith\Graduate School\PhD\Project with Kait and Sheree"; 
libname b "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\2_Programs\Trajectory analysis_Meredith";


*Steps (Arrandale): 1. Decide on the maximuum number of groups using a priori knowledge
2. Fit number groups, starting with 1 
	Compare across using BIC - look at change in BIC- see guidance on page 9 of arrandale,
can compare difference or Bayes Facotr (exponentiated difference)
3. Select the shape of the pattern for each group over time
4. Perform further modeling to include covariates or other outcomes
; 

*-------------------------------------------------*
* 			48 hour BP trajectories				  *
*-------------------------------------------------*;
*One group model, cubic; 
proc traj data=b.bp48wide_new outplot = OP outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 1; 
	order 3;
	
run; 
%TRAJPLOT(OP,'Hypertension over time','Hypertension over Time','Predicted Probability')

*2 group model, cubic; 
proc traj data=b.bp48wide_new outplot = OP2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 2; 
	order 3 3;
	
run; 
%TRAJPLOT(OP2,'Hypertension over time','Hypertension over Time','Predicted Probability')

*3 group model, cubic; 
proc traj data=b.bp48wide_new outplot = OP3 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 3; 
	order 3 3 3;
	
run; 
%TRAJPLOT(OP3,'Hypertension over time','Hypertension over Time','Predicted Probability')

*4 group model, cubic; 
proc traj data=b.bp48wide_new outplot = OP4 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 4; 
	order 3 3 3 3;
	
run; 
%TRAJPLOT(OP4,'Hypertension over time','Hypertension over Time','Predicted Probability')

*5 group model, cubic; 
proc traj data=b.bp48wide_new outplot = OP5 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 5; 
	order 3 3 3 3 3;
	
run; 
%TRAJPLOT(OP5,'Hypertension over time','Hypertension over Time','Predicted Probability')

*1 group model, quadratic; 
proc traj data=b.bp48wide_new outplot = OP1_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 1; 
	order 2;
	
run; 
%TRAJPLOT(OP1_2,'Hypertension over time','Hypertension over Time','Predicted Probability')

*2 group model, quadratic; 
proc traj data=b.bp48wide_new outplot = OP2_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 2; 
	order 2 2;
	
run; 
%TRAJPLOT(OP2_2,'Hypertension over time','Hypertension over Time','Predicted Probability')

*3 group model, quadratic; 
proc traj data=b.bp48wide_new outplot = OP3_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 3; 
	order 2 2 2;
	
run; 
%TRAJPLOT(OP3_2,'Hypertension over time','Hypertension over Time','Predicted Probability')

*4 group model, quadratic; 
*multiple plots for figures;
proc traj data=b.bp48wide_new outplot = OP4_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 4; 
	order 2 2 2 2;
	
run; 
%TRAJPLOT(OP4_2,'Hypertension over time','Hypertension over Time','Predicted Probability')
%TRAJPLOT(OP4_2,OS,'Hypertension over time','4-group quadratic model','Predicted probability', 'Hours after delivery')
%TRAJPLOTNEW(OP4_2,OS,'Hypertension over time','4-group quadratic model','Predicted probability', 'Hours after delivery')


*the 4-group quadratic model is the one we want to use based on fit statistics;
data b.bp48_4groupquadratic;
	set OF;
run;

*5 group model, quadratic; 
proc traj data=b.bp48wide_new2 outplot = OP5_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_47;
	indep hour_0-hour_47; 
	model logit; 
	ngroups 5; 
	order 2 2 2 2 2;
	
run; 
%TRAJPLOT(OP5_2,'Hypertension over time','Hypertension over Time','Predicted Probability')


***Linear models;
*1 group model, linear; 
proc traj data=b.bp48wide_new outplot = OP1_1 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 1; 
	order 1;
	
run; 
%TRAJPLOT(OP1_1,'Hypertension over time','Hypertension over Time','Predicted Probability')

*2 group model, linear; 
proc traj data=b.bp48wide_new outplot = OP2_2 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 2; 
	order 1 1;
	
run; 
%TRAJPLOT(OP2_1,'Hypertension over time','Hypertension over Time','Predicted Probability')

*3 group model, linear; 
proc traj data=b.bp48wide_new outplot = OP3_1 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 3; 
	order 1 1 1;
	
run; 
%TRAJPLOT(OP3_1,'Hypertension over time','Hypertension over Time','Predicted Probability')

*4 group model, linear; 
proc traj data=b.bp48wide_new outplot = OP4_1 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 4; 
	order 1 1 1 1;
	
run; 
%TRAJPLOT(OP4_1,'Hypertension over time','Hypertension over Time','Predicted Probability')

*5 group model, linear; 
proc traj data=b.bp48wide_new outplot = OP5_1 outstat = OS out = OF outest = OE ;
	ID har_delivery_tid; 
	var hyp_0-hyp_48;
	indep hour_0-hour_48; 
	model logit; 
	ngroups 5; 
	order 1 1 1 1 1;
	
run; 
%TRAJPLOT(OP5_1,'Hypertension over time','Hypertension over Time','Predicted Probability')
