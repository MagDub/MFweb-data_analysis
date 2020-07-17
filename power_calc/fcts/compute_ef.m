function [ EF ] = compute_ef( data1, data2)

m1 = mean(data1);
m2 = mean(data2);

std1 = std(data1);
std2 = std(data2);

stdpooled = sqrt((std1^2+std2^2)/2);

EF = abs(m1-m2) / stdpooled;

end

