%let path=D:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_data_ROI_UEG.xlsx"
out=work.FODMAP_abdomen;
sheet="UEG";
run;

data FODMAP_abdomen; 
set FODMAP_abdomen; 
if ibs="1" then group="IBS"; 
if ibs="0" then group="HC"; 
run; 

proc sort data=FODMAP_abdomen; 
by subID	condition group  visitNo	timePoint; 
run; 

/* distribution of data */ 
	proc univariate data=FODMAP_abdomen freq normal;
	var VolOuter_cm3m VolGas_cm3m b_VolOuter_cm3m b_VolGas_cm3m;   /*these are all main variables Heather indicated */ 
	histogram VolOuter_cm3m VolGas_cm3m b_VolOuter_cm3m b_VolGas_cm3m / normal lognormal (theta=est) gamma (theta=est);
	run;

data FODMAP_abdomen; 
set FODMAP_abdomen; 
log_VolOuter_cm3m = log(VolOuter_cm3m); 
log_VolGas_cm3m = log(VolGas_cm3m); 
log_b_VolGas_cm3m = log(b_VolGas_cm3m); 
run; 

/* check distribution of log values */ 

	proc univariate data=FODMAP_abdomen freq normal;
	var log_VolOuter_cm3m	log_VolGas_cm3m log_b_VolGas_cm3m;   
	histogram log_VolOuter_cm3m	log_VolGas_cm3m log_b_VolGas_cm3m / normal lognormal (theta=est) gamma (theta=est);
	run;

/* baseline volume of gas */ 
	proc mixed data=FODMAP_abdomen;
   where  timePoint="T0";
	class subID condition group visitNo;
	model log_b_VolGas_cm3m = condition group condition*group visitno / solution residual influence;
	repeated condition / sub=subID type=cs  r rcorr;
	lsmeans condition / diff=all; 
	lsmeans group / diff=all;
	lsmeans condition*group / slice=condition slice=group diff=all adjust=bon; 
	run; 

/* baseline volume ascending colon */ 
	proc mixed data=FODMAP_abdomen;
    where  timePoint="T0";
	class subID condition group visitNo;
	model b_VolOuter_cm3m = condition group condition*group visitno / solution residual influence;
	repeated condition / sub=subID type=cs  r rcorr;
	lsmeans condition / diff=all; 
	lsmeans group / diff=all;
	lsmeans condition*group / slice=condition slice=group diff=all adjust=bon; 
	run;

/* considering the baseline differences in signal intensity and volumes of gas, it is better to work with delta values */ 

/* distribution of data */ 

	proc univariate data=FODMAP_abdomen freq normal;
	where timepoint NE "T0"; 
	var d_VolOuter_cm3m d_VolGas_cm3m;   
	histogram d_VolOuter_cm3m d_VolGas_cm3m / normal lognormal (theta=est) gamma (theta=est);
	run;



/* transformations */ 
	data FODMAP_abdomen; 
	set FODMAP_abdomen; 
	log_d_VolOuter_cm3m = log(d_VolOuter_cm3m);
	log_d_VolGas_cm3m = log(d_VolGas_cm3m);  
	run; 

/* check distribution of log delta values */ 
	proc univariate data=FODMAP_abdomen freq normal;
	where timePoint NE "T0"; 
	var log_d_VolOuter_cm3m log_d_VolGas_cm3m;   /*these are all main variables Heather indicated */ 
	histogram log_d_VolOuter_cm3m  log_d_VolGas_cm3m / normal lognormal (theta=est) gamma (theta=est);
	run;


/* check baseline of age and BMI*/

PROC TTEST data=FODMAP_abdomen sides=2 alpha=0.05; 
where condition="fructans" and timepoint="T0";
class group ; 
var age ;
run;



	




/* Delta VOLUME ASCENDING COLON */ 
	proc mixed data=FODMAP_abdomen;
	where timePoint NE "T0" ;
	class subID visitNo condition group timepoint;
	model log_d_VolOuter_cm3m = condition group timepoint condition*group condition*timepoint group*timepoint condition*group*timepoint visitno / solution residual influence;
	repeated condition timepoint / sub=subID type=un@un r rcorr;
lsmeans condition / diff=all adjust=bon;
lsmestimate condition "fructans vs glucose"  1 -1 , 
			"fructans vs saline" 1 0 -1/ divisor=1 adjust=bon stepdown; 
lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 ,  
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1 / divisor=1 adjust=bon stepdown; 
lsmestimate condition*group
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run; 



/* Delta VOLUME OF GAS */ 
	proc mixed data=FODMAP_abdomen;
	where timePoint NE "T0" ;
	class subID visitNo condition group timepoint;
	model log_d_VolGas_cm3m = condition group timepoint condition*group condition*timepoint group*timepoint condition*group*timepoint visitno / solution residual influence;
	repeated condition timepoint / sub=subID type=un@cs r rcorr;
lsmeans condition / diff=all adjust=bon; 
lsmeans timepoint/ diff=all adjust=bon;
lsmeans group*timepoint / slice=group slice=timepoint diff=all adjust=bon;
lsmestimate condition "fructans vs glucose"  1 -1 , 
			"fructans vs saline" 1 0 -1/ divisor=1 adjust=bon stepdown; 
lsmestimate group*timepoint "HC:T1 vs T2" 1 -1,
"IBS:T1 vs T2" 0 0 1 -1,
"T1: HV vs IBS" 1 0 -1,
"T2: HV vs IBS" 0 1 0 -1/ divisor=1 adjust=bon stepdown; 
lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 ,  
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1 / divisor=1 adjust=bon stepdown; 
 lsmestimate condition*group
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run;


