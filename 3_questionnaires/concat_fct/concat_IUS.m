function [IUS_mat_desc, IUS_mat, IUS_score_desc, IUS_score] = concat_IUS(quest)

n_items = 27; % number of items in the questionnaire
n_lett = 3; % number of letters of questionnaire name
first_letter = 'I';

space1 = 5;

start = find(quest==first_letter);

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

IUS_mat_desc = {'Item', 'Response'};
IUS_mat = [1:n_items; answer]';
IUS_score_desc = {'TotalScore'};
IUS_score = sum(answer);


end

