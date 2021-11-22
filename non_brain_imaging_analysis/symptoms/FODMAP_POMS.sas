/*-------------------------------*/
/* IMPORT DATA FROM EXCEL FILE   */
/* USE THIS ONE - LAPTOP IMKE 	 */ 
/*-------------------------------*/
%let path=C:\Users\u0105426\Box Sync\Work\Studies\FODMAP fMRI study\Analysis\Questionnaires;
proc import
datafile="&path\POMS_scores_SAS.xlsx"
out=work.FODMAP_poms;
sheet="Sheet1";
run;


proc sort data=FODMAP_poms; 
by subject visit time; 
run; 


	data FODMAP_poms; 
	set FODMAP_poms; 
	if subject = "V-FOD-001" and visit = "SV3" then condition = "fructans"; 
	if subject = "V-FOD-001" and visit = "SV1" then condition = "glucose"; 
	if subject = "V-FOD-001" and visit = "SV2" then condition = "saline"; 

	if subject = "V-FOD-002" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-002" and visit = "SV2" then condition = "glucose"; 
	if subject = "V-FOD-002" and visit = "SV3" then condition = "fructans"; 

	if subject = "V-FOD-003" and visit = "SV1" then condition = "glucose"; 
	if subject = "V-FOD-003" and visit = "SV2" then condition = "fructans"; 
	if subject = "V-FOD-003" and visit = "SV3" then condition = "saline"; 

	if subject = "V-FOD-005" and visit = "SV1" then condition = "fructans"; 
	if subject = "V-FOD-005" and visit = "SV2" then condition = "saline"; 
	if subject = "V-FOD-005" and visit = "SV3" then condition = "glucose"; 

	if subject = "V-FOD-006" and visit = "SV1" then condition = "glucose"; 
	if subject = "V-FOD-006" and visit = "SV2" then condition = "saline"; 
	if subject = "V-FOD-006" and visit = "SV3" then condition = "fructans"; 

	if subject = "V-FOD-007" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-007" and visit = "SV2" then condition = "fructans"; 
	if subject = "V-FOD-007" and visit = "SV3" then condition = "glucose"; 

	if subject = "V-FOD-008" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-008" and visit = "SV2" then condition = "fructans"; 
	if subject = "V-FOD-008" and visit = "SV3" then condition = "glucose"; 

	if subject = "V-FOD-009" and visit = "SV1" then condition = "fructans"; 
	if subject = "V-FOD-009" and visit = "SV2" then condition = "saline"; 
	if subject = "V-FOD-009" and visit = "SV3" then condition = "glucose"; 

	if subject = "V-FOD-010" and visit = "SV1" then condition = "fructans"; 
	if subject = "V-FOD-010" and visit = "SV2" then condition = "glucose"; 
	if subject = "V-FOD-010" and visit = "SV3" then condition = "saline"; 

	if subject = "V-FOD-012" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-012" and visit = "SV2" then condition = "glucose"; 
	if subject = "V-FOD-012" and visit = "SV3" then condition = "fructans"; 

	if subject = "V-FOD-013" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-013" and visit = "SV2" then condition = "glucose"; 
	if subject = "V-FOD-013" and visit = "SV3" then condition = "fructans"; 

	if subject = "V-FOD-014" and visit = "SV1" then condition = "glucose"; 
	if subject = "V-FOD-014" and visit = "SV2" then condition = "fructans"; 
	if subject = "V-FOD-014" and visit = "SV3" then condition = "saline"; 

	if subject = "V-FOD-016" and visit = "SV1" then condition = "saline"; 
	if subject = "V-FOD-016" and visit = "SV2" then condition = "fructans"; 
	if subject = "V-FOD-016" and visit = "SV3" then condition = "glucose"; 

	if subject = "P-FOD-002" and visit = "SV1" then condition = "fructans"; 
	if subject = "P-FOD-002" and visit = "SV2" then condition = "saline"; 
	if subject = "P-FOD-002" and visit = "SV3" then condition = "glucose"; 

	if subject = "P-FOD-003" and visit = "SV1" then condition = "glucose"; 
	if subject = "P-FOD-003" and visit = "SV2" then condition = "saline"; 
	if subject = "P-FOD-003" and visit = "SV3" then condition = "fructans"; 

	if subject = "P-FOD-004" and visit = "SV1" then condition = "fructans"; 
	if subject = "P-FOD-004" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-004" and visit = "SV3" then condition = "saline"; 

	if subject = "P-FOD-005" and visit = "SV1" then condition = "saline"; 
	if subject = "P-FOD-005" and visit = "SV2" then condition = "fructans"; 
	if subject = "P-FOD-005" and visit = "SV3" then condition = "glucose"; 

	if subject = "P-FOD-006" and visit = "SV1" then condition = "saline"; 
	if subject = "P-FOD-006" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-006" and visit = "SV3" then condition = "fructans"; 

	if subject = "P-FOD-007" and visit = "SV1" then condition = "saline"; 
	if subject = "P-FOD-007" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-007" and visit = "SV3" then condition = "fructans"; 

	if subject = "P-FOD-008" and visit = "SV1" then condition = "saline"; 
	if subject = "P-FOD-008" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-008" and visit = "SV3" then condition = "fructans"; 

	if subject = "P-FOD-009" and visit = "SV1" then condition = "glucose"; 
	if subject = "P-FOD-009" and visit = "SV2" then condition = "fructans"; 
	if subject = "P-FOD-009" and visit = "SV3" then condition = "saline"; 

	if subject = "P-FOD-010" and visit = "SV1" then condition = "glucose"; 
	if subject = "P-FOD-010" and visit = "SV2" then condition = "saline"; 
	if subject = "P-FOD-010" and visit = "SV3" then condition = "fructans"; 

	if subject = "P-FOD-011" and visit = "SV1" then condition = "fructans"; 
	if subject = "P-FOD-011" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-011" and visit = "SV3" then condition = "saline"; 

	if subject = "P-FOD-012" and visit = "SV1" then condition = "saline"; 
	if subject = "P-FOD-012" and visit = "SV2" then condition = "fructans"; 
	if subject = "P-FOD-012" and visit = "SV3" then condition = "glucose"; 

	if subject = "P-FOD-013" and visit = "SV1" then condition = "fructans"; 
	if subject = "P-FOD-013" and visit = "SV2" then condition = "glucose"; 
	if subject = "P-FOD-013" and visit = "SV3" then condition = "saline"; 

	if subject = "P-FOD-014" and visit = "SV1" then condition = "glucose"; 
	if subject = "P-FOD-014" and visit = "SV2" then condition = "saline"; 
	if subject = "P-FOD-014" and visit = "SV3" then condition = "fructans"; 

	run; 


/* no need to calculate baseline. We miss some scores at baseline for some participants, 
	so better to analyse raw data instead of delta (other wise we have too many missing) */ 


/* to look at differences at baseline > analysis at time point 0 */ 

proc mixed data=FODMAP_poms;
where time = 0 ; 
class subject condition group visit;
model vigor = condition group condition*group visit / solution residual influence;
repeated condition / sub=subject type=cs group=group r rcorr;
lsmeans condition*group / slice=condition ; 
/*lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"HC: glucose vs saline" 0 0 1 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1 , 
"IBS: glucose vs saline" 0 0 0 1 0 -1 , 
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; */ 
run; 

/* ar(1) 578.0 
cs 576.7 
un 589.0 */ 




proc mixed data=FODMAP_poms;
where time = 0 ; 
class subject condition group visit;
model fear = condition group condition*group visit / solution residual influence;
repeated condition / sub=subject type=ar(1) group=group r rcorr;
lsmeans condition*group / slice=condition ; 
lsmestimate group "HC vs IBS" 1 -1 / divisor=1 adjust=bon stepdown;  
run; 

/* ar(1) 417.0 
cs 419.6 
un 424.4 */ 



proc mixed data=FODMAP_poms;
where time = 0 ; 
class subject condition group visit;
model anger = condition group condition*group visit / solution residual influence;
repeated condition / sub=subject type=cs group=group r rcorr;
lsmeans condition*group / slice=condition ; 
lsmestimate group "HC vs IBS" 1 -1 / divisor=1 adjust=bon stepdown;  
run; 
/* ar(1) 465.0 
cs 464.9 
un / */ 




