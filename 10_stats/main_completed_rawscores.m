
load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')
to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Load items
load('../../data/questionnaire/all/all_items_desc.mat')
load('../../data/questionnaire/all/all_items.mat')

% Remove
all_items(to_del,:)=nan;
exclude = isnan(all_items(:,end));

% Concatenate
all=[num2cell(usermat_completed'), num2cell(exclude), num2cell(all_items)];
all_desc = ['user', 'exclude', all_items_desc]; 

T = cell2table(all,'VariableNames',all_desc);
 
writetable(T,'./web_data_completed_Q_items.xlsx')
