
function [ASRS_all, ASRS_score_desc] = concat_ASRS_NADA()

    addpath('../3_questionnaires/concat_fct/')

    T = readtable('/Users/magdadubois/GoogleDrive/UCL/MF/questionnaires/asrs_prep.xlsx');

    for subj = 1:60

        ASRS_mat = [];

        ASRS_mat(1,:)  = T.asrs_01_a_finishing(subj);
        ASRS_mat(2,:)  = T.asrs_02_a_organization(subj);
        ASRS_mat(3,:)  = T.asrs_03_a_remembering(subj);
        ASRS_mat(4,:)  = T.asrs_04_a_delay(subj);
        ASRS_mat(5,:)  = T.asrs_05_a_fidget(subj);
        ASRS_mat(6,:)  = T.asrs_06_a_motor(subj);
        ASRS_mat(7,:)  = T.asrs_07_b_careless_mistakes(subj);
        ASRS_mat(8,:)  = T.asrs_08_b_keeping_attention(subj);
        ASRS_mat(9,:)  = T.asrs_09_b_concentrating(subj);
        ASRS_mat(10,:) = T.asrs_10_b_misplace_things(subj);
        ASRS_mat(11,:) = T.asrs_11_b_distraction(subj);
        ASRS_mat(12,:) = T.asrs_12_b_leaving_seat(subj);
        ASRS_mat(13,:) = T.asrs_13_b_restless(subj);
        ASRS_mat(14,:) = T.asrs_14_b_unwinding(subj);
        ASRS_mat(15,:) = T.asrs_15_b_talking_social(subj);
        ASRS_mat(16,:) = T.asrs_16_b_sentences(subj);
        ASRS_mat(17,:) = T.asrs_17_b_turn_taking(subj);
        ASRS_mat(18,:) = T.asrs_18_b_interrupt_others(subj);

        % Format: ASRS_mat = [item_no answer[1,5]]
        ASRS_mat = [(1:18)', ASRS_mat];

        % Compute score
        [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = compute_ASRS_score(ASRS_mat);

        % All subjects
        ASRS_all(subj,:) = ASRS_score;

    end

end