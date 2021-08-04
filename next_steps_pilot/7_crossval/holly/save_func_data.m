function save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, He_MAP, He_LL, mEmatparams, mEmatmle, mEprior)

    mE.subj = mEsubj;
    mE.settings = settings;
    mE.params = mEparams;
    mE.mle = mEmle; % this is negative log likelihood
    mE.MAP = mEMAP;
    mE.exitflag = mEexitflag;
    mE.He_MAP = He_MAP;
    mE.He_LL = He_LL;
    mE.matparams = mEmatparams;
    mE.matmle = mEmatmle;
    mE.prior = mEprior;
    %mE.nlogL = nlogL;

    % save
    save([results_dir 'res_' settings.desc '_' int2str(ID) '.mat'],'mE','settings')
    save([results_dir 'res_' settings.desc '_' int2str(ID) '_results.mat'])
    
end