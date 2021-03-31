
load('../usermat_completed.mat')

% not completed
load('../../data/questionnaire/demographics/raw/p_ID.mat')
load('../../data/questionnaire/demographics/raw/demo_desc.mat')
load('../../data/questionnaire/demographics/raw/demo.mat')
not_completed=find(demo(:,6)==0);
p_ID_to_reject={};
for i=1:size(not_completed,1)
    p_ID_to_reject{end+1,1} = p_ID{not_completed(i)};
end
disp(p_ID_to_reject)

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
final=[usermat_completed' sum_];
disp(final)
to_exclude = final(find(final(:,2)==1),1);

disp(to_exclude)

% TODO: add the to_exclude matrix to step 7