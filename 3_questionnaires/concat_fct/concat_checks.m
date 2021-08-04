function [passed, check_mat, check_mat_desc] = concat_checks(quest, n_items)

first_non_repeating_letter = 'H';
start = find(quest==first_non_repeating_letter)-1; % minus 1 because it starts at 'C'
 
n_lett = 5; % number of letters in name

space1 = 5;

checkID_str = {};
checkID = [];
answer = [];

for n = 1:n_items
    
    fin = start(n)+n_lett+1;
    checkID_str{end+1} = quest(start(n):fin);
    checkID(end+1) = str2double(quest(fin));
    fin = fin + space1;
    answer(end+1) = str2double(quest(fin));
    
end

check_mat_desc = {'checkID', 'Response'};
check_mat = [checkID; answer]';

passed = 0;

for i = 1:size(check_mat,1)
    if check_mat(i,1) == check_mat(i,2)
        passed = passed+1;
    end
end

passed = passed / size(check_mat,1);

end

