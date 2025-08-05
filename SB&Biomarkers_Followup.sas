libname pdm "C:\Users\Linzi\OneDrive - Emory\PREDIMED PLUS - AF\data";
libname pdm "C:\Users\lli256\OneDrive - Emory University\PREDIMED PLUS - AF\data";

data derived0;
	set pdm.derived_20221003v5;
run;

data merge00;
	set pdm.predi_merge_20221003v7;
	rename paciente = id;
run;

proc sort data = derived0;
	by id;
run;

proc sort data = merge00;
	by id;
run;

data merge0;
	merge derived0 merge00;
	by id;
run;

/*ods pdf file = "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\Programs\Variable_list.pdf";*/
/*proc contents data = merge0 varnum;*/
/*run;*/
/*ods pdf close;*/


data merge1;
	set merge0;
	biomiss = 0;
	accemiss = 0;
	array bio (15)
					probnp_v00
					probnp_v03
					probnp_v05
					tnt_v00
					tnt_v03
					tnt_v05
					crp_v00
					crp_v03
					crp_v05
					cicp_v00
					cicp_v03
					cicp_v05
					nitro_v00
					nitro_v03
					nitro_v05;
	array acce (7)
					critval4d_v00
					critval4d_v66
					critval4d_v01
					critval4d_v02
					critval4d_v03
					critval4d_v04
					critval4d_v05;
		do i = 1 to 7;
			if acce(i) = 0 then accemiss = accemiss +1;
		end;
		do j = 1 to 15;
			if bio(j) = . then biomiss = biomiss +1;
		end;
run;

data main_v0;
	set merge1;
	if afib_v0 = 1 then delete;
	if biomiss = 15 then delete;
run;


data main_v0_1;
set main_v0;
if critval4d_v00 ^=1 then delete;
acce_valid35 = 0;
array a(2) critval4d_v03 critval4d_v05;
do i = 1 to 2;
if a(i) = 1 then acce_valid35 = acce_valid35 + 1;
end;
run;

proc print data = main_v0_1;
var critval4d_v00 critval4d_v03 critval4d_v05 acce_valid35;
run;

data main_v0_2;
set main_v0_1;
if acce_valid35 = 0 then delete;
run;

proc freq data = main_v0_2;
table critval4d_v03*critval4d_v05/missing;
run;
proc freq data = main_v0_2;
table critval4d_v03 critval4d_v05;
run;

