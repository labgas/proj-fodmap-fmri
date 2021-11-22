%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_fMRI_diff.xlsx"
out=work.FODMAP_vas;
run;
proc sort data=FODMAP_vas;
by subject;
run;

data FODMAP_vas; 
set FODMAP_vas; 
if time <= 0 then delete;
run;

 proc standard data=FODMAP_vas mean=0 std=1 out=FODMAP_std_glucose;
 where condition = 'fructans_glucose';
var volume_diff gas_diff;
run;
 proc standard data=FODMAP_vas mean=0 std=1 out=FODMAP_std_saline;
 where condition = 'fructans_saline';
var volume_diff gas_diff;
run;

proc sort data=FODMAP_std;
by   subject time;
run;

/* check distribution fructans vs glucose */ 

	proc univariate data=FODMAP_std_glucose freq normal;
	var bloating nausea fullness cramps pain flatulence;
	histogram bloating nausea fullness cramps pain flatulence / normal lognormal (theta=est) gamma (theta=est);
	run;
/* check distribution fructans vs saline */ 

proc univariate data=FODMAP_std_saline freq normal;
	var bloating nausea fullness cramps pain flatulence;
	histogram bloating nausea fullness cramps pain flatulence / normal lognormal (theta=est) gamma (theta=est);
	run;

/* bloating */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model bloating = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;
proc mixed data=FODMAP_std_saline;
	class subject time;
	model bloating = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

/* nausea */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model nausea = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model nausea = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;
/* fullness (diff) */
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model fullness = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model fullness = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

/* cramps */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model cramps = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model cramps = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;



/* pain */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model pain = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model pain = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

/* flatulence */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model flatulence = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model flatulence = volume_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  volume_diff = -1;
lsmeans time / at  volume_diff = 0;
lsmeans time / at  volume_diff = 1;
run;


/* gas */ 
	
/* bloating */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model bloating = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;
proc mixed data=FODMAP_std_saline;
	class subject time;
	model bloating = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -2;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
lsmeans time / at  gas_diff = 2;
ods output "Least Squares Means"=lsm_bloating;
run;

/* nausea */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model nausea = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model nausea = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;
/* fullness */
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model fullness = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model fullness = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

/* cramps */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model cramps = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model cramps = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -2;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
lsmeans time / at  gas_diff = 2;
ods output "Least Squares Means"=lsm_cramps;
run;


/* pain */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model pain = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model pain = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

/* flatulence */ 
proc mixed data=FODMAP_std_glucose;
	class subject time;
	model flatulence = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;

proc mixed data=FODMAP_std_saline;
	class subject time;
	model flatulence = gas_diff | time  / solution residual influence;
	repeated time / sub=subject type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
run;





