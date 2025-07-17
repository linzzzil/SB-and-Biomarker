*trajectory analysis for the CVD in AF 25 year project;


/* updated this code to send to Wendy for examples;  */ 





* Wendy, you can use the dataset I have below and just use the libnames to my test folder; 

libname lopez_f 'z:\lopez_f';
libname test 'Z:\LOPEZ_F\PUB_OR_DONE\CVD_25_FAYE'; 


** part 1; 
*Starting with everyone free of AF at visit 4 and follow forward for incident AF;
*compare measures from visit 1,2,3,4 in those with and w/o AF;
data three; ;  *this dataset contains 11,091 w/0 AF and have baseline bmi & sbp;
set test.cvd_traj; 

if missing(bmi01) = 0 and missing(bmi21) = 0  and missing(bmi32) = 0 and missing(bmi41) = 0;

if missing(sbp1) = 0 and missing(sbp2) = 0 and missing(sbp3) = 0 and missing(sbp4) = 0 ; 

run;   *10,559; 
*a constant of 10 has been added to sbp if they are on meds; 




*macro details;  
*var = variables;
*indep = time points;
*order (1=linear, 2=quad, 3=cubic);


/*   *testing to send to wendy; 
Wendy, this code uses the bmi values (as continuous variables) from the first 4 visits, and we are going to plot them 
against age.
Things you can change would be the 
NGROUPS (except for bmi, in which we probably want 4)
and "order" (see above for linear, quad and cubic). In the end, we want the model with the best fit, as determined 
by AIC / BIC values (which show up in the output). 
I messed around with these models quite a bit and remember that quadratic or cubic was almost always better fitting 
than linear. And, you'll see below that some had 4 groups and some had 5. We also tested a combination of 
quadratic and cubic within each model, but in the end, I think we decided to to just stick with one or the other
except below I see that we do have some models that have combinations of 0's, 2s and 3s within each model.
In the end, I don't think it matters too much
*/  


*example using 4 groups, quadratic, continuous BMI; 
title ' 4 groups, quad'; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=OF OUTEST=OE ITDETAIL;
ID ID; 
VAR  bmi01 bmi21 bmi32 bmi41; 
INDEP v1age01 v2age22 v3age31 v4age41;
model cnorm ; 
Max 100; 
NGROUPS 4;  
order 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'BMI traj',,'BMI','age')
* This one plots in order, from 1 at the bottom to 4 at the top, but 
you'll see sometimes these aren't always in order (1 might be in the middle and 3 at the bottom; 


* testing "trajplotnew"... ummm, it looks about the same, but i didn't read into it! ; 
%TRAJPLOTnew(OP,OS,'BMI traj',,'BMI','age')




/* Now I attempted to put a cubic function on what I thought were the middle 2 lines,
but it did not help much, and you can see from the graph that now group 2 is on the bottom. I think I figured out
what it was doing at some point, but I can not quite remember...you might want to look into it, but it's up to you. 
The model fit (AIC / BIC) barely changes. 
*/ 
title ' 4 groups, quad and cubic'; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=OF OUTEST=OE ITDETAIL;
ID ID; 
VAR  bmi01 bmi21 bmi32 bmi41; 
INDEP v1age01 v2age22 v3age31 v4age41;
model cnorm ; 
Max 100; 
NGROUPS 4; 
order 2 3 3 2; 
RUN;
%TRAJPLOT(OP,OS,'BMI traj',,'BMI','age')



/* example code using the logistic model for obesity (yes/no);
*/ 
*obesity, all; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=obesitygroup OUTEST=OE ITDETAIL;
ID ID; 
VAR obese1 obese2 obese3 obese4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 5; 
ORDER 2 2 2 2 0; 
RUN;
%TRAJPLOT(OP,OS,'Obese','Model','perc','age')
proc freq data=obesitygroup; tables group; run;
proc print data=op ; run;
***different reference group; 



/*I added the proc freq and proc print below 
most of the main code below. I think it was to get values to put into excel for the final figures*/  











*** i have not editing anything below: it is the code I used to create the trajectories and use for the paper*; 


***********************   testing code  ************************; 
*main code, cont testing; 
title ' 5 groups, quad'; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=OF OUTEST=OE ITDETAIL;
ID ID; 
VAR  bmi01 bmi21 bmi32 bmi41; 
INDEP v1age01 v2age22 v3age31 v4age41;
model cnorm ; 
Max 100; 
NGROUPS 5; 
order 2 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'BMI traj',,'BMI','age')


