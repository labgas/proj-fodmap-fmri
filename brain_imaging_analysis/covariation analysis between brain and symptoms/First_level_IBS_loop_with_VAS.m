% Adapted by Eddy, 04 Apr, 2020, for FODMAP_fMRI analysis.
% loop for subjects, loop for measurements, loop for timebins
% 13 subjects per group, 49 timebins, 3 conditions(fructans, glucose, saline)
% will get 882 contrast images per subject
%
%__________________________________________________________________________
clear all; clc; spm('defaults','FMRI');              %clear the workspace, and reset spm to default.
root = 'D:\FODMAP_fMRI\FIRST_LEVEL\prepared for 1st level\'; cd(root);
sub = dir('first_level_subjpat*');                    %copy the 1st level directory
load VAS_IBS.mat;                                    %load your interpolation file
inter = {'bloating','fullness','nausea','cramps','pain','flatulence'};
for i = 1:length(sub);                              %loop for subjects
    matlabbatch = struct([]);                      % create empty structures
    cd(sub(i).name);
matlabbatch{1}.spm.stats.con.spmmat = {[root sub(i).name '\SPM.mat']};

for jl = 1:6;    %loop for 6 symptoms
    
for a = 1:49;   %loop for timebins of fructans_glucose
matlabbatch{1}.spm.stats.con.consess{a+(jl-1)*147}.tcon.name = ['fructans_glucose_bin' num2str(a) inter{jl}];    %name for contrasts
if VAS_IBS{jl}(a+49+(i-1)*147) == 0;
    matlabbatch{1}.spm.stats.con.consess{a+(jl-1)*147}.tcon.weights = [zeros(1, a-1) VAS_IBS{jl}(a+(i-1)*147) zeros(1,48) 0.00000000000001];   %0.0001 cause you cannot create contrasts with all zero's
else
matlabbatch{1}.spm.stats.con.consess{a+(jl-1)*147}.tcon.weights = [zeros(1, a-1) VAS_IBS{jl}(a+(i-1)*147) zeros(1,48) -VAS_IBS{jl}(a+49+(i-1)*147)];
end;
matlabbatch{1}.spm.stats.con.consess{a+(jl-1)*147}.tcon.sessrep = 'none';
end;

 for b = 1:49 %loop for timebins of fructans_saline
        d = b + 49;
 matlabbatch{1}.spm.stats.con.consess{d+(jl-1)*147}.tcon.name = ['fructans_saline_bin' num2str(b) inter{jl}];      
 if VAS_IBS{jl}(b+98+(i-1)*147) == 0;
    matlabbatch{1}.spm.stats.con.consess{d+(jl-1)*147}.tcon.weights = [zeros(1, b-1) VAS_IBS{jl}(b+(i-1)*147) zeros(1,97) 0.00000000000001];   %0.0001 cause you cannot create contrasts with all zero's 
else
matlabbatch{1}.spm.stats.con.consess{d+(jl-1)*147}.tcon.weights = [zeros(1, b-1) VAS_IBS{jl}(b+(i-1)*147) zeros(1,97) -VAS_IBS{jl}(b+98+(i-1)*147)];
end;      
matlabbatch{1}.spm.stats.con.consess{d+(jl-1)*147}.tcon.sessrep = 'none';
end;

for c = 1:49 %loop for timebins of glucose_saline
         e = c + 98;
matlabbatch{1}.spm.stats.con.consess{e+(jl-1)*147}.tcon.name = ['glucose_saline_bin' num2str(c) inter{jl}];
if VAS_IBS{jl}(c+98+(i-1)*147) == 0;
    matlabbatch{1}.spm.stats.con.consess{e+(jl-1)*147}.tcon.weights = [zeros(1, 49) zeros(1, c-1) VAS_IBS{jl}(c+49+(i-1)*147) zeros(1,48) 0.00000000000001];   %0.0001 cause you cannot create contrasts with all zero's
else
matlabbatch{1}.spm.stats.con.consess{e+(jl-1)*147}.tcon.weights = [zeros(1, 49) zeros(1, c-1) VAS_IBS{jl}(c+49+(i-1)*147) zeros(1,48) -VAS_IBS{jl}(c+98+(i-1)*147)];
end;      
matlabbatch{1}.spm.stats.con.consess{e+(jl-1)*147}.tcon.sessrep = 'none';
end;
    
end;

matlabbatch{1}.spm.stats.con.delete = 1;  %delete old contrasts before you run new ones

eval(['save Batch_interpolate_VAS_IBS_' sub(i).name(13:22) '.mat matlabbatch']);    %save batch job and rename
cd(root);
spm_jobman('initcfg')
spm_jobman('run',matlabbatch);%run batch                                                               
clear matlabbatch;   %clear the batch for next in the loop
end;

