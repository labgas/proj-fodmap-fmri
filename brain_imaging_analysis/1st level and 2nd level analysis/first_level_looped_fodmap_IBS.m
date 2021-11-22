% first_level_phfMRI_looped_fodmap
%
% SPECIFIC FOR PHFMRI FODMAP STUDY
% Based on the histamine script by Lukas
%
% adpted by Eddy
% date:     April 2019
%
%__________________________________________________________________________
close all hidden
clear all hidden

% define settings of SPM
spm('defaults','FMRI')

% define directory where denoised images are (one single directory, move/copy
% images there prior to running the script if needed)
datadir = 'D:\FODMAP_fMRI\FIRST_LEVEL\prepared for 1st level\';
cd(datadir);

sub_fructans = dir('niftiDATA_subjpat*_fructans.nii');
sub_glucose = dir('niftiDATA_subjpat*_glucose.nii');
sub_saline = dir('niftiDATA_subjpat*_saline.nii');
% template_struct_image = 'wc1.*\.nii$';
%-------------------------------------------------------------
% nr_subjects = size(sub_glucose,1);
% loop creation of 3 batches
for i = 1:length(sub_fructans)
    clear matlabbatch
    matlabbatch = struct([]); % create empty structures
    analysis = ['first_level_',sub_fructans(i).name(11:20)];
    mkdir(analysis); %create new analysis folder, renamed!
    file_fructans = spm_select('Extlist', datadir, sub_fructans(i).name,1:1416);
    file_glucose = spm_select('Extlist', datadir, sub_glucose(i).name,1:1416);
    file_saline = spm_select('Extlist', datadir, sub_saline(i).name,1:1416);
    cd(analysis);

    % FIRST BATCH: MODEL SPECIFICATION
    %--------------------------------
    % make matlab batch structure
    % ---------------------------
    matlabbatch{1}.spm.stats.fmri_spec.dir = {analysis};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'scans';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.5;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 46;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 23;
    % SESSION 1 Fructans
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = cellstr(strcat(datadir, file_fructans));
    for z = 1:49  %loop create timebins for first session
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).name = ['fructans_bin' num2str(z)];
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).onset = 24 * z + 217;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).duration = 24;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(z).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 3540;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {''};
    end;
    % SESSION 2 Glucose
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).scans = cellstr(strcat(datadir, file_glucose));
    for y = 1:49  %loop create timebins for second session
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).name = ['glucose_bin' num2str(y)];
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).onset = 24 * y + 217;  
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).duration = 24;
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).cond(y).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).hpf = 3540;
    matlabbatch{1}.spm.stats.fmri_spec.sess(2).multi = {''};
    end;
    % SESSION 3 saline
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).scans = cellstr(strcat(datadir, file_saline));
    for x = 1:49  %loop create timebins for third session
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).name = ['saline_bin' num2str(x)];
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).onset = 24 * x + 217;  
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).duration = 24;
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).cond(x).orth = 1;
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).hpf = 3540;
    matlabbatch{1}.spm.stats.fmri_spec.sess(3).multi = {''};
    end;
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = -inf;

    % SECOND BATCH: ESTIMATION
    %------------------------
    matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

    % THIRD BATCH: CONTRASTS
    %----------------------
    matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    for a = 1:49 %loop for contrast manager 
    matlabbatch{3}.spm.stats.con.consess{a}.tcon.name = ['fructans_glucose_bin' num2str(a)];
    matlabbatch{3}.spm.stats.con.consess{a}.tcon.weights = [zeros(1, a-1) 1 zeros(1,48) -1];   %first 1 indicates amount of rows ( but only 1 row here, since it is repeated for each timebin seperate ), a-1 indicates amount of colums. 
    matlabbatch{3}.spm.stats.con.consess{a}.tcon.sessrep = 'none';
    end;
    for b = 1:49 %loop for contrast manager
        d = b + 49;
    matlabbatch{3}.spm.stats.con.consess{d}.tcon.name = ['fructans_saline_bin' num2str(b)];
    matlabbatch{3}.spm.stats.con.consess{d}.tcon.weights = [zeros(1, b-1) 1 zeros(1,97) -1];   %first 1 indicates amount of rows ( but only 1 row here, since it is repeated for each timebin seperate ), b-1 indicates amount of colums. 
    matlabbatch{3}.spm.stats.con.consess{d}.tcon.sessrep = 'none';
    end;
     for c = 1:49 %loop for contrast manager
         e = c + 98;
    matlabbatch{3}.spm.stats.con.consess{e}.tcon.name = ['glucose_saline_bin' num2str(c)];
    matlabbatch{3}.spm.stats.con.consess{e}.tcon.weights = [zeros(1, 49) zeros(1,c-1) 1 zeros(1,48) -1];   %first 1 indicates amount of rows ( but only 1 row here, since it is repeated for each timebin seperate ), c-1 indicates amount of colums. 
    matlabbatch{3}.spm.stats.con.consess{e}.tcon.sessrep = 'none';
    end;
   matlabbatch{3}.spm.stats.con.delete = 0;
    % SAVE BATCHES AND RUN
    %---------------------
    eval(['save design_first_level_' sub_fructans(i).name(11:20) '.mat matlabbatch']); 
    cd(datadir)
    spm_jobman('initcfg');
    spm_jobman('run',matlabbatch);
end;