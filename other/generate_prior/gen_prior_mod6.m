

parameters = {'Q0', 'gamma', 'tau', 'xi'};

% fit distributions
prior = [];
for p = 1:length(parameters)
    % set up settings
    prior(p).name = parameters{p};
    
    if ~isempty(strfind(parameters{p},'gamma'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',10);
        
    elseif ~isempty(strfind(parameters{p},'tau'))
        prior(p).dist = 'uniform';
        prior(p).scale = 1;
        prior(p).pd = makedist('Uniform','lower',0,'upper',7);
        
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
    
end

folder_name = ('../../../data/priors/mod6/');

if ~exist(folder_name)
    mkdir(folder_name)
end

save('../../../data/priors/mod6/empirical_prior.mat','prior')
