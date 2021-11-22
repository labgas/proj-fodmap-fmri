clear all;
root = 'D:\FODMAP_fMRI\FOR_SECOND_LEVEL\fructans_saline\'; 
cd(root);
spm('defaults','FMRI');%set default
file = dir('first_level_subj*');
filepat = dir('first_level_subjpat*');
filecon = dir('first_level_subjcon*');

sbjn = 26;      %subjectnr
patn = 13;
conn = 13;
binn = 49;      %amount of timebins

matlabbatch{1}.spm.stats.factorial_design.dir = {'D:\FODMAP_fMRI\SECOND_LEVEL\fructans_saline\pat_v_con\'};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'group';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'bin';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;

for i=1:patn
cd([root filepat(i).name]);
file_con_pat = spm_select('FPList', [root filepat(i).name], ['^','con_*.*\.nii']);
filecon_pat{i} = cellstr(file_con_pat);
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).scans = filecon_pat{i};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).conds = [1	1 1	 1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1;1:binn];
cd(root);
end;
for j=1:conn
cd([root filecon(j).name]);
file_con_con = spm_select('FPList', [root filecon(j).name], ['^','con_*.*\.nii']);
filecon_con{j} = cellstr(file_con_con);
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(j+patn).scans = filecon_con{j};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(j+patn).conds = [2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2	2;1:binn];
cd(root);
end;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.inter.fnums = [2;3];
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {'D:\FODMAP_fMRI\EXPLICIT_MASK\all_mask.nii'};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'patients interaction effect';
%%
matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = [diff(eye(49))];
%%
matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
% matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'patients effect of interest';
% %%
% matlabbatch{3}.spm.stats.con.consess{2}.fcon.weights = [eye(49) ones(49,13)/13]
% %%
% matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'controls interaction effect';
%%
matlabbatch{3}.spm.stats.con.consess{2}.fcon.weights = [zeros(48,49) diff(eye(49))];
%%
matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
% matlabbatch{3}.spm.stats.con.consess{4}.fcon.name = 'controls effect of interest';
% %%
% matlabbatch{3}.spm.stats.con.consess{4}.fcon.weights = [zeros(49,49) eye(49) ones(49,13)/13];
% %%
% matlabbatch{3}.spm.stats.con.consess{4}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'patients vs controls interaction effect';
%%
matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [-diff(eye(49)) diff(eye(49))];
%%
matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 1;
cd 'D:\FODMAP_fMRI\SECOND_LEVEL\fructans_saline\pat_v_con\';
eval('save batch_oneway_ANOVA_2nd_level_fructans_saline_pat_v_con.mat matlabbatch');%save batch job and rename
cd(root);
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);%run batch
clear matlabbatch;%clear the batch for next
spm('defaults','FMRI');%set default