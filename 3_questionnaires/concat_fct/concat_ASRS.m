function [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = concat_ASRS(quest)

n_items = 18; % number of items in the questionnaire
n_lett = 4; % number of letters of questionnaire name

space1 = 5;

start = find(quest=='A');

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

ASRS_mat = [item_no; answer]';
ASRS_mat = sortrows(ASRS_mat,1);

[ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = compute_ASRS_score(ASRS_mat);

end

