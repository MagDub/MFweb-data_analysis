
% General

% TODO: problem with 3 5 and 6
for user = 3
    
    addpath('./concat_fct/')
    path_ = '../../data/raw/';

    T = readtable(strcat(path_,'user_',num2str(user),'/questionnaires/questionnaires_id_1.xls'));

    % Compute reaction times

    % RT in milliseconds (divide by 1000 -> seconds)
    tmp_0 = str2double(T.PageNo0);
    tmp_1 = str2double(T.PageNo1);
    tmp_2 = str2double(T.PageNo2);

    RT_LSAS = tmp_1 - tmp_0; % ??
    RT_ASRS = tmp_2 - tmp_1; % ??


    % Concatenate questionnaires

    %% NOT OK !

    % ASRS: Adult ADHD self-report scale 
    % Problem with items: Order of items does not match theory
    % Ask Tobi or Johanna 
    % score: sum (higher: more ADHD)
    [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = concat_ASRS(T.ASRS{1});

    % OCIR: OCD
    % Score: Sum (recommended cutoff: 21)
    % Problem with data saving
    %[OCIR_mat_desc, OCIR_mat, OCIR_score_desc, OCIR_score] = concat_OCIR(T.OCIR{1});

    % STAI: State-Trait Anxiety Inventory (we only do trait)
    % Problem with data saving
    % Score: Need to reverse some. See PDF. 
    %[STAI_mat_desc, STAI_mat, STAI_score_desc, STAI_score] = concat_STAI(T.STAI{1});


    %% OK 

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

end



