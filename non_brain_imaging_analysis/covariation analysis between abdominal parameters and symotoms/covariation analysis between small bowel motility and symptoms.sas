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

data FODMAP_motility; 
set FODMAP_vas; 
if time NE '60' then delete ; 
run;
 proc standard data=FODMAP_motility mean=0 std=1 out=FODMAP_std_glucose;
where condition = 'fructans_glucose';
var motility_diff;
run;

 proc standard data=FODMAP_motility mean=0 std=1 out=FODMAP_std_saline;
where condition = 'fructans_saline';
var motility_diff;
run;


proc univariate data=FODMAP_std_glucose freq normal;
	var bloating nausea fullness cramps pain flatulence;
	histogram bloating nausea fullness cramps pain flatulence / normal lognormal (theta=est) gamma (theta=est);
	run;

proc univariate data=FODMAP_std_saline freq normal;
	var bloating nausea fullness cramps pain flatulence;
	histogram bloating nausea fullness cramps pain flatulence / normal lognormal (theta=est) gamma (theta=est);
	run;


/* bloating */ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model bloating = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;

proc mixed data=FODMAP_std_saline;
	class subject;
	model bloating = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
/* nausea */ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model nausea = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
proc mixed data=FODMAP_std_saline;
	class subject;
	model nausea = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;

/* fullness */ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model fullness = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
proc mixed data=FODMAP_std_saline;
	class subject;
	model fullness = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;

/* cramps */ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model cramps = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
proc mixed data=FODMAP_std_saline;
	class subject;
	model cramps = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;

data FODMAP_std_saline; 
	set FODMAP_std_saline; 
	if cramps   <= 0 then cramps_ord = 0 ; 
			if 0 < cramps <= 27 then cramps_ord = 1; 
			if 27 < cramps  then cramps_ord = 2 ; 
           run; 

	proc freq data= FODMAP_std_saline;
	table cramps_ord;
	run;
	proc glimmix data= FODMAP_std_saline initglm ;
	class subject  cramps_ord;
	model cramps_ord (descending) = motility_diff  / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
	random int /   g;
	run; 

/* pain */ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model pain = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
proc mixed data=FODMAP_std_saline;
	class subject;
	model pain = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;



/* flatulence (diff)*/ 
proc mixed data=FODMAP_std_glucose;
	class subject;
	model flatulence = motility_diff / solution residual influence;
	repeated subject / r rcorr;
run;
proc mixed data=FODMAP_std_saline;
	class subject;
	model flatulence = motility_diff / solution residual influence;
	repeated subject / r rcorr;
    run;
