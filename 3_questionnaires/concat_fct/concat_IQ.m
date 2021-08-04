function [score, percentage] = concat_IQ(T)



IQmat = [str2double(T.IQ_1), str2double(T.IQ_2), str2double(T.IQ_3), str2double(T.IQ_4), ...
            str2double(T.IQ_5),str2double(T.IQ_6), str2double(T.IQ_7), str2double(T.IQ_8), ...
            str2double(T.IQimage_1), str2double(T.IQimage_2), str2double(T.IQimage_3), ...
            str2double(T.IQimage_4), str2double(T.IQimage_5), str2double(T.IQimage_6), ...
            str2double(T.IQimage_7), str2double(T.IQimage_8)];

score = 0;    

if (IQmat(1)==4)
    score = score + 1;
end

if (IQmat(2)==4)
    score = score + 1;
end

if (IQmat(3)==4)
    score = score + 1;
end

if (IQmat(4)==6)
    score = score + 1;
end

if (IQmat(5)==6) %
    score = score + 1;
end

if (IQmat(6)==3)      
    score = score + 1;
end

if (IQmat(7)==4)      
    score = score + 1;
end

if (IQmat(8)==4)      
    score = score + 1;
end

if (IQmat(9)==5)      
    score = score + 1;
end

if (IQmat(10)==2)      
    score = score + 1;
end

if (IQmat(11)==2)      
    score = score + 1;
end

if (IQmat(12)==4)      
    score = score + 1;
end


if (IQmat(13)==3)      
    score = score + 1;
end

if (IQmat(14)==2)      
    score = score + 1;
end


if (IQmat(15)==6)      
    score = score + 1;
end

if (IQmat(16)==7)      
    score = score + 1;
end

percentage = score / size(IQmat,2) * 100;

end

