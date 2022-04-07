function save_sim(results_dir, ID, settings, data, gameIDs, para_vals, mo)

    save([results_dir 'sim_data_' int2str(ID) '.mat'],'data','gameIDs');
    save([results_dir 'sim_' int2str(ID) '.mat'],'settings','data','mo','gameIDs','para_vals');
    
end

