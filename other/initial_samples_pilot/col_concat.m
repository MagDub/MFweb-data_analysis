function [ col_ ] = col_concat( means_split_av, means_split_sd, min_split_tot, max_split_tot )

    for i = 1:size(means_split_av,2)
        col_(i,:) = {strcat(num2str(means_split_av(i),3),'(', num2str(means_split_sd(i),2),') [', num2str(min_split_tot(i),3),',', num2str(max_split_tot(i),3),']')};
    end

end