data main1_v0_long;
	set main_v0_2;

		array	cicp_	(3)	cicp_v00	cicp_v03	cicp_v05;
		array	tnt_	(3)	tnt_v00	tnt_v03	tnt_v05;
		array	crp_	(3)	crp_v00	crp_v03	crp_v05;
		array	nitro_	(3)	nitro_v00	nitro_v03	nitro_v05;
		array	bnp_	(3)	probnp_v00	probnp_v03	probnp_v05;

		array	bedtime_	(3)	bed_bedtime_mean_v00	bed_bedtime_mean_v03	bed_bedtime_mean_v05	;
		array	sib_bedtime_	(3)	sib_bedtime_mean_v00	sib_bedtime_mean_v03	sib_bedtime_mean_v05	;
		array	sib_awake_	(3)	sib_awake_mean_v00	sib_awake_mean_v03	sib_awake_mean_v05	;
		array	ina_	(3)	ina_b1_awake_mean_v00	ina_b1_awake_mean_v03	ina_b1_awake_mean_v05	;
		array	oina_	(3)	oina_b1_awake_mean_v00	oina_b1_awake_mean_v03	oina_b1_awake_mean_v05	;
		array	lpa_b1_	(3)	lpa_b1_daily_mean_v00	lpa_b1_daily_mean_v03	lpa_b1_daily_mean_v05	;
		array	mvpa_b1_	(3)	mvpa_b1_daily_mean_v00	mvpa_b1_daily_mean_v03	mvpa_b1_daily_mean_v05	;
		array	mvpa_b10_	(3)	mvpa_b10_daily_mean_v00	mvpa_b10_daily_mean_v03	mvpa_b10_daily_mean_v05	;
		array   acc_valid_  (3) critval4d_v00 critval4d_v03 critval4d_v05;


		array 	visit_   (3) (0 3 5);
		array	bmi_	(3)	bmi_v00	bmi_v03	bmi_v05;
		array	height_	(3)	height_v00	height_v03	height_v05;
		array	waist_	(3)	waist_v00	waist_v03	waist_v05;
		array	weight_	(3)	weight_v00	weight_v03	weight_v05;	
		array	sbp_	(3)	sbp_v00	sbp_v03	sbp_v05;
		array	dbp_	(3)	dbp_v00	dbp_v03	dbp_v05;
		array	htnmed_	(3)	htnmed_v00	htnmed_v03	htnmed_v05;
		array	lipidmed_	(3)	lipidmed_v00	lipidmed_v03	lipidmed_v05;
		array 	insulin_	(3)	insulinas_v00  insulinas_v03  insulinas_v05;
		array 	antidiabetic_ (3) inhi_alfa_glucosidasa_v00 inhi_alfa_glucosidasa_v03 inhi_alfa_glucosidasa_v05;
		array	tchol_	(3)	tchol_v00	tchol_v03	tchol_v05;
		array	trigly_	(3)	trigly_v00	trigly_v03	trigly_v05;
		array	hdl_	(3)	hdl_v00	hdl_v03	hdl_v05;
		array	ldl_cal_	(3)	ldl_calc_v00	ldl_calc_v03	ldl_calc_v05;
		array   smoke_  (3) smoke_s1 smoke_V03 smoke_v05;
		array	Medadh_	(3) p17_total_v00  p17_total_v03  p17_total_v05;
		array	mvpa_	(3) mvpa_metminwk_v00  mvpa_metminwk_v03  mvpa_metminwk_v05;
		array	tpa_	(3) tpa_metminwk_v00  tpa_metminwk_v03  tpa_metminwk_v05;
		array   creat_	(3) creat_v00 creat_v03 creat_v05;

		do i = 1 to 3;
			cicp	=	cicp_(i)	;
			tnt	=	tnt_(i)	;
			crp	=	crp_(i)	;
			nitro	=	nitro_(i)	;
			bnp	=	bnp_(i)	;

			bedtime	=	bedtime_(i)	;
			sib_bedtime	=	sib_bedtime_(i)	;
			sib_awake	=	sib_awake_(i)	;
			ina	=	ina_(i)	;
			oina	=	oina_(i)	;
			lpa_b1	=	lpa_b1_(i)	;
			mvpa_b1	=	mvpa_b1_(i)	;
			mvpa_b10	=	mvpa_b10_(i)	;
			acc_valid   =   acc_valid_(i) ;

			visit  = visit_(i);
			bmi = bmi_(i);
			height = height_(i);
			waist = waist_(i);
			weight = weight_(i);
			sbp = sbp_(i);
			dbp = dbp_(i);
			htnmed = htnmed_(i);
			lipidmed = lipidmed_(i);
			insulin = insulin_(i);
			antidiabetic = antidiabetic_(i);
			tchol = tchol_(i);
			trigly = trigly_(i);
			hdl = hdl_(i);
			ldl_cal = ldl_cal_(i);
			smoke = smoke_(i);
			medadh = medadh_(i);
			mvpa = mvpa_(i);
			tpa = tpa_(i);
			creat = creat_(i);
				output;
			end;
run;

proc format library = work;
value int
	1 = "Intervention"
	0 = "Control";
run;

data main1_v0_long2;
set main1_v0_long;
	log_cicp =	log (cicp)	;
	log_tnt	=	log (tnt)	;
	log_crp	=	log (crp)	;
	log_nitro =	log (nitro)	;
	log_bnp	=	log (bnp)	;

	if sex = 1 then do;
		k = 0.7;
		alpha = -0.241;
		min = min (creat/0.7, 1.0);
		max = max (creat/0.7, 1.0);
			end;
	else if sex = 0 then do;
		k = 0.9;
		alpha = -0.302;
		min = min (creat/0.9, 1.0);
		max = max (creat/0.9, 1.0);
			end;

