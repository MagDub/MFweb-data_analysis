function [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = concat_ASRS(quest)

n_items = 18; % number of items in the questionnaire
n_lett = 4; % number of letters of questionnaire name

space1 = 5;

start = find(quest=='A');

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

ASRS_mat_desc = {'Item', 'Response'};
ASRS_mat = [1:n_items; answer]';
ASRS_score_desc = {'TotalScore'};
ASRS_score = sum(answer);


end

