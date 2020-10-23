function [ EF ] = compute_ef_paired( data1, data2)

    diff = data1-data2;

    EF = mean(diff) / std(diff);

end

