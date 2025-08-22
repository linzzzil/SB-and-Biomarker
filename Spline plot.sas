data main_v0_1;
set main_v0;
	if critval4d_v00 ^=1 then delete;
	log_cicp =	log (cicp_v00)	;
	log_tnt	=	log (tnt_v00)	;
	log_crp	=	log (crp_v00)	;
	log_nitro =	log (nitro_v00)	;
	log_bnp	=	log (probnp_v00)	;

run;

data main_v0_3;
set main_v0;
	if critval4d_v03 ^=1 then delete;
	log_cicp =	log (cicp_v03)	;
	log_tnt	=	log (tnt_v03)	;
	log_crp	=	log (crp_v03)	;
	log_nitro =	log (nitro_v03)	;
	log_bnp	=	log (probnp_v03)	;
run;

proc freq data = main_v0;
table critval4d_v03;
run;


ods select ANOVA ParameterEstimates SplineKnots;
/*At baseline, cross-sectional*/
/*cicp*/
proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_cicp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_cicp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_cicp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_cicp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
      xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

/*tnt*/
proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_tnt = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_tnt;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_tnt = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_tnt;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

/*crp*/
proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_crp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_crp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_crp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_crp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

/*nitro*/
proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_nitro = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_nitro;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_nitro = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_nitro;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;


/*bnp*/
proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_bnp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;

proc sort data=SplineOut out=SplineOutSorted;
   by ina_b1_awake_mean_v00;
run;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_bnp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;

proc glmselect data=main_v0_1;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_bnp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_bnp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
   xaxis label = "Total inactivity time, including sustainable inactivity bouts (hours/day)";
run;



/*Baseline SB and v3 Biomarkers*/
/*cicp*/
proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_cicp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_cicp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;

proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_cicp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_cicp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;

/*tnt*/
proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_tnt = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_tnt;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
run;

proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_tnt = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_tnt;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;

/*crp*/
proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_crp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_crp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
run;

proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_crp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_crp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;

/*nitro*/
proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_nitro = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_nitro;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(thickness=3 color=red);
run;

proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_nitro = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_nitro;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;


/*bnp*/
proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) ); /* new in SAS/STAT 15.1 (SAS 9.4M6)  */
   model log_bnp = spl / selection=none;       /* fit model by using spline effects */
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;

proc sort data=SplineOut out=SplineOutSorted;
   by ina_b1_awake_mean_v00;
run;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_bnp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;

proc glmselect data=main_v0_3;
   effect spl = spline(ina_b1_awake_mean_v00/ details naturalcubic basis=tpf(noint)
             knotmethod=percentilelist(5 25 50 75 95) );
	class sex origin smoke_s1;
	model log_bnp = spl age sex origin bmi_v00 smoke_s1 alcoholg_v00 bed_bedtime_mean_v00 mvpa_b1_daily_mean_v00 lpa_b1_daily_mean_v00/ selection=none;
   output out=SplineOut predicted=Fit;   /* output predicted values */
quit;
 
title "Restricted Cubic Spline Regression";
title2 "Five Knots Placed at Percentiles";
proc sgplot data=SplineOut noautolegend;
   scatter x=ina_b1_awake_mean_v00 y=log_bnp;
   loess x=ina_b1_awake_mean_v00 y=Fit / lineattrs=(color=red);
run;
