
%% get prior data
for i = 1:60
    ID = i+500;
    load(strcat('D:\MaggiesFarm\modeling_28_02\participant_data\thompson_noveltybonus\3params_1Hor\results\fmincon\res_thompson_',int2str(ID),'_results.mat'))
    mEmat(i) = mE;
end

parameters = settings.params.param_names;
parameters = parameters(~cellfun('isempty',parameters)); % ignores empty entries

%% get parameters
params = reshape([mEmat(:).params],length(parameters),length(mEmat))';


%% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    if ~isempty(strfind(parameters{p},'sgm0'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',6);
    elseif ~isempty(strfind(parameters{p},'Q0'))
        prior(p).dist = 'normal';
        prior(p).scale = 1; 
        prior(p).pd = makedist('Normal','mu',5,'sigma',2);
    elseif ~isempty(strfind(parameters{p},'xi'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',0.5);
    elseif ~isempty(strfind(parameters{p},'eta'))        
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',5);
    else
        error('unknown parameter')
    end
   
    % plot
    max_p = max(params(:,p).*prior(p).scale);
    figure(p)
    subplot(2,1,1)
    hist(params(:,p).*prior(p).scale,12)
    title(prior(p).name)
    
    subplot(2,1,2)
    tmp = []; n = 1;
    for i =0.0001:max_p/100:max_p
        tmp(n) = prior(p).pd.pdf(i);
        n=n+1;
    end
    plot(0.0001:max_p/100:max_p,tmp,'m','LineWidth',2)
    
end

%% save
save('participant_data/priors/thompson_4params_sgm0_xi_eta_uni/empirical_prior.mat','prior')
