function [LSAS_mat_desc, LSAS_mat, LSAS_score_desc, LSAS_score] = concat_LSAS(quest)

space1 = 13;
space2 = 16;

n_items = 24;

start = find(quest=='L');

question = {};
answer_fear = [];
answer_avoidance = [];

for n = 1:n_items
    if n < 10
       fin = start(n)+5;
    else
       fin = start(n)+5+1;
    end
    question{end+1} = quest(start(n):fin);
    fin = fin + space1;
    answer_fear(end+1) = str2double(quest(fin));
    fin = fin + space2;
    answer_avoidance(end+1) = str2double(quest(fin));
end

LSAS_mat_desc = {'Item', 'FearResponse', 'AvoidanceResponse'};
LSAS_mat = [1:n_items; answer_fear; answer_avoidance]';
LSAS_score_desc = {'TotalScore', 'FearScore', 'AvoidanceScore'};
LSAS_score = [sum(answer_fear)+sum(answer_avoidance); sum(answer_fear); sum(answer_avoidance)]';


end

