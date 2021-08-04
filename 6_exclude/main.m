clear;
load('../usermat_completed.mat')

% not completed
[p_ID_to_reject] = get_p_ID_to_reject();
[p_ID_to_approve] = get_p_ID_to_approve();

% mean score is lower than 5.5
load('../../data/data_for_figs/score_SH.mat')
load('../../data/data_for_figs/score_LH.mat')
score = (score_SH+score_LH)/2;
exclusion(:,1) = score<5.5;

% 1st draw is lower than 1500ms
load('../../data/data_for_figs/task_RT_1st_in_sec.mat')
exclusion(:,2) = task_RT_1st_in_sec<1.5;

% attention check failed during questionnaire
fol_all = ('../../data/questionnaire/all');
load(strcat(fol_all,'/CheckPassedPerc_all.mat'))
exclusion(:,3) = CheckPassedPerc_all<1;

% To exclude
sum_ = sum(exclusion,2);
final=[usermat_completed' sum_ exclusion];
%disp(final)
to_exclude = final(find(final(:,2)>0),1);
to_exclude_mat = final(find(final(:,2)>0),:);
to_exclude=to_exclude';
save('to_exclude.mat', 'to_exclude');
save('final.mat', 'final');

disp(strcat(...
    'Participants to exclude:',32,num2str(size(to_exclude_mat,1)),...
    ' out of', 32, num2str(size(usermat_completed,2)),...
    '. Ratio:', 32, num2str(size(to_exclude_mat,1)/size(usermat_completed,2)*100),'%'...
    ))

% add failed attention check
% pID, userID, approved, failedCriteria
p_ID_to_approve(:,4) = {0};
for i = 1:size(to_exclude,1)
    tmp_userID = to_exclude(i);
    tmp_id = find([p_ID_to_approve{:,2}]==tmp_userID);
    p_ID_to_approve(tmp_id,4) = {1};
end

p_ID_to_approve_passedChecks = p_ID_to_approve;
index_ = find([p_ID_to_approve_passedChecks{:,4}] == 1);
p_ID_to_approve_passedChecks(index_,:) = [];
% disp(p_ID_to_approve_passedChecks) % Can be approved: completed task and passed checks
list_ = p_ID_to_approve_passedChecks(:,1);

fid = fopen('list_to_approve.txt','w');
fprintf(fid,'%s\n', list_{:});
fclose(fid);

% TODO: add the to_exclude matrix to step 7