function new = nan_padding(mat)

new = nan(21,size(mat,2)); new(:,1) = -10:10; 

for i=1:size(new,1)
    for j=1:size(mat)
        if new(i,1) == mat(j,1)
            new(i,:) = mat(j,:);
        end
    end
end

end
