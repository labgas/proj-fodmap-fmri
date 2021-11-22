
%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_SAS_FINAL.xlsx"
out=work.FODMAP_signal;
sheet= "SELECTED_VARIABLES";
run;

proc univariate data=FODMAP_signal freq normal;
	var VolMean_SI;   /*these are all main variables Heather indicated */ 
	histogram VolMean_SI  / normal lognormal (theta=est) gamma (theta=est);
	run;

proc mixed data=FODMAP_signal;
	class subID condition group visitNo;
	model VolMean_SI = condition group condition*group  visitno / solution residual influence;
	repeated condition / sub=subID type=cs r rcorr;
lsmeans condition / diff=all adjust=bon; 
lsmeans condition*group / slice=condition slice=group diff=all adjust=bon;
lsmestimate condition "fructans vs glucose"  1 -1 , 
			"fructans vs saline" 1 0 -1/ divisor=1 adjust=bon stepdown; 
lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1  / divisor=1 adjust=bon stepdown; 
lsmestimate condition*group
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run;
