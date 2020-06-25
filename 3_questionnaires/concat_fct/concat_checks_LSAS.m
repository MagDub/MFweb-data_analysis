function [passed, check_mat, check_mat_desc] = concat_checks_LSAS(quest, n_items)

first_non_repeating_letter = 'H';
start = find(quest==first_non_repeating_letter)-1; % minus 1 because it starts at 'C'
 
n_lett = 5; % number of letters in name

space1 = 13;
space2 = 16;

question = {};
checkID_quest = [];
checkID_fear = [];
checkID_avoidance = [];

for n = 1:n_items
    
    fin = start(n)+n_lett+1;
    tmp = quest(start(n):fin);
    item_no(n) = str2double(tmp(n_lett+2:end));
    checkID_quest(end+1) = str2double(quest(fin));
    fin = fin + space1;
    checkID_fear(end+1) = str2double(quest(fin));
    fin = fin + space2;
    checkID_avoidance(end+1) = str2double(quest(fin));
    
end

check_mat_desc = {'checkID', 'fear_response', 'avoidance_response'};
check_mat = [checkID_quest', checkID_fear', checkID_avoidance'];

passed = 0;

for i = 1:size(check_mat,1)
    if (check_mat(i,1) == check_mat(i,2)) && (check_mat(i,1) == check_mat(i,3))
        passed = passed+1;
    end
end

passed = passed / size(check_mat,1);

end

