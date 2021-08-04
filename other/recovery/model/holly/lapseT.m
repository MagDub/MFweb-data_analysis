function mo = lapseT(mo,idx_hor,idx_g,t,trials)


%% get params
% irreducible noise parameter xi
if length(mo.params.xi) > 1
    xi = mo.params.xi(idx_hor);
else
    xi = mo.params.xi;
end

if length(mo.params.xiT) > 1
    xiT = mo.params.xiT(idx_hor);
else
    xiT = mo.params.xiT;
end

%% data 
%pi = mo.mat.pi{idx_hor,idx_g}(:,t);

col_=[1,2,3,4,5,6];
col_num = col_(~isnan(mo.mat.pi{idx_hor,idx_g}(1,:))); %find the non nan column

%%%% Added
pi = nanmean(mo.mat.pi{idx_hor,idx_g},2); %Changed, the policy is not always in the last column
%%%%


%% add lapse
%pi = pi .* (1 - xi) + xi / 3;
doublexi = xi+(xiT*(trials-200.5)); % trial: 1:400 -> -199.5:199.5 (centralised)
pi = pi .* (1 - doublexi) + doublexi / 3;

%% Remake the matrix
pi_mat = nan(size(mo.mat.pi{idx_hor,idx_g},1),size(mo.mat.pi{idx_hor,idx_g}, 2));

if isempty(pi_mat(:,col_num))
    disp('que des nans')
    disp(col_num')
    disp('mo mat')
    mo.mat.pi{idx_hor,idx_g}(1,:)
    disp('all')
    mo.mat.pi{idx_hor,idx_g}(:,:)
end

pi_mat(:,col_num) = pi;

%% plug back to mo
mo.mat.pi{idx_hor,idx_g} = pi_mat; 
