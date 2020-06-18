function [mat, new_mat] = aggregate_for_plot(mat_)

    mat(:,1) = mat_(:,1) - mat_(:,2) + 10; % to avoid problems of negative numbers and 0
    mat(:,2) = (mat_(:,1) + mat_(:,2)) / 2;
    mat(:,3:4) = mat_(:,3:4);

    mat = sortrows(mat,1);
    mat = round(mat);

    uc1 = unique(mat(:,1));
    mc2 = accumarray(mat(:,1), mat(:,4), [], @mean ) ;
    mc3 = accumarray(mat(:,1), mat(:,4), [], @var ) ;
    new_mat = [uc1, mc2(uc1), sqrt(mc3(uc1))];
    
    new_mat(:,1) = new_mat(:,1)-10; %subtract the 10 we added
    mat(:,1) = mat(:,1)-10; 
    
    for i = 1:size(new_mat,1)
        new_mat(i,4) = sum(mat(:,1) == new_mat(i,1));
    end

    % new mat short
    % 1: difference between B and D
    % 2: mean RT
    % 3: std RT
    % 4: occurences

    new_mat = round(new_mat);

end
