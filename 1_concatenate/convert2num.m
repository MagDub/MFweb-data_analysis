function [data_mat] = convert2num(data_str)

tmp = str2mat(data_str);

data_mat = [];
j=1;

while j<size(tmp,2)
    
    if ~isnan(str2double(tmp(j)))
        if isnan(str2double(tmp(j+1)))
            data_mat(end+1) = str2double(tmp(j));
            
        elseif ~isnan(str2double(tmp(j+1)))
            if isnan(str2double(tmp(j+2)))
                data_mat(end+1) = str2double(tmp(j:j+1));
                j=j+1;
                
            elseif ~isnan(str2double(tmp(j+2)))
                if isnan(str2double(tmp(j+3)))
                    data_mat(end+1) = str2double(tmp(j:j+2));
                    j=j+2;
                    
                elseif ~isnan(str2double(tmp(j+3)))
                    if isnan(str2double(tmp(j+4)))
                        data_mat(end+1) = str2double(tmp(j:j+3));
                        j=j+3;
                        
                    elseif ~isnan(str2double(tmp(j+4)))
                        if isnan(str2double(tmp(j+5)))
                            data_mat(end+1) = str2double(tmp(j:j+4));
                            j=j+4;
                            
                        elseif ~isnan(str2double(tmp(j+5)))
                            if isnan(str2double(tmp(j+6)))
                                data_mat(end+1) = str2double(tmp(j:j+5));
                                j=j+5;
                                
                            elseif ~isnan(str2double(tmp(j+6)))
                                if isnan(str2double(tmp(j+7)))
                                    data_mat(end+1) = str2double(tmp(j:j+6));
                                    j=j+6;
                                    
                              elseif ~isnan(str2double(tmp(j+7)))
                                    if isnan(str2double(tmp(j+8)))
                                        data_mat(end+1) = str2double(tmp(j:j+7));
                                        j=j+7;

                                    end  
                                end                            
                            end
                        end
                    end
                end
            end
        end
    end
    j=j+1;
end


end