*main code, logit; 
title ' 5 groups, quad'; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=OF OUTEST=OE ITDETAIL;
ID ID; 
VAR obese1 obese2 obese3 obese4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 5; 
ORDER 2 2 2 2 0; 
RUN;
%TRAJPLOT(OP,OS,'Obese','Model','perc','age')

*to get dataset with specific values; 
proc print data=op ; run;

** dataset with group numbers is out=_____  ; 




***********************   code that went into CVD in 25 year follow-up / AF  ************************; 

* bmi, all, testing;
title ' 5 groups, quad'; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=bmigroup OUTEST=OE ITDETAIL;
ID ID; 
VAR  bmi01 bmi21 bmi32 bmi41; 
INDEP v1age01 v2age22 v3age31 v4age41;
model cnorm ; 
Max 100; 
NGROUPS 5; 
order 2 2 2 2 3 ; 
RUN;
%TRAJPLOT(OP,OS,'BMI traj',,'BMI','age')

proc freq data=bmigroup; tables group; run;
proc print data=op ; run;
*1 is ref group;


*obesity, all; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=obesitygroup OUTEST=OE ITDETAIL;
ID ID; 
VAR obese1 obese2 obese3 obese4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 5; 
ORDER 2 2 2 2 0; 
RUN;
%TRAJPLOT(OP,OS,'Obese','Model','perc','age')
proc freq data=obesitygroup; tables group; run;
proc print data=op ; run;
***different reference group; 


*htn, all;
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=htngroup OUTEST=OE ITDETAIL;
ID ID; 
VAR htnv1 htnv2 htnv3 htnv4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 4; 
ORDER 3 3 3 2; 
RUN;
%TRAJPLOT(OP,OS,'HTN','Model','perc','age')
proc freq data=htngroup; tables group; run;
proc print data=op ; run;
proc means data=htngroup maxdec=2 mean; class group; var grp1prb grp2prb grp3prb grp4prb ; run;



*sbp;
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=sbpgroup OUTEST=OE ITDETAIL;
ID ID; 
VAR  sbp1 sbp2 sbp3 sbp4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model cnorm ; 
Max 300; 
NGROUPS 5; 
ORDER  2 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'sbp','Model','sbp','age')
proc print data=op ; run;
proc freq data=sbpgroup; tables group; run;

** this will give me the final mean probability for each group membership; 
proc means data=sbpgroup maxdec=2 mean; class group; var grp1prb grp2prb grp3prb grp4prb grp5prb; run;


*smoking;
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=ciggroup OUTEST=OE ITDETAIL;
ID ID; 
VAR cig1 cig2 cig3 cig4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 4; 
ORDER 3 3 3 3; 
RUN;
%TRAJPLOT(OP,OS,'smoking','Model','smoking','age')
proc print data=op ; run;
proc freq data=ciggroup; tables group; run;


*diabetes;
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=diabgroup OUTEST=OE ITDETAIL;
ID ID; 
VAR diabv1 diabv2 diabv3 diabv4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 5; 
ORDER 3 3 3 3 3; 
RUN;
%TRAJPLOT(OP,OS,'Diabetes','Model','Diabetes','age')
proc print data=op ; run;
proc freq data=diabgroup; tables group; run;



*hf; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=hfgroup OUTEST=OE ITDETAIL;
ID ID; 
VAR prevhf01 hfprev2 hfprev3 hfprev4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 4; 
ORDER 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'HF','Model','HF','age')
proc print data=op ; run;
proc freq data=hfgroup; tables group; run;


*mi; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=migroup OUTEST=OE ITDETAIL;
ID ID; 
VAR prevmi05 miprev2 miprev3 miprev4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 4; 
ORDER 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'MI','Model','MI','age')
proc print data=op ; run;
proc freq data=migroup; tables group; run;
proc means data=strgroup maxdec=2 mean; class group; var grp1prb grp2prb grp3prb grp4prb grp5prb; run;




