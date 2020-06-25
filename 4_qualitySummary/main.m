
load('../usermat.mat')

load('../../data/questionnaire/all/RT_quest_all.mat');
load('../../data/questionnaire/all/RT_quest_desc.mat');
load('../../data/questionnaire/all/TotTimeSec_all.mat');
load('../../data/questionnaire/all/CheckPassedPerc_all.mat');

raw_fol = ('../../data/raw/');

disp('----------------------')

for i=1:length(usermat)
    
    userID = usermat(i);
    
    % user
    disp(['userID:', 32, num2str(userID)])
    
    % questionnaire checks
    disp(['Checks:', 32, num2str(CheckPassedPerc_all(i)*100), '%'])
    
    % total time
    time_interval_in_hours(i) = TotTimeSec_all(i)/3600;
    disp(['Time (h):', 32, num2str(time_interval_in_hours(i))])
    
    % questions no
    questionsfolder = dir(strcat(raw_fol, 'user_', num2str(userID), '/questions/*.xls'));
    disp(['Questions Repeat:', 32, num2str(size(questionsfolder,1))])   
    
    % training no
    trainingfolder = dir(strcat(raw_fol, 'user_', num2str(userID), '/training/*.xls'));
    disp(['Training Repeat:', 32, num2str(size(trainingfolder,1))])   
    
    % task info request
    load(strcat('../../data/concat_data/user_',num2str(userID),'.mat'))
    disp(['Info request:', 32, num2str(user.log(1,19))])
    
    % task picked D
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/hist_all.mat'))
    picked_D_SH = size(find(hist_all_mat(1,:)==4),2);
    picked_D_LH = size(find(hist_all_mat(2,:)==4),2);
    picked_D = picked_D_SH + picked_D_LH;
    disp(['D picked:', 32, num2str(picked_D/400*100), '%'])
    picked_D_mat(i) = picked_D/400*100;
    
    % task picked D
    load(strcat('../../data/sanity_check/user_',num2str(userID),'/hist_all.mat'))
    picked_C_SH = size(find(hist_all_mat(1,:)==3),2);
    picked_C_LH = size(find(hist_all_mat(2,:)==3),2);
    picked_C = picked_C_SH + picked_C_LH;
    disp(['D picked:', 32, num2str(picked_C/400*100), '%'])
    picked_C_mat(i) = picked_C/400*100;
    
    disp('----------------------')
    
end

% RT on quetionnaires
for q_num = 1:8
    subplot(4,2,q_num)
    plot(RT_quest_all(:,q_num)/(1000*60), 'o')
    grid on;
    xlim([0 length(usermat)+1])
    xticks(1:1:length(usermat))
    xticklabels(usermat)
    xlabel('user')
    ylabel('time (min)')
    title(RT_quest_desc(q_num))
end


%%%%% Time plot

time_interval_in_hours = time_interval_in_hours(2:end); % remove user 2

figure();
n = size(time_interval_in_hours,2);

% mean
bar_plot = bar(1,nanmean(time_interval_in_hours), 'FaceAlpha', 0.3, 'BarWidth',.3); hold on;

% individual dots
plot(rand(1,n)/10+ones(1,n), time_interval_in_hours,'.','MarkerSize',10);

% variance
h = errorbar(1,[nanmean(time_interval_in_hours)],...
    [nanstd(time_interval_in_hours)./sqrt(n)],'.','color','k');
set(h,'Marker','none')

% parameters
ylim([0 3])
ylabel('Time (hours)')
xlim([0 2])

%%
 mean(picked_C_mat)
 mean(picked_D_mat)
