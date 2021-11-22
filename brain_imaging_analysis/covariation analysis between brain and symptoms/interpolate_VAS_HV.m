%6 measurements, 6 visits, 3 conditions, 49 timebins,13 subjects per group
%
%__________________________________________________________________________
clear all; clc;
[nVAS tVAS rVAS]=xlsread('E:\FODMAP_fMRI\SAS\VAS\FODMAP_fMRI_VAS.xlsx','FODMAP_HV');  %nVAS = number; tVAS= txt; rVAS= raw data --  %[num,txt,raw] = xlsread(___) additionally returns the text fields in cell array txt, and the unprocessed data (numbers and text) in cell array raw using any of the input arguments in the previous syntaxes. If xlRange is specified, leading blank rows and columns in the worksheet that precede rows and columns with data are returned in raw.
                                                    
                                                    % nVAS does not show headerlines, the others do. Just for pratical reasons to know the structure of the data 
                                                  
 
VAS_HV = cell(6,1);                                   %create empty cells
                                                
lines = 6;                                          %lines = number of lines per visit 

for a = 1:6;                                        %rotate between different VAS's (6 in total)
for i = 1:39;                                       %nr visits (amount of subjects * 3 )
    for j = 1:5;                                    
    x = 0:9;                                        %indicates how much you need to fill in, per gap
    y = (nVAS(lines*i+j-5,a+1)-nVAS(lines*i+j-6,a+1))* x/10 + nVAS(lines*i+j-6,a+1); 
                                                    %y = (Yb - Ya) * x/nsteps + Ya -- 6*(i-1)+j+1 = 6i+j-5 -- +1= indiciating where you start -- a+1: cause your first column is 2. --  x/10 because you have to fill in 10 timebins in between 2 measurements
                                                    %  + 1 is indicating your column !!!! lines*i+j is indicating you lines !!!!
                                                    %Ya is 1 timebin before Yb 
    VAS_HV{a} = [VAS_HV{a} y];                          
    end;
end;
end;

for b = 1:6;
VAS_HV{b} (1:50:1950)=[];
end;                                         % 50 time bins, delete the the first one of 50 per subject per condition, then left 49 timebins, 1911=49*13*3 in total

save('VAS_HV.mat','VAS_HV')



