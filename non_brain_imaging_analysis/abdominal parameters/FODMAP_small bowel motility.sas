%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_SAS_FINAL.xlsx"
out=work.FODMAP_motility;
sheet= "SELECTED_VARIABLES";
run;

proc univariate data=FODMAP_motility freq normal;
	var JACroi_mean_readers JACroi_std_readers REFroi_mean_readers;   /*these are all main variables Heather indicated */ 
	histogram JACroi_mean_readers JACroi_std_readers REFroi_mean_readers / normal lognormal (theta=est) gamma (theta=est);
	run;




proc mixed data=FODMAP_motility;
	class subID condition group visitNo;
	model JACroi_mean_readers = condition group condition*group  visitno / solution residual influence;
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



proc mixed data=FODMAP_motility;
	class subID condition group visitNo;
	model REFroi_mean_readers = condition group condition*group  visitno / solution residual influence;
	repeated condition / sub=subID type=ar(1) r rcorr;
lsmeans condition / diff=all adjust=bon; 
lsmeans condition*group / slice=condition slice=group diff=all adjust=bon;

lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1  / divisor=1 adjust=bon stepdown; 
lsmestimate condition*group
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run;


proc mixed data=FODMAP_motility;
	class subID condition group visitNo;
	model JACroi_std_readers = condition group condition*group  visitno / solution residual influence;
	repeated condition / sub=subID type=un r rcorr;

lsmestimate condition*group "HC: fructans vs glucose" 1 0 -1, 
"HC: fructans vs saline" 1 0 0 0 -1 , 
"IBS: fructans vs glucose" 0 1 0 -1 , 
"IBS: fructans vs saline" 0 1 0 0 0 -1  / divisor=1 adjust=bon stepdown; 
lsmestimate condition*group
"fructans: HC vs IBS" 1 -1 , 
"glucose: HC vs IBS" 0 0 1 -1 , 
"saline: HC vs IBS" 0 0 0 0 1 -1 / divisor=1 adjust=bon stepdown; 
run;
