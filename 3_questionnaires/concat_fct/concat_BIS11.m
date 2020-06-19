function [BIS11_mat_desc, BIS11_mat, BIS11_score_desc, BIS11_score] = concat_BIS11(quest)

% Score: sum (52-71: normal; more: impulsive; less: over-controlled)

n_items = 30; % number of items in the questionnaire
n_lett = 5; % number of letters of questionnaire name

space1 = 5;

start = find(quest=='B');

question = {};
answer = [];

for n = 1:n_items
    if n < 10
       fin = start(n)+n_lett+1;
    else
       fin = start(n)+n_lett+2;
    end
    question{end+1} = quest(start(n):fin);
    fin = fin + space1;
    answer(end+1) = str2double(quest(fin));
end

BIS11_mat_desc = {'Item', 'Response'};
BIS11_mat = [1:n_items; answer]';
BIS11_score_desc = {'TotalScore'};
BIS11_score = sum(answer);


end