format intervention int.;
run;

data main1_v0_long3;
	set main1_v0_long2;
	if sex = 1 then do;
	egfr = 142*(min**alpha)*(max**-1.200)*(0.9938**age)*1.012;
		end;
	else if sex = 0 then do;
	egfr = 142*(min**alpha)*(max**-1.200)*(0.9938**age);
		end;
run;

data main3_v0_long3_1;
	set main1_v0_long3;
	mvpa_b1_30min = mvpa_b1/30;
	lpa_b1_30min = lpa_b1*2;
	ina_30min = ina*2;
	bedtime_30min = bedtime*2;
	sib_awake_30min = sib_awake*2;
	sib_bedtime_30min = sib_bedtime*2;
	total_wear_30min = mvpa_b1_30min + lpa_b1_30min + ina_30min + bedtime_30min;

	mvpa_b1_v00_30min = mvpa_b1_daily_mean_v00/30;
	lpa_b1_v00_30min = lpa_b1_daily_mean_v00*2;
	ina_v00_30min = ina_b1_awake_mean_v00*2;
	bedtime_v00_30min = bed_bedtime_mean_v00*2;
	sib_bedtime_v00_30min = sib_bedtime_mean_v00*2;
	sib_awake_v00_30min = sib_awake_mean_v00*2;
	total_wear_v00_30min = mvpa_b1_v00_30min + lpa_b1_v00_30min + ina_v00_30min + bedtime_v00_30min;
	if age lt 65 then age_grp = 0;
	else if age ge 65 then age_grp = 1;

run;
proc freq data = main3_v0_long3_1;
tables age_grp;
where visit = 0;
run;


data main3_v0_long3;
set main3_v0_long3_1;
run;


/*Table 2 Cross-sectional at baseline isotemporal substitution*/
%macro SBBio(SB, biomarker);

%let SBvar = &SB;
%let bio = &biomarker;
agw
ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table2\Iso_FU\&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table2\&SBvar&Bio..xlsx";*/

proc glm data = main3_v0_long3;
	class sex;
	model &biomarker = age sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min total_wear_v00_30min/ solution clparm;
	where visit = 0;
run;

proc glm data = main3_v0_long3;
	class sex origin smoke_s1;
	model &biomarker = age sex origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min total_wear_v00_30min/ solution clparm;
	where visit = 0;
run;

proc glm data = main3_v0_long3;
	class sex origin smoke htnmed lipidmed diab_prev_s1 insulin;
	model &biomarker = age sex origin BMI smoke alcoholg_v00 SBP DBP hdl ldl_cal 
				htnmed lipidmed diab_prev_s1 insulin bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min total_wear_v00_30min / solution clparm;
	where visit = 0;
run;

ods excel close;

%mend;

%SBBio(ina, log_cicp);
%SBBio(ina, log_tnt);
%SBBio(ina, log_crp);
%SBBio(ina, log_nitro);
%SBBio(ina, log_bnp);


/*Table 4: Isotemporal substitution baseline actigtaphy and longitudinal biomarker*/
/*Final Report*/
%macro SBBio_long4(SB, biomarker);

%let SBvar = &SB;
%let bio = &biomarker;

ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Iso_FU\&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\v3\&SBvar&Bio..xlsx";*/

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex;
      model &biomarker = visit age sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

ods excel close;

***visit as continuous var***;
ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Iso_FU\cont_&SBvar&Bio..xlsx";

proc mixed data = main3_v0_long3;
      class id idcluster sex;
      model &biomarker = visit age sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

ods excel close;

%mend;

%SBBio_long4(ina_30min, log_cicp);
%SBBio_long4(ina_30min, log_tnt);
%SBBio_long4(ina_30min, log_crp);
%SBBio_long4(ina_30min, log_nitro);
%SBBio_long4(ina_30min, log_bnp);


	/*Stratified by SEX*/
%macro SBBio_long4(SB, biomarker);

%let SBvar = &SB;
%let bio = &biomarker;

ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\&SBvar&Bio..xlsx";*/

proc sort data = main3_v0_long3;
by sex;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0');
      model &biomarker = visit age bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') origin smoke_s1;
      model &biomarker = visit age origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;

