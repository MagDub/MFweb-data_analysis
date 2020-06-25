function [STAI_mat_desc, STAI_mat, STAI_score_desc, STAI_score] = concat_STAI(quest)

n_items = 20; % number of items in the questionnaire
n_lett = 4; % number of letters of questionnaire name
first_letter = 'S';

space1 = 5;

start = find(quest==first_letter);

question = {};
answer = [];

for n = 1:n_items
    if isnan(str2double(quest(start(n)+n_lett+2)))
       fin = start(n)+n_lett+1;
    else
       fin = start(n)+n_lett+2;
    end
    tmp = quest(start(n):fin);
    item_no(n) = str2double(tmp(n_lett+2:end));
    fin = fin + space1;
    answer(end+1) = str2double(quest(fin));
end

STAI_mat_desc = {'Item', 'Response'};
STAI_mat = [item_no; answer]';
STAI_mat = sortrows(STAI_mat,1);

STAI_score_desc = {'TotalScore'};
STAI_score = sum(answer);


end

