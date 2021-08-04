function [data] = generate_behaviour(mo, settings, data)

    % loop through trials (and conditions) to generate behaviour
    for c = 1:settings.task.N_hor
        for g = 1:settings.task.Ngames_per_hor         

            % data
            tmp_dat = data(c,g);

            % Added
            mo.mat.appleA{c,g} = tmp_dat.a;
            mo.mat.appleB{c,g} = tmp_dat.b;
            mo.mat.appleD{c,g} = tmp_dat.d;

            if tmp_dat.unshown_tree == 1
                tmp_dat = rmfield(tmp_dat,'a');
            elseif tmp_dat.unshown_tree == 2
                tmp_dat = rmfield(tmp_dat,'b');
            elseif tmp_dat.unshown_tree == 3
                tmp_dat = rmfield(tmp_dat,'c');
            elseif tmp_dat.unshown_tree == 4
                tmp_dat = rmfield(tmp_dat,'d');
            end

            % loop through trials of game
            for t = 1:size(tmp_dat.alltrees,1)+1 
                if t == 1 % plug in priors
                    mo.mat.Q{c,g}(:,t) = mo.params.Q0(1);
                    mo.mat.sgm{c,g}(:,t) = mo.params.sgm0(c);
                end

                % see outcome and learn
                if t <= size(tmp_dat.alltrees,1) 
                    mo = mo.funs.learningfun(mo,tmp_dat,c,g,t);
                else
                    % calculate values & policy
                    mo = mo.funs.valuefun(mo,c,g,t);

                        % add lapse if needed
                        if ~isempty(mo.params.xi) 
                            mo = lapse(mo,c,g,t);
                        end
                end
            end

            % make choice based on policy
            tmp_pi = nanmean(mo.mat.pi{c,g},2); 
            r = rand(1);    % random choice seed
            tmp_cPi = cumsum(tmp_pi);
            tmp_chosen = find(tmp_cPi>=r,1,'first');

            if isempty(tmp_chosen)
                disp('tmp_chosen is empty in test_3_params')
            end

            if data(c,g).unshown_tree == 1
                tree_vec = [2, 3, 4];
            elseif data(c,g).unshown_tree == 2
                tree_vec = [1, 3, 4];
            elseif data(c,g).unshown_tree == 3
                tree_vec = [1, 2, 4];
            elseif data(c,g).unshown_tree == 4
                tree_vec = [1, 2, 3];
            end

            data(c,g).chosen = tree_vec(tmp_chosen); % Changed       
        end
    end
    

end