run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;
run;

ods excel close;

***visit as continuous var***;
ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\cont_&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\cont_&SBvar&Bio..xlsx";*/


proc mixed data = main3_v0_long3;
      class id idcluster;
      model &biomarker = visit age bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;
run;

proc mixed data = main3_v0_long3;
      class id idcluster origin smoke_s1;
      model &biomarker = visit age origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;
run;

proc mixed data = main3_v0_long3;
      class id idcluster origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by sex;
run;

ods excel close;

%mend;

%SBBio_long4(ina_30min, log_cicp);
%SBBio_long4(ina_30min, log_tnt);
%SBBio_long4(ina_30min, log_crp);
%SBBio_long4(ina_30min, log_nitro);
%SBBio_long4(ina_30min, log_bnp);


		/*Test for interaction*/
%macro SBBio_int4(biomarker);

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex intervention;
      model &biomarker = visit age sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1 intervention;
      model &biomarker = visit age sex origin BMI_v03 smoke_s1 alcoholg_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1 htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 intervention;
      model &biomarker = visit age sex origin BMI_v03 smoke_s1 alcoholg_v03 SBP_v03 DBP_v03 hdl_v03 ldl_calc_v03 
					htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

%mend;

%SBBio_int4(log_cicp);
%SBBio_int4(log_tnt);
%SBBio_int4(log_crp);
%SBBio_int4(log_nitro);
%SBBio_int4(log_bnp);

%macro SBBio_int4cont(biomarker);

proc mixed data = main3_v0_long3;
      class id idcluster sex intervention;
      model &biomarker = visit age sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1 intervention;
      model &biomarker = visit age sex origin BMI_v03 smoke_s1 alcoholg_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1 htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 intervention;
      model &biomarker = visit age sex origin BMI_v03 smoke_s1 alcoholg_v03 SBP_v03 DBP_v03 hdl_v03 ldl_calc_v03 
					htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*sex lpa_b1_v00_30min*sex mvpa_b1_v00_30min*sex
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*sex lpa_b1_v00_30min*visit*sex mvpa_b1_v00_30min*visit*sex visit*sex total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

%mend;

%SBBio_int4cont(log_cicp);
%SBBio_int4cont(log_tnt);
%SBBio_int4cont(log_crp);
%SBBio_int4cont(log_nitro);
%SBBio_int4cont(log_bnp);



	/*Stratified by AGE*/
%macro SBBio_long4(SB, biomarker);

%let SBvar = &SB;
%let bio = &biomarker;

ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_age\&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\&SBvar&Bio..xlsx";*/

proc sort data = main3_v0_long3;
by age_grp;
run;

proc mixed data = main3_v0_long3;
      class id sex idcluster visit(ref = '0');
      model &biomarker = visit sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;
run;

proc mixed data = main3_v0_long3;
      class id sex idcluster visit(ref = '0') origin smoke_s1;
      model &biomarker = visit sex origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;

run;

proc mixed data = main3_v0_long3;
      class id sex idcluster visit(ref = '0') origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;
run;

ods excel close;

***visit as continuous var***;
ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_age\cont_&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\Stratified_sex\cont_&SBvar&Bio..xlsx";*/


proc mixed data = main3_v0_long3;
      class id sex idcluster;
      model &biomarker = visit sex bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;
run;

proc mixed data = main3_v0_long3;
      class id sex idcluster origin smoke_s1;
      model &biomarker = visit sex origin BMI_v00 smoke_s1 alcoholg_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;
run;

proc mixed data = main3_v0_long3;
      class id sex idcluster origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
	by age_grp;
run;

ods excel close;

%mend;

%SBBio_long4(ina_30min, log_cicp);
%SBBio_long4(ina_30min, log_tnt);
%SBBio_long4(ina_30min, log_crp);
%SBBio_long4(ina_30min, log_nitro);
%SBBio_long4(ina_30min, log_bnp);

		/*Test for interaction*/
