function [OCIR_mat_desc, OCIR_mat, OCIR_score_desc, OCIR_score] = concat_OCIR(quest)

n_items = 18; % number of items in the questionnaire
n_lett = 4; % number of letters of questionnaire name
first_letter = 'O';

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

OCIR_mat_desc = {'Item', 'Response'};
OCIR_mat = [item_no; answer]';
OCIR_mat = sortrows(OCIR_mat,1);

OCIR_score_desc = {'TotalScore'};
OCIR_score = sum(answer);


end