*stroke ; 
PROC TRAJ DATA=three OUTPLOT=OP OUTSTAT=OS OUT=strgroup OUTEST=OE ITDETAIL;
ID ID; 
VAR stroke1 stroke2 stroke3 stroke4; 
INDEP v1age01 v2age22 v3age31 v4age41;
model logit ; 
NGROUPS 5; 
ORDER 2 2 2 2 2; 
RUN;
%TRAJPLOT(OP,OS,'Stroke','Model','Stroke','age')
proc print data=op ; run;
proc freq data=strgroup; tables group; run;
**1 and 2 are ref, 3-5 other; 
** this will give me the final mean probability for each group membership; 
proc means data=strgroup maxdec=2 mean; class group; var grp1prb grp2prb grp3prb grp4prb grp5prb; run;





* bmi41, obese1-4, sbp1-4, htnv1-4, cig1-4, diabv1-4, hfprev4, miprev4, stroke4 ;



***** setting groups and reordering as needed; *1-5 with 1 as ref unless noted; 
data bmi; set bmigroup; bmiclass=group; keep id bmiclass; run;
data obese; set obesitygroup; 
	if group=2 then obclass=1; else if group=3 then obclass=2; else if group=1 then obclass=3;
	else if group=4 then obclass=4; else if group=5 then obclass=5;
keep id obclass; run;
run;
data htn; set htngroup; htnclass=group; keep id htnclass; run; *1-4; 
data sbp; set sbpgroup; sbpclass=group; keep id sbpclass; run;
data cig; set ciggroup; 
	if group=2 then cigclass=1; else if group=1 then cigclass=2; else cigclass=group; 
keep id cigclass; run;  *1-4;
data diab; set diabgroup;
	if group in (1 2) then diabclass=1; else diabclass=group-1; 
keep id diabclass; run;  *changing to 4; 
data hf; set hfgroup;
	if group=3 then hfclass=1; else if group=2 then hfclass=2; else if group=1 then hfclass=3; else if group=4 then hfclass=4; 
keep id hfclass;
run; *1-4; 
data mi; set migroup;
	if group=3 then miclass=1; else if group=1 then miclass=2; else if group=2 then miclass=3; else miclass=4;
keep id miclass; 
run; *1-4; 
data stroke1; set strgroup;
	if group in (1 2) then strclass=1; else strclass=group-1; 
keep id strclass; run;  *changing to 4; 


proc sort data=three; by id; run;
proc sort data=bmi; by id; run;
proc sort data=obese; by id; run;
proc sort data=htn; by id; run;
proc sort data=sbp; by id; run;
proc sort data=cig; by id; run;
proc sort data=diab; by id; run;
proc sort data=hf; by id; run;
proc sort data=mi; by id; run;
proc sort data=stroke1; by id; run;
data lopez_f.cvd_traj_all; 
	merge three bmi obese htn sbp cig diab hf mi stroke1 ; 
by id; 
run;






*/ 


****** analysis; 
*bmiclass, obclass, sbpclass htnclass, cigclass, diabclass, hfclass, miclass, strclass; 
data all; 
	set lopez_f.cvd_traj_all; 
v45ttafy=v45ttaf/365.25;
if missing(hypert45) then hypert45=0;
if missing(diabts42) then diabts42=0; 
run;
proc univariate data=all; var v45ttafy; run;

**** bmi; 
proc freq data=all; tables afprev5*bmiclass; run;
*model 1;
proc phreg data=all;
class bmiclass(desc);
	model v45ttaf*afprev5(0) = bmiclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class bmiclass(desc);
	model v45ttaf*afprev5(0) = bmiclass v4age41 male black 
								cig4 diabts42 hypert45 hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;
proc phreg data=all;
class bmiclass(desc);
	model v45ttaf*afprev5(0) = bmiclass v4age41 male black 
								cig4 diabts42 hypert45 hfprev4 miprev4 stroke4 bmi41/ rl;
	title 'model 3';
run;