proc mixed data=FODMAP_poms;
where time = 0 ; 
class subject condition group visit;
model depression = condition group condition*group visit / solution residual influence;
repeated condition / sub=subject type=cs group=group r rcorr;
lsmeans condition*group / slice=condition ; 
lsmestimate group "HC vs IBS" 1 -1 / divisor=1 adjust=bon stepdown;  
run; 
/* ar(1) 377.6 
cs 376.7 
un / */ 




proc mixed data=FODMAP_poms;
where time = 0 ; 
class subject condition group visit;
model fatigue = condition group condition*group visit / solution residual influence;
repeated condition / sub=subject type=cs group=group r rcorr;
lsmeans condition*group / slice=condition ; 
lsmestimate group "HC vs IBS" 1 -1 / divisor=1 adjust=bon stepdown;  
run; 
/* ar(1) 612.9 
cs 604.9 
un 612.4 */ 


proc univariate data=FODMAP_poms freq normal;
var fear anger vigor depression fatigue ;
histogram fear anger vigor depression fatigue / normal lognormal (theta=est) gamma (theta=est);
run;




/*-------*/ 

/* VIGOR */ 

/*-------*/ 



/* BOXCOX TRANSFORMATIONS */
		data FODMAP_poms;
		set FODMAP_poms;
		z=0;
		run;
		/* creates new variable z with only zeroes */

		proc transreg data=FODMAP_poms maxiter=0 nozeroconstant;;
		   model BoxCox(vigor/parameter=0) = identity(z);
		run;
		/* parameter needs to be changed if the minimum value of your variable is <0 to make all values positive */
		/* output gives you lambda parameter */

		data FODMAP_poms;
		set FODMAP_poms;
		bc_vigor = (vigor**0.75 -1)/0.75;
		run;
		/* formula bc_variable = ((variable + parameter)**lambda -1)/lambda */ 

		proc univariate data=FODMAP_poms freq;
		var vigor bc_vigor;
		histogram vigor bc_vigor / normal (mu=est sigma=est);
		run;
		/* check distribution of raw variable and transformed variable and compare */


proc mixed data=FODMAP_poms;
class subject condition group time visit;
model bc_vigor = condition group time condition*time condition*group group*time condition*group*time visit / solution residual influence;
repeated condition time / sub=subject type=un@ar(1) group=group r rcorr;
lsmeans condition*group*time / slice=condition slice=group slice=group*condition ; 
lsmeans condition*group / slice=condition ; 
lsmestimate group*time "baseline HC vs IBS" 1 0 0 0 0 0 -1 /divisor = 1 ; 
lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"HC: glucose vs saline" 0 0 1 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1 , 
"IBS: glucose vs saline" 0 0 0 1 0 -1 , 
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown;  
run; 




/*---------*/ 

/* FATIGUE */ 

/*---------*/ 



/* BOXCOX TRANSFORMATIONS */
		data FODMAP_poms;
		set FODMAP_poms;
		z=0;
		run;
		/* creates new variable z with only zeroes */

		proc transreg data=FODMAP_poms maxiter=0 nozeroconstant;;
		   model BoxCox(fatigue/parameter=0) = identity(z);
		run;
		/* parameter needs to be changed if the minimum value of your variable is <0 to make all values positive */
		/* output gives you lambda parameter */

		data FODMAP_poms;
		set FODMAP_poms;
		bc_fatigue = (fatigue**0.75 -1)/0.75;
		run;
		/* formula bc_variable = ((variable + parameter)**lambda -1)/lambda */ 

		proc univariate data=FODMAP_poms freq;
		var fatigue bc_fatigue;
		histogram fatigue bc_fatigue / normal (mu=est sigma=est);
		run;
		/* check distribution of raw variable and transformed variable and compare */


proc mixed data=FODMAP_poms;
class subject condition group time visit;
model bc_fatigue = condition group time condition*time condition*group group*time condition*group*time visit / solution residual influence;
repeated condition time / sub=subject type=un@ar(1) group=group r rcorr;
lsmeans condition*group*time / slice=condition slice=group slice=group*condition ; 
lsmeans condition*group / slice=condition ; 
lsmestimate group*time "baseline HC vs IBS" 1 0 0 0 0 0 -1 /divisor = 1 ; 
lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"HC: glucose vs saline" 0 0 1 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1 , 
"IBS: glucose vs saline" 0 0 0 1 0 -1 , 
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run; 




