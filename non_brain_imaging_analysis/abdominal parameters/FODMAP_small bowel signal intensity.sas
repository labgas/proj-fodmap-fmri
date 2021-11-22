%let path=E:\FODMAP_fMRI\SAS;
proc import
datafile="&path\FODMAP_SAS_FINAL.xlsx"
out=work.FODMAP_abdomen;
sheet="SELECTED_VARIABLES";
run;



data FODMAP_abdomen; 
	set FODMAP_abdomen; 
	if group = "IBS" and condition = "fructans" then groupcon = "IBS - fructans" ; 
	if group = "IBS" and condition = "glucose" then groupcon = "IBS - glucose" ; 
	if group = "IBS" and condition = "saline" then groupcon = "IBS - saline" ; 
	if group = "HV" and condition = "fructans" then groupcon = "HC - fructans" ; 
	if group = "HV" and condition = "glucose" then groupcon = "HC - glucose" ; 
	if group = "HV" and condition = "saline" then groupcon = "HC - saline" ; 
	run;


proc sort data=FODMAP_abdomen; 
by subID	group condition   visitNo	timePoint; 
run;





ods listing gpath=" E:\FODMAP_fMRI\SAS\GRAPHS\ " image_DPI=300; 
ods graphics on / imagename="Small bowel motility signal ibs" outputfmt=tiff noborder height=7cm  width=5cm ; 
proc sgplot data=FODMAP_abdomen noborder nowall /*noautolegend*/ ;
	where Group = "IBS";
	title 'IBS';
styleattrs 	datacontrastcolors = (red VLIGB black) 
	 			datacolors=(red VLIGB black)  
	 			datasymbols=(Diamondfilled Squarefilled Circlefilled) ;
vbox REFroi_mean_readers / category=condition fill fillattrs=(color=H000BB00) 
 	 		/*fillattrs = fill color of the boxes*/
 		meanattrs=(symbol=plus color=black size=8) /*symbol mean value*/
		lineattrs=(color=black) /*lining of boxes*/
      	medianattrs=(color=black) /*color of line of median value*/
       	whiskerattrs=(color=black) /*color of whiskers*/
	  	outlierattrs=(color=green symbol=square size=8); /*outlier*/
xaxis 	values=("Fructans" "Glucose" "Saline") 
 		valueattrs=(Color=Black Family=Arial Size=6) 
 		display=(nolabel);
yaxis 	valueattrs=(Color=Black Family=Arial Size=8) 
 		label="Signal intenstiy in small bowel";
scatter  x=condition y=REFroi_mean_readers / group= condition  markerattrs=(size=3);
run;

ods listing gpath=" E:\FODMAP_fMRI\SAS\GRAPHS\ " image_DPI=300; 
ods graphics on / imagename="Small bowel motility signal hc" outputfmt=tiff noborder height=7cm  width=5cm ; 
proc sgplot data=FODMAP_abdomen noborder nowall /*noautolegend*/ ;
	where Group = "HC";
	title 'HC';
styleattrs 	datacontrastcolors = (red VLIGB black) 
	 			datacolors=(red VLIGB black)  
	 			datasymbols=(Diamondfilled Squarefilled Circlefilled) ;
vbox REFroi_mean_readers / category=condition fill fillattrs=(color=H000BB00) 
 	 		/*fillattrs = fill color of the boxes*/
 		meanattrs=(symbol=plus color=black size=8) /*symbol mean value*/
		lineattrs=(color=black) /*lining of boxes*/
      	medianattrs=(color=black) /*color of line of median value*/
       	whiskerattrs=(color=black) /*color of whiskers*/
	  	outlierattrs=(color=green symbol=square size=8); /*outlier*/
xaxis 	values=("Fructans" "Glucose" "Saline") 
 		valueattrs=(Color=Black Family=Arial Size=6) 
 		display=(nolabel);
yaxis 	valueattrs=(Color=Black Family=Arial Size=8) 
 		label="Signal intenstiy in small bowel";
scatter  x=condition y=REFroi_mean_readers / group= condition  markerattrs=(size=3);
run;