%macro SBBio_int4(biomarker);

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') age_grp sex intervention;
      model &biomarker = visit sex age_grp bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') age_grp sex origin smoke_s1 intervention;
      model &biomarker = visit sex age_grp origin BMI_v03 smoke_s1 alcoholg_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') age_grp sex origin smoke_s1 htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 intervention;
      model &biomarker = visit sex age_grp origin BMI_v03 smoke_s1 alcoholg_v03 SBP_v03 DBP_v03 hdl_v03 ldl_calc_v03 
					htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

%mend;

%SBBio_int4(log_cicp);
%SBBio_int4(log_tnt);
%SBBio_int4(log_crp);
%SBBio_int4(log_nitro);
%SBBio_int4(log_bnp);

%macro SBBio_int4cont(biomarker);

proc mixed data = main3_v0_long3;
      class id idcluster age_grp sex intervention;
      model &biomarker = visit age_grp bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster age_grp sex origin smoke_s1 intervention;
      model &biomarker = visit age_grp origin BMI_v03 smoke_s1 alcoholg_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster age_grp sex origin smoke_s1 htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 intervention;
      model &biomarker = visit age_grp origin BMI_v03 smoke_s1 alcoholg_v03 SBP_v03 DBP_v03 hdl_v03 ldl_calc_v03 
					htnmed_v03 lipidmed_v03 diab_prev_s1 insulinas_v03 bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min bedtime_v00_30min*age_grp lpa_b1_v00_30min*age_grp mvpa_b1_v00_30min*age_grp
	  					bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit
						bedtime_v00_30min*visit*age_grp lpa_b1_v00_30min*visit*age_grp mvpa_b1_v00_30min*visit*age_grp visit*age_grp total_wear_v00_30min intervention/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

%mend;

%SBBio_int4cont(log_cicp);
%SBBio_int4cont(log_tnt);
%SBBio_int4cont(log_crp);
%SBBio_int4cont(log_nitro);
%SBBio_int4cont(log_bnp);





/*****************************
Trajectory Analysis
*****************************/
data traj1;
set main_v0_2;

		array	biomarkers	(15)		
			cicp_v00	cicp_v03	cicp_v05
			tnt_v00	tnt_v03	tnt_v05
			crp_v00	crp_v03	crp_v05
			nitro_v00	nitro_v03	nitro_v05
			probnp_v00	probnp_v03	probnp_v05;
		array log_bio (15)
			log_cicp_v00	log_cicp_v03	log_cicp_v05
			log_tnt_v00	log_tnt_v03	log_tnt_v05
			log_crp_v00	log_crp_v03	log_crp_v05
			log_nitro_v00	log_nitro_v03	log_nitro_v05
			log_probnp_v00	log_probnp_v03	log_probnp_v05;

		do i  = 1 to 15;
			log_bio(i) = log(biomarkers(i));
		end;
		drop i;
run;

data traj2;
set traj1;
visit_v00 = 0;
visit_v66 = 0.5;
visit_v01 = 1;
visit_v02 = 2;
visit_v03 = 3;
visit_v05 = 5;
run;

PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=cicp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR cicp_v00 cicp_v03 cicp_v05; 
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 1000;
NGROUPS 3;  
ORDER 2 2 2;
RUN;

%TRAJPLOT(OP,OS,'PICP trajectory',,'PICP','visit')
proc freq data=cicp_group; tables group; run;


PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=tnt_group OUTEST=OE ITDETAIL;
ID ID; 
VAR tnt_v00	tnt_v03	tnt_v05; 
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 1000;
NGROUPS 3;  
ORDER 2 2 2;
RUN;

%TRAJPLOT(OP,OS,'hsTnT trajectory',,'hsTnT','visit')

proc freq data=tnt_group; tables group; run;


PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=crp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR crp_v00	crp_v03	crp_v05;
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 1000;
NGROUPS 3;  
ORDER 2 2 2;
RUN;

%TRAJPLOT(OP,OS,'hsCRP trajectory',,'hsCRP','visit')

proc freq data=crp_group; tables group; run;


PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=nitro_group OUTEST=OE ITDETAIL;
ID ID; 
VAR nitro_v00	nitro_v03	nitro_v05; 
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 11000;
NGROUPS 3;  
ORDER 2 2 2;
RUN;

