/*-------------------------------*/
/* IMPORT DATA FROM EXCEL FILE   */
/*-------------------------------*/
%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_fMRI_VAS.xlsx"
out=work.FODMAP_vas;
run;






/

/* Calculate baseline */ 

	proc sort data = FODMAP_vas;
	by subject  condition;
	run;

	proc univariate data=FODMAP_vas noprint;
	var bloating;
	by subject condition; 
	where time <= 0; 
	output out=baseline_bloating mean= baseline_bloating; 
	run;

	proc univariate data=FODMAP_vas noprint;
	var fullness;
	by subject condition; 
	where time <= 0; 
	output out=baseline_fullness mean= baseline_fullness; 
	run;

	proc univariate data=FODMAP_vas noprint;
	var nausea;
	by subject condition; 
	where time <= 0; 
	output out=baseline_nausea mean= baseline_nausea; 
	run;

	proc univariate data=FODMAP_vas noprint;
	var cramps;
	by subject condition; 
	where time <= 0; 
	output out=baseline_cramps mean= baseline_cramps; 
	run;

	proc univariate data=FODMAP_vas noprint;
	var pain;
	by subject condition; 
	where time <= 0; 
	output out=baseline_pain mean= baseline_pain; 
	run;

	proc univariate data=FODMAP_vas noprint;
	var flatulence;
	by subject condition; 
	where time <= 0; 
	output out=baseline_flatulence mean= baseline_flatulence; 
	run;

	data FODMAP_vas_delta; /* create dataset */ 
	merge FODMAP_vas baseline_bloating baseline_fullness baseline_nausea baseline_cramps baseline_pain baseline_flatulence;
	by subject condition; 
	run;




/* calculate delta */ 

	data FODMAP_vas_delta; 
	set FODMAP_vas_delta; 
	delta_bloating = bloating - baseline_bloating; 
	delta_fullness = fullness - baseline_fullness; 
	delta_nausea = nausea - baseline_nausea; 
	delta_cramps = cramps - baseline_cramps; 
	delta_pain = pain - baseline_pain; 
	delta_flatulence = flatulence - baseline_flatulence; 
	run; 






/*--------------------------------*/
/*--------------------------------*/
/* check for baseline differences */ 
/*	no need to analyse baseline 
	seperately. It is included 
	in the model (time -30 & 0)   */ 
/*--------------------------------*/
/*--------------------------------*/






/*----------------------------------------------------------*/ 
/*----------------------------------------------------------*/ 
/*-----------------POST BASELINE----------------------------*/ 
/*----------------------------------------------------------*/ 
/*----------------------------------------------------------*/ 




/*----------*/

/* Bloating */ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var bloating ;
			histogram bloating / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table bloating;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if bloating = 0 then bloating_ord = 0 ; 
			if 0 < bloating <= 13 then bloating_ord = 1 ; 
			if 13 < bloating then bloating_ord = 2 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table bloating_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit bloating_ord;
			model bloating_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random condition / sub=subject type=ar(1) g;
			run; 
	estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;





/*----------*/

/* Fullness */ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var fullness ;
			histogram fullness / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table fullness;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if fullness = 0 then fullness_ord = 0 ; 
			if 0 < fullness <= 9 then fullness_ord = 1 ; 
			if 9 < fullness <= 25 then fullness_ord = 2 ; 
			if 25 < fullness then fullness_ord = 3 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table fullness_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit fullness_ord;
			model fullness_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random condition / sub=subject type=cs g;
			estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;







/*----------*/

/* Nausea   */ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var nausea ;
			histogram nausea / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table nausea;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if nausea = 0 then nausea_ord = 0 ; 
			if 0 < nausea <= 8 then nausea_ord = 1 ; 
			if 8 < nausea then nausea_ord = 2 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table nausea_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit nausea_ord;
			model nausea_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random visit / sub=subject type=ar(1) g;
		 	estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;









/*----------*/

/* Cramps   */ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var cramps ;
			histogram cramps / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table cramps;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if cramps = 0 then cramps_ord = 0 ; 
			if 0 < cramps <= 10 then cramps_ord = 1 ; 
			if 10 < cramps then cramps_ord = 2 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table cramps_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit cramps_ord;
			model cramps_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random visit / sub=subject type=un g;
	estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;










/*----------*/

/*   Pain   */ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var pain ;
			histogram pain / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table pain;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if pain = 0 then pain_ord = 0 ; 
			if 0 < pain <= 11 then pain_ord = 1 ; 
			if 11 < pain then pain_ord = 2 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table pain_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit pain_ord;
			model pain_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random condition / sub=subject type=ar(1) g;
	 	estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;












/*----------*/

/*Flatulence*/ 

/*----------*/


	/*--------------------------------------*/
	/* ORDINAL VALUES OF RAW DATA - GLIMMIX */ 
	/*--------------------------------------*/


			proc univariate data=FODMAP_vas_delta freq normal;
			var flatulence ;
			histogram flatulence / normal lognormal (theta=est) gamma (theta=est);
			run;


			/* divide into categories */

			proc freq data=FODMAP_vas_delta;
			table flatulence;
			run;
		 
			data FODMAP_vas_delta; 
			set FODMAP_vas_delta; 
			if flatulence = 0 then flatulence_ord = 0 ; 
			if 0 < flatulence <= 15 then flatulence_ord = 1 ; 
			if 15 < flatulence then flatulence_ord = 2 ; 
			run; 

			proc freq data= FODMAP_vas_delta;
			table flatulence_ord;
			run;


			proc glimmix data= FODMAP_vas_delta initglm method=quad(qpoints=5);
			class subject condition group time visit flatulence_ord;
			model flatulence_ord (descending) = condition group time condition*time condition*group group*time condition*group*time visit / solution dist=multinomial link=cumlogit cl oddsratio (diff=all);
			random condition / sub=subject type=ar(1) g;
			estimate "fructans vs glucose" condition 1 -1 , 
			"fructans vs saline" condition 1 0 -1/ divisor=1 adjust=bon stepdown; 

			estimate 
			"HC: fructans vs glucose"	condition	 1 -1 	condition*group	1	0	-1		,	
			"HC: fructans vs saline"	condition	1 0 -1	condition*group	1	0	0	0	-1	,
			"IBS: fructans vs glucose"	condition	 1 -1 	condition*group	0	1	0	-1	,	
			"IBS: fructans vs saline"	condition	1 0 -1	condition*group	0	1	0	0	0	-1/ divisor = 1 adjust=bon stepdown;

			estimate 
			"Fructans: HC vs IBS"	group	 1 -1 	condition*group	1	-1	,			
			"Glucose: HC vs IBS"	group	 1 -1 	condition*group	0	0	1	-1		,
			"Saline: HC vs IBS"	group	 1 -1 	condition*group	0	0	0	0	1	-1 / divisor = 1 adjust=bon stepdown;


