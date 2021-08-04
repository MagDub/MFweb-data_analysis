function [ EF ] = compute_ef_m(m1,m2,std1,std2)

stdpooled = sqrt((std1^2+std2^2)/2);

EF = abs(m1-m2) / stdpooled;

end