**** obese; 
proc freq data=all; tables afprev5*obclass; run;
*model 1;
proc phreg data=all;
class obclass(desc);
	model v45ttaf*afprev5(0) = obclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class obclass(desc);
	model v45ttaf*afprev5(0) = obclass v4age41 male black 
								cig4 diabts42 hypert45 hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;
proc phreg data=all;
class obclass(desc);
	model v45ttaf*afprev5(0) = obclass v4age41 male black 
								cig4 diabts42 hypert45 hfprev4 miprev4 stroke4 bmi41/ rl;
	title 'model 3';
run;


**** sbp; 
proc freq data=all; tables afprev5*sbpclass; run;
*model 1;
proc phreg data=all;
class sbpclass(desc);
	model v45ttaf*afprev5(0) = sbpclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class sbpclass(desc);
	model v45ttaf*afprev5(0) = sbpclass v4age41 male black   bmi41
								cig4 diabts42       hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;
proc phreg data=all;
class sbpclass(desc);
	model v45ttaf*afprev5(0) = sbpclass v4age41 male black   bmi41
								cig4 diabts42        hfprev4 miprev4 stroke4 sbp4/ rl;
	title 'model 3';
run;


****htnclass; 
proc freq data=all; tables afprev5*htnclass; run;
*model 1;
proc phreg data=all;
class htnclass(desc);
	model v45ttaf*afprev5(0) = htnclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class htnclass(desc);
	model v45ttaf*afprev5(0) = htnclass v4age41 male black   bmi41
								cig4 diabts42       hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;
proc phreg data=all;
class htnclass(desc);
	model v45ttaf*afprev5(0) = htnclass v4age41 male black   bmi41
								cig4 diabts42        hfprev4 miprev4 stroke4 sbp4/ rl;
	title 'model 3';
run;


****cigclass; 
proc freq data=all; tables afprev5*cigclass; run;
*model 1;
proc phreg data=all;
class cigclass(desc);
	model v45ttaf*afprev5(0) = cigclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class cigclass(desc);
	model v45ttaf*afprev5(0) = cigclass v4age41 male black   bmi41
								        diabts42 hypert45  hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;
proc phreg data=all;
class cigclass(desc);
	model v45ttaf*afprev5(0) = cigclass v4age41 male black   bmi41
								        diabts42 hypert45 hfprev4 miprev4 stroke4 cig4/ rl;
	title 'model 3';
run;



***diabclass; 
proc freq data=all; tables afprev5*diabclass; run;
*model 1;
proc phreg data=all;
class diabclass(desc);
	model v45ttaf*afprev5(0) = diabclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class diabclass(desc);
	model v45ttaf*afprev5(0) = diabclass v4age41 male black   bmi41
								cig4     hypert45  hfprev4 miprev4 stroke4/ rl;
	title 'model 2';
run;


***hfclass; 
proc freq data=all; tables afprev5*hfclass; run;
*model 1;
proc phreg data=all;
class hfclass(desc);
	model v45ttaf*afprev5(0) = hfclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class hfclass(desc);
	model v45ttaf*afprev5(0) = hfclass v4age41 male black   bmi41
								cig4   diabts42  hypert45     miprev4 stroke4/ rl;
	title 'model 2';
run;


***miclass; 
proc freq data=all; tables afprev5*miclass; run;
*model 1;
proc phreg data=all;
class miclass(desc);
	model v45ttaf*afprev5(0) = miclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class miclass(desc);
	model v45ttaf*afprev5(0) = miclass v4age41 male black   bmi41
								cig4   diabts42  hypert45   hfprev4 stroke4/ rl;
	title 'model 2';
run;


*strclass;
proc freq data=all; tables afprev5*strclass; run;
*model 1;
proc phreg data=all;
class strclass(desc);
	model v45ttaf*afprev5(0) = strclass v4age41 male black / rl;
	title 'model 1';
run;
proc phreg data=all;
class strclass(desc);
	model v45ttaf*afprev5(0) = strclass v4age41 male black   bmi41
								cig4   diabts42  hypert45   hfprev4 miprev4    / rl;
	title 'model 2';
run;
