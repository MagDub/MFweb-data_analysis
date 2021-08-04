
n_sim = 20000;
thompson_file = '/Users/magdadubois/MFweb/data/sim_recov/thompson_rand_part_values/';
out_dir = strcat(thompson_file, 'n_sim_', int2str(n_sim), '/');

aggregate_simResults_perHorMAP(out_dir)