function [hist_data_short, hist_data_long] = make_hist_data(mat_data)

hist_data_short = [];
hist_data_long = [];

for i=1:size(mat_data,1)
    if mat_data(i,3) == 6
        hist_data_short(end+1) = mat_data(i,end-2);
    elseif mat_data(i,3) == 11
        hist_data_long(end+1) = mat_data(i,end-2);
    end
end


end
