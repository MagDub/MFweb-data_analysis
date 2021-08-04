
mod12 = load('../../../data/data_for_figs/model_parameters.mat');
mod12_etaB = load('../../../data/data_for_figs/model_parameters_mod12_etaB.mat');

id_mod12 = mod12.model_parameters(:,1);
id_mod12_etaB = mod12_etaB.model_parameters(:,1);

missingids = id_mod12;

for i=1:size(id_mod12_etaB,1)
    id = id_mod12_etaB(i);
    ind = find(missingids==id);
    if ~isempty(ind)
        missingids(ind)=[];
    end
end
