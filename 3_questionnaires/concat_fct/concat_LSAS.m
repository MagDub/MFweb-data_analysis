function [LSAS_mat_desc, LSAS_mat, LSAS_score_desc, LSAS_score] = concat_LSAS(quest)

% score: sum (fear and avoidance subscales; higher: more anxiety)
% 4 subscores (performance anxiety, performacne avoidance, social anxiety, social avoidance)

n_lett = 4;

space1 = 13;
space2 = 16;

n_items = 24;

start = find(quest=='L');

question = {};
answer_fear = [];
answer_avoidance = [];

for n = 1:n_items
    if isnan(str2double(quest(start(n)+n_lett+2)))
       fin = start(n)+n_lett+1;
    else
       fin = start(n)+n_lett+2;
    end
    tmp = quest(start(n):fin);
    item_no(n) = str2double(tmp(n_lett+2:end));
    fin = fin + space1;
    answer_fear(end+1) = str2double(quest(fin));
    fin = fin + space2;
    answer_avoidance(end+1) = str2double(quest(fin));
end

LSAS_mat_desc = {'Item', 'FearResponse', 'AvoidanceResponse'};
LSAS_mat = [item_no; answer_fear; answer_avoidance]';
LSAS_mat = sortrows(LSAS_mat,1);


% fear
performance_fear = LSAS_mat([1:4 6 8 9 13 14 16 17 20 21],2);
social_fear = LSAS_mat([5 7 10:12 15 18 19 22:24],2);

if sum(LSAS_mat(:,2))~=(sum(performance_fear)+sum(social_fear))
    disp('mismatch')
end

% avoidance
performance_avoidance = LSAS_mat([1:4 6 8 9 13 14 16 17 20 21],3);
social_avoidance = LSAS_mat([5 7 10:12 15 18 19 22:24],3);

if sum(LSAS_mat(:,3))~=(sum(performance_avoidance)+sum(social_avoidance))
    disp('mismatch')
end

% score mat
LSAS_score_desc = {'TotalScore', 'Fear', 'Avoidance', 'PerformanceFear', 'SocialFear', 'PerformanceAvoidance', 'SocialAvoidance'};
LSAS_score = [sum(answer_fear)+sum(answer_avoidance), sum(answer_fear), sum(answer_avoidance)...
          sum(performance_fear), sum(social_fear), sum(performance_avoidance), sum(social_avoidance)];


end

