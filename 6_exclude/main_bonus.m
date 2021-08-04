
load('../../data/questionnaire/demographics/raw/p_ID.mat')
load('../../data/questionnaire/demographics/raw/userID.mat')

data_fold = ('../../data/');
load(strcat(data_fold, 'data_for_figs/score.mat'))
load(strcat(data_fold, 'data_for_figs/score_desc.mat'))

load('../usermat_completed.mat')
load('./to_exclude.mat')
load('./final.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Information about exclusion
score_tot = (score(:,2)+score(:,4))/2;
bonus_GBP = (score_tot-4)/2;
bonus_GBP(find(final(:,2)>0))=0; % No bonus if was excluded
bonus_GBP_exclusion_crit = [bonus_GBP, final];
bonus_GBP_exclusion_crit_desc={'Bonus_GBP','ID', 'Nb_of_exclusion_criteria_met','low_mean_score', 'fast_first_response', 'attention_checks_failed'};

% Compute bonus for included IDs
score(to_del,:) = [];
bonus_GBP(to_del,:) = [];
user_included = score(:,1);

ind_mat = [];
for i=1:size(user_included,1)
    
    ind = find(userID==user_included(i));
    
    ind_mat(end+1) = ind;

end

if sum(userID(ind_mat)~=score(:,1))>0
    print('ID mismatch')
end

bonus_mat_all_desc = {'pID', 'UserFromPID', 'UserFromScore', 'ScoreSH', 'ScoreLHall', 'BonusGBP'};
bonus_mat_all = [p_ID(ind_mat), num2cell(userID(ind_mat)), num2cell(score(:,1)), num2cell(score(:,2)), num2cell(score(:,3)), num2cell(bonus_GBP)];

bonus_mat_desc = {'pID', 'BonusGBP'};
bonus_GBP = round(bonus_GBP,2);
bonus_mat = [p_ID(ind_mat), num2cell(bonus_GBP)];

T = cell2table(bonus_mat);
writetable(T,'list_bonus_GBP.txt')

load('processed_bon.mat')


% remove processed ones
ind_to_del_bon_mat = [];
processed_bon = regexprep(processed_bon, '\W', ''); % remove white spaces
for j = 1:size(bonus_mat,1)
    for i = 1:size(processed_bon,1)
        tmp_id=processed_bon(i);
        if strcmp(bonus_mat{j,1},tmp_id{:}) == 1
            ind_to_del_bon_mat(end+1) = j;
        end
    end
end
bonus_mat_new = bonus_mat;
bonus_mat_new(ind_to_del_bon_mat,:) = [];
T = cell2table(bonus_mat_new);
writetable(T,'list_bonus_GBP_new.txt')


userID(ind_mat) = [];
p_ID(ind_mat) = [];

ind_compl_exclu = [];

for i=1:size(usermat_completed,2)
    
    ind = find(userID==usermat_completed(i));
    
    if ~isempty(ind)
        ind_compl_exclu(end+1) = ind;
    end

end

load('to_exclude.mat')
no_score = zeros(size(userID(ind_compl_exclu)));
bonus_mat_rej_all_desc = {'pID', 'UserFromPID', 'UserFromToExclude', 'BonusGBP'};
bonus_mat_rej_all = [p_ID(ind_compl_exclu), num2cell(userID(ind_compl_exclu)), num2cell(to_exclude'), num2cell(no_score)];

bonus_mat_rej_desc = {'pID'};
bonus_mat_rej = [p_ID(ind_compl_exclu)];
T2 = cell2table(bonus_mat_rej);
writetable(T2,'list_bonus_GBP_rej.txt')

% TODO manually
% change: 
% '60072a91f1bbf51aed4f803' to '60072a91f1bbf51aed4f8e03'
% '556ce42d9465e580006846f57' to '56ce42d9465e580006846f57'




