%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_SAS_colon_diff_IBS.xlsx"
out=work.FODMAP_colon;
sheet="SELECTED_VARIABLES";
run;




 proc standard data=FODMAP_colon mean=0 std=1 out=FODMAP_std_glucose;
 where condition = 'fructans_glucose';
var  gas_diff signal_diff;
run;
 proc standard data=FODMAP_colon mean=0 std=1 out=FODMAP_std_saline;
 where condition = 'fructans_saline';
var  gas_diff signal_diff;
run;





/* check distribution fructans vs glucose */ 

	proc univariate data=FODMAP_std_glucose freq normal;
	var volume_diff ;
	histogram volume_diff  / normal lognormal (theta=est) gamma (theta=est);
	run;
/* check distribution fructans vs saline */ 

proc univariate data=FODMAP_std_saline freq normal;
	var volume_diff ;
	histogram volume_diff  / normal lognormal (theta=est) gamma (theta=est);
	run;

/* voulme and gas */ 
proc mixed data=FODMAP_std_glucose;
	class subID time;
	model volume_diff = gas_diff | time  / solution residual influence;
	repeated time / sub=subID type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -2;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
lsmeans time / at  gas_diff = 2;
ods output "Least Squares Means"=lsm_gas_glucose;
run;

proc mixed data=FODMAP_std_saline;
	class subID time;
	model volume_diff = gas_diff | time  / solution residual influence;
	repeated time / sub=subID type=arh(1) r rcorr;
lsmeans time / at  gas_diff = -2;
lsmeans time / at  gas_diff = -1;
lsmeans time / at  gas_diff = 0;
lsmeans time / at  gas_diff = 1;
lsmeans time / at  gas_diff = 2;
ods output "Least Squares Means"=lsm_gas_saline;
run;

/* voulme and signal intensity */

proc mixed data=FODMAP_std_glucose;
	class subID time;
	model volume_diff = signal_diff | time  / solution residual influence;
	repeated time / sub=subID type=arh(1) r rcorr;
lsmeans time / at  signal_diff = -2;
lsmeans time / at  signal_diff = -1;
lsmeans time / at  signal_diff = 0;
lsmeans time / at signal_diff = 1;
lsmeans time / at  signal_diff = 2;
run;

proc mixed data=FODMAP_std_saline;
	class subID time;
	model volume_diff = signal_diff | time  / solution residual influence;
	repeated time / sub=subID type=arh(1) r rcorr;
lsmeans time / at  signal_diff = -2;
lsmeans time / at  signal_diff = -1;
lsmeans time / at  signal_diff = 0;
lsmeans time / at  signal_diff = 1;
lsmeans time / at  signal_diff = 2;
run;

