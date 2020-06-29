function [parameters, param_settings] = concatenate_all_params(res_folder)

file_list = dir(strcat(res_folder,'*_results.mat'));

part_num = [];
all_parameters_thomp_noveltybonus = [];

    for participant = 1:size(file_list,1)
                
        part_num(participant) = str2num(file_list(participant).name(14:end-12));
        
        load(strcat(res_folder, file_list(participant).name));
        
        all_parameters_thomp_noveltybonus(participant,:) = mEparams;
        
    end
    
    tmp = load(strcat(res_folder, file_list(1).name), 'settings');
    
    param_settings.names = tmp.settings.params.param_names;
    param_settings.lb = tmp.settings.params.lb;
    param_settings.ub = tmp.settings.params.ub;

    parameters = [part_num' all_parameters_thomp_noveltybonus];
    
    parameters = sortrows(parameters, 1); 

end