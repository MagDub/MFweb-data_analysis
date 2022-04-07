function [samples] = samples_where_first_choice_is_HM(choice, all)

    tmp_all = all(:,2);
    tmp_chosen = all((all(:,5)==6) & (all(:,10)==choice),2);
    samples = all(ismember(tmp_all,tmp_chosen),:);

end