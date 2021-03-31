function [row_, desc_] = fct_make_row_log(data_all)

    data_p = data_all.p_mat;
    data_s = data_all.slope_m;
    desc_row = data_all.bandit;

    row_ = {};
    for i=1:size(data_p,2)
        if data_p(i)<0.001
            row_{end+1,1} = strcat('b1=', num2str(data_s(i),2), ', p<0.001');
        else
            row_{end+1,1} = strcat('b1=', num2str(data_s(i),2), ', p=', num2str(data_p(i),2));
        end
    end
    
    desc_ = {};
    for i=1:size(desc_row,2)
        if desc_row(i)==-10
            desc_{end+1,1} = 'MediumValue';
        elseif desc_row(i)==10
            desc_{end+1,1} = 'HighValue';
        elseif desc_row(i)==3
            desc_{end+1,1} = 'Novel';
        elseif desc_row(i)==4
            desc_{end+1,1} = 'LowValue';
        elseif desc_row(i)==1
            desc_{end+1,1} = 'CertainStandard';
        elseif desc_row(i)==2
            desc_{end+1,1} = 'Standard';
        end
    end


end