%TRAJPLOT(OP,OS,'3NT trajectory',,'3NT','visit')

PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=probnp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR probnp_v00	probnp_v03	probnp_v05;
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 1000;
NGROUPS 2;  
ORDER 3 3;
RUN;

%TRAJPLOT(OP,OS,'NT-proBNP trajectory',,'NT-proBNP','visit')
proc freq data=probnp_group; tables group; run;


/*traj of sendentary behavior*/
PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=probnp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR ina_b1_awake_mean_v00 ina_b1_awake_mean_v66 ina_b1_awake_mean_v01; 
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 20;
NGROUPS 3;  
ORDER 2 2 2;
RUN;
%TRAJPLOT(OP,OS,'ina trajectory',,'ina','visit')

PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=probnp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR ina_b1_awake_mean_v00 ina_b1_awake_mean_v66 ina_b1_awake_mean_v01 ina_b1_awake_mean_v02 ina_b1_awake_mean_v05; 
INDEP visit_v00 visit_v66 visit_v01 visit_v02 visit_v05;
MODEL CNORM;  
MAX 20;
NGROUPS 3;  
ORDER 2 2 2;
RUN;
%TRAJPLOT(OP,OS,'ina trajectory',,'ina','visit')

PROC TRAJ DATA=traj2 OUTPLOT=OP OUTSTAT=OS OUT=probnp_group OUTEST=OE ITDETAIL;
ID ID; 
VAR ina_b1_awake_mean_v00 ina_b1_awake_mean_v03 ina_b1_awake_mean_v05; 
INDEP visit_v00 visit_v03 visit_v05;
MODEL CNORM;  
MAX 20;
NGROUPS 3;  
ORDER 2 2 2;
RUN;
%TRAJPLOT(OP,OS,'ina trajectory',,'ina','visit')



proc means data = traj2 mean max;
var ina_b1_awake_mean_v00 ina_b1_awake_mean_v66 ina_b1_awake_mean_v01;
run;

/***********************************************
Sensitivity Analysis
longitudinal isotemporal 
baseline SB and biomarkers over 5 years using 
sleep time (excluding short wake periods)
Final Report
***********************************************/

%macro SBBio_sens(SB, biomarker);

%let SBvar = &SB;
%let bio = &biomarker;

ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\SensitivityAnalysis\&SBvar&Bio..xlsx";
/*ods excel file =  "C:\Users\Linzi\OneDrive - Emory\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\v3\&SBvar&Bio..xlsx";*/

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex;
      model &biomarker = visit age sex sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster visit(ref = '0') sex origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

ods excel close;

***visit as continuous var***;
ods excel file = "C:\Users\lli256\OneDrive - Emory University\PROJECTS\PREDIMED-Plus\Sedentary behavior and Biomarkers\3_Results\Table4\SensitivityAnalysis\cont_&SBvar&Bio..xlsx";

proc mixed data = main3_v0_long3;
      class id idcluster sex;
      model &biomarker = visit age sex sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

proc mixed data = main3_v0_long3;
      class id idcluster sex origin smoke_s1 htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00;
      model &biomarker = visit age sex origin BMI_v00 smoke_s1 alcoholg_v00 SBP_v00 DBP_v00 hdl_v00 ldl_calc_v00 
				htnmed_v00 lipidmed_v00 diab_prev_s1 insulinas_v00 sib_bedtime_v00_30min lpa_b1_v00_30min mvpa_b1_v00_30min 
						sib_bedtime_v00_30min*visit lpa_b1_v00_30min*visit mvpa_b1_v00_30min*visit total_wear_v00_30min/ solution cl;
        random intercept / type = un subject = id;
        random intercept / type = un subject = idcluster;
run;

ods excel close;

%mend;

%SBBio_sens(ina_30min, log_cicp);
%SBBio_sens(ina_30min, log_tnt);
%SBBio_sens(ina_30min, log_crp);
%SBBio_sens(ina_30min, log_nitro);
%SBBio_sens(ina_30min, log_bnp);