/*-------------------*/ 
/*

		GRAPHS 

 					 */
/*-------------------*/ 

	data FODMAP_poms; 
	set FODMAP_poms; 
	if group = "IBS" and condition = "fructans" than groupcon = "IBS - fructans" ; 
	if group = "IBS" and condition = "glucose" than groupcon = "IBS - glucose" ; 
	if group = "IBS" and condition = "saline" than groupcon = "IBS - saline" ; 
	if group = "HC" and condition = "fructans" than groupcon = "HC - fructans" ; 
	if group = "HC" and condition = "glucose" than groupcon = "HC - glucose" ; 
	if group = "HC" and condition = "saline" than groupcon = "HC - saline" ; 
	run; 





ods html close;
	ods listing gpath="C:\Users\u0105426\Box Sync\Work\Studies\FODMAP fMRI study\Analysis\SAS\GRAPHS\POMS" image_DPI=300; 
	ods graphics on / imagename="raw data_vigor" outputfmt=tiff noborder height=10cm  width=15cm ; 

	proc sgplot data=FODMAP_poms noborder nowall noautolegend ;
	styleattrs 	datacontrastcolors = (red VLIGB black red VLIGB black) 
	 			datacolors=(red VLIGB black red VLIGB black)  
	 			datalinepatterns=(solid solid solid shortdash shortdash shortdash) 
	 			datasymbols=(Diamondfilled Squarefilled Circlefilled 
	 					Trianglefilled) ;
	vline time / 	response=vigor stat=mean 
	 			markers markerattrs=(size=2) 
	 			limitstat = STDERR limits=upper 
	 			limitattrs=(pattern=solid thickness=1.5) nostatlabel 
	 			group=groupcon  ;
	xaxis 	valueattrs=(Color=Black Family=Arial Size=9 /*Style=Italic Weight=Bold */) valuesrotate=vertical
	 		max=0 min=60 type=discrete 
	 		label= " Time " labelpos=datacenter labelattrs=(Color=Black Family=Arial Size=10 /*Style=Italic */ Weight=Bold) ;
	yaxis 	valueattrs=(Color=Black Family=Arial Size=8) 
			label="Vigor" labelpos=datacenter labelattrs=(Color=Black Family=Arial Size=10 /* Style=Italic */ Weight=Bold) 
	 		max=80 min=0 type=linear;
	keylegend / title="" noborder down=3 location=outside position=top valueattrs=(Color=Black Family=Arial Size=10  Weight=Bold); 
	run;





ods html close;
	ods listing gpath="C:\Users\u0105426\Box Sync\Work\Studies\FODMAP fMRI study\Analysis\SAS\GRAPHS\POMS" image_DPI=300; 
	ods graphics on / imagename="raw data_fatigue" outputfmt=tiff noborder height=10cm  width=15cm ; 

	proc sgplot data=FODMAP_poms noborder nowall noautolegend ;
	styleattrs 	datacontrastcolors = (red VLIGB black red VLIGB black) 
	 			datacolors=(red VLIGB black red VLIGB black)  
	 			datalinepatterns=(solid solid solid shortdash shortdash shortdash) 
	 			datasymbols=(Diamondfilled Squarefilled Circlefilled 
	 					Trianglefilled) ;
	vline time / 	response=fatigue stat=mean 
	 			markers markerattrs=(size=2) 
	 			limitstat = STDERR limits=upper 
	 			limitattrs=(pattern=solid thickness=1.5) nostatlabel 
	 			group=groupcon  ;
	xaxis 	valueattrs=(Color=Black Family=Arial Size=9 /*Style=Italic Weight=Bold */) valuesrotate=vertical
	 		max=0 min=60 type=discrete 
	 		label= " Time " labelpos=datacenter labelattrs=(Color=Black Family=Arial Size=10 /*Style=Italic */ Weight=Bold) ;
	yaxis 	valueattrs=(Color=Black Family=Arial Size=8) 
			label="Fatigue" labelpos=datacenter labelattrs=(Color=Black Family=Arial Size=10 /* Style=Italic */ Weight=Bold) 
	 		max=60 min=0 type=linear;
	keylegend / title="" noborder down=3 location=outside position=top valueattrs=(Color=Black Family=Arial Size=10  Weight=Bold); 
	run;
