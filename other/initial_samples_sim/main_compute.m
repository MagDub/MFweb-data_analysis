
clear;

user.params.n_blocks   = 4;    
user.params.n_trialPB  = 100;

for n_sim=1:1000

    [user] = apple_params(user);

    n = size(user.task.item,2);

    initial_samples_meansACD = [];
    initial_samples_meansBCD = [];
    initial_samples_meansABC = [];
    initial_samples_meansABD = [];
    
    apple1ACD = [];
    apple1BCD = [];
    apple1ABC = [];
    apple1ABD = [];

    for i=1:n

        tmp_UnusedTree = user.task.item(i).unused_tree;
        tmp_InitialAppleSize = user.task.item(i).initial_apples.size;
        tmp_InitialAppleTree = user.task.item(i).initial_apples.tree;
        tmp_Apple1Size = user.task.item(i).future_apples.tree(:,1)';

        ind_A = find(tmp_InitialAppleTree==1);
        ind_B = find(tmp_InitialAppleTree==2);
        ind_C = find(tmp_InitialAppleTree==3);
        ind_D = find(tmp_InitialAppleTree==4);

        if ~isempty(ind_A)
            meanA = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==1)));
            if isempty(ind_B)
                meanHVA = meanA;
                meanHVB = nan;
            else 
                tmp_meanB = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==2)));
                [~, ind_m] = max([meanA, tmp_meanB]);
                if ind_m == 1
                    meanHVA = meanA;
                    meanHVB = nan;
                elseif ind_m == 2
                    meanHVA = nan;
                    meanHVB = tmp_meanB;
                end
            end
        else
            meanA = nan;
            meanHVA = nan;
        end

        if ~isempty(ind_B)
            meanB = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==2)));
            if isempty(ind_A)
                meanHVB = meanB;
                meanHVA = nan;
            else 
                tmp_meanA = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==1)));
                [~, ind_m] = max([tmp_meanA, meanB]);
                if ind_m == 2
                    meanHVB = meanB;
                    meanHVA = nan;
                elseif ind_m == 1
                    meanHVB = nan;
                    meanHVA = tmp_meanA;
                end
            end
        else
            meanB = nan;
            meanHVB = nan;
        end

        if ~isempty(ind_C)
            meanC = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==3)));
        else
            meanC = nan;
        end

        if ~isempty(ind_D)
            meanD = mean(tmp_InitialAppleSize(find(tmp_InitialAppleTree==4)));
        else
            meanD = nan;
        end

        if tmp_UnusedTree == 1
            initial_samples_meansBCD(end+1,:) = [meanA, meanB, meanC, meanD];
            apple1BCD(end+1,:) = tmp_Apple1Size;
        elseif tmp_UnusedTree == 2
            initial_samples_meansACD(end+1,:) = [meanA, meanB, meanC, meanD];
            apple1ACD(end+1,:) = tmp_Apple1Size;
        elseif tmp_UnusedTree == 3
            initial_samples_meansABD(end+1,:) = [meanA, meanB, meanC, meanD, meanHVA, meanHVB];
            apple1ABD(end+1,:) = tmp_Apple1Size;
        elseif tmp_UnusedTree == 4
            initial_samples_meansABC(end+1,:) = [meanA, meanB, meanC, meanD, meanHVA, meanHVB];
            apple1ABC(end+1,:) = tmp_Apple1Size;
        end

    end

    averageBCD = nanmean(initial_samples_meansBCD,1);
    averageACD = nanmean(initial_samples_meansACD,1);
    averageABD = nanmean(initial_samples_meansABD,1);
    averageABC = nanmean(initial_samples_meansABC,1);
    
    averageBCD_app1 = mean(apple1BCD,1);
    averageACD_app1 = mean(apple1ACD,1);
    averageABD_app1 = mean(apple1ABD,1);
    averageABC_app1 = mean(apple1ABC,1);

    avA(n_sim,:) = [averageBCD(1), averageACD(1), averageABD(1), averageABC(1)];
    avB(n_sim,:) = [averageBCD(2), averageACD(2), averageABD(2), averageABC(2)];
    avD(n_sim,:) = [averageBCD(4), averageACD(4), averageABD(4), averageABC(4)];
    avHVA(n_sim,:) = [averageBCD(2), averageACD(1), averageABD(5), averageABC(5)];
    avHVB(n_sim,:) = [averageBCD(1), averageACD(2), averageABD(6), averageABC(6)];
    
    avA_app1(n_sim,:) = [averageBCD_app1(1), averageACD_app1(1), averageABD_app1(1), averageABC_app1(1)];
    avB_app1(n_sim,:) = [averageBCD_app1(2), averageACD_app1(2), averageABD_app1(2), averageABC_app1(2)];
    avC_app1(n_sim,:) = [averageBCD_app1(3), averageACD_app1(3), averageABD_app1(3), averageABC_app1(3)];
    avD_app1(n_sim,:) = [averageBCD_app1(4), averageACD_app1(4), averageABD_app1(4), averageABC_app1(4)];

end

initial_samples.avA = avA;
initial_samples.avB = avB;
initial_samples.avD = avD;
initial_samples.HVA = avHVA;
initial_samples.HVB = avHVA;

apple_1.avA = avA_app1;
apple_1.avB = avB_app1;
apple_1.avC = avC_app1;
apple_1.avD = avD_app1;

save('initial_samples.mat', 'initial_samples');
save('apple_1.mat', 'apple_1');




