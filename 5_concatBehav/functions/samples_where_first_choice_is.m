function [samples] = samples_where_first_choice_is(choice, all)

    tmp_all = all(:,2);
    tmp_chosen = all((all(:,5)==6) & (all(:,6)==choice),2);
    samples = all(ismember(tmp_all,tmp_chosen),:);

end