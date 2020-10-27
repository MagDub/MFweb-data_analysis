function [parameters, param_settings] = concatenate_all_params_UCB(res_folder, usermat_completed)

file_list = dir(strcat(res_folder,'*_results.mat'));

part_num = [];
all_parameters_thomp_noveltybonus = [];

    for participant = 1:size(file_list,1)
        
        tmp = str2num(file_list(participant).name(9:end-12));
        
        if ~isempty(find(usermat_completed==tmp))
                
            part_num(end+1) = tmp;
      
            load(strcat(res_folder, file_list(participant).name));

            all_parameters_thomp_noveltybonus(end+1,:) = mEparams;
        
        end
        
    end
    
    tmp_ = load(strcat(res_folder, file_list(1).name), 'settings');
    
    param_settings.names = tmp_.settings.params.param_names;
    param_settings.lb = tmp_.settings.params.lb;
    param_settings.ub = tmp_.settings.params.ub;

    parameters = [part_num' all_parameters_thomp_noveltybonus];
    
    parameters = sortrows(parameters, 1); 

end