
% General

usermat = [2,4,5,6];

for i=1:length(usermat)
        
    userID = usermat(i);
    
    disp(['userID:', 32, num2str(userID)])
    
    addpath('./concat_fct/')
    path_ = '../../data/raw/';
    
    path_quest = strcat(path_,'user_',num2str(userID),'/questionnaires/');
    list_q = dir(strcat(path_quest,'*.xls'));
    
    if length(list_q)~=1
        disp('many questionnaire file: PROBLEM')
    end
    
    T = readtable(strcat(path_quest,list_q.name));

    % Compute reaction times: RT in milliseconds (divide by 1000 -> seconds)
    tmp = [str2double(T.PageNo0), str2double(T.PageNo1), str2double(T.PageNo2)...
        str2double(T.PageNo3), str2double(T.PageNo4), str2double(T.PageNo5),...
        str2double(T.PageNo6), str2double(T.PageNo7), str2double(T.PageNo8), str2double(T.PageNo9)];

    n_quest = 8;
    RT_quest=[];
    
    for q = 1: n_quest
        RT_quest(end+1) = tmp(q+1) - tmp(q); 
    end
    
    RT_quest_desc={'ASRS', 'BIS11', 'OCIR', 'IUS', 'SDS', 'STAI', 'IQ', 'IQim'};
    
    RT_quest_mat(i,:) = RT_quest; % All participants

    % ASRS: Adult ADHD self-report scale 
    % Problem with items: Order of items does not match theory
    % score: sum (higher: more ADHD)
    [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = concat_ASRS(T.ASRS{1});

    % OCIR: OCD
    % Score: Sum (recommended cutoff: 21)
    [OCIR_mat_desc, OCIR_mat, OCIR_score_desc, OCIR_score] = concat_OCIR(T.OCIR{1});

    % STAI: State-Trait Anxiety Inventory (we only do trait)
    % Score: Need to reverse some. See PDF. 
    [STAI_mat_desc, STAI_mat, STAI_score_desc, STAI_score] = concat_STAI(T.STAI{1});

    % BIS11
    [BIS11_mat_desc, BIS11_mat, BIS11_score_desc, BIS11_score] = concat_BIS11(T.BIS11{1});

    % IUS
    [IUS_mat_desc, IUS_mat, IUS_score_desc, IUS_score] = concat_IUS(T.IUS{1});

    % LSAS: Liebowitz Social Anxiety Scale
    [LSAS_mat_desc, LSAS_mat, LSAS_score_desc, LSAS_score] = concat_LSAS(T.LSAS{1});

    % SDS: Zung Self Rating Depression Scale
    [SDS_mat_desc, SDS_mat, SDS_score_desc, SDS_score] = concat_SDS(T.SDS{1});

    % IQ
    [score, percentage] = concat_IQ(T);

    % Checks
    [~, check_mat_ASRS, ~] = concat_checks(T.ASRS{1}, 1);
    [~, check_mat_BIS11, ~] = concat_checks(T.BIS11{1}, 2);
    [~, check_mat_OCIR, ~] = concat_checks(T.OCIR{1}, 1);      
    [~, check_mat_IUS, ~] = concat_checks(T.IUS{1}, 2);
    [~, check_mat_SDS, ~] = concat_checks(T.SDS{1}, 1);
    [~, check_mat_STAI, ~] = concat_checks(T.STAI{1}, 1);
    [~, check_mat_LSAS, ~] = concat_checks_LSAS(T.LSAS{1}, 2);

    check_mat = [check_mat_ASRS;check_mat_BIS11; check_mat_OCIR; check_mat_IUS; check_mat_SDS; check_mat_STAI];

    passed = 0;

    for k = 1:size(check_mat,1)
        if check_mat(k,1) == check_mat(k,2)
            passed = passed+1;
        end
    end

    % LSAS check
    for j = 1:size(check_mat_LSAS,1)
        if (check_mat_LSAS(j,1) == check_mat_LSAS(j,2)) && (check_mat_LSAS(j,1) == check_mat_LSAS(j,3))
            passed = passed+1;
        end
    end

    passed_perc = passed / (size(check_mat,1)+2);

    disp(['passed_perc:', 32, num2str(passed_perc*100), '%'])
    
    % Compute total time spend
    start_time = T.UserStartTime{1};
    finish_time = T.QuestionnaireFinishTime{1};

    t1={strcat('01-Oct-2011',32,start_time(1:8))};
    t2={strcat('01-Oct-2011',32,finish_time(1:8))};

    if etime(datevec(datenum(t2)),datevec(datenum(t1)))<0
        t2={strcat('02-Oct-2011',32,finish_time(1:8))};
    end

    time_interval_in_seconds = etime(datevec(datenum(t2)),datevec(datenum(t1)));
    time_interval_in_hours = time_interval_in_seconds/3600;

    disp(['hours spent:', 32, num2str(time_interval_in_hours)])
    
    % task check
    load(strcat('../../data/concat_data/user_',num2str(userID),'.mat'))
    
    disp(['task info request:', 32, num2str(user.log(1,19))])
    
    task_InfoRequestNo_mat(i) = user.log(1,19);
    
    disp('----------------------')

end

for q_num = 1:8
    subplot(4,2,q_num)
    plot(RT_quest_mat(:,q_num)/(1000*60), 'o')
    grid on;
    xlim([0 length(usermat)+1])
    xticks(1:1:length(usermat))
    xticklabels(usermat)
    xlabel('user')
    ylabel('time (min)')
    title(RT_quest_desc(q_num))
end


