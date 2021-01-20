function plot_correlation_perHor(out_dir)

    algo = 'thompson';
    
    sim_dir = strcat(out_dir,'results/');
    
    list_ = dir([sim_dir '*' '_sim_' algo '*_results.mat']);
    n_junks = length(list_);
    tmp = load([sim_dir list_(1).name]);
    load([out_dir '/out_sim_' algo '.mat'])
    
    tmp.settings.params.param_names = {'\sigma_0_,_1', '\sigma_0_,_2', 'Q_0','\epsilon_1', '\epsilon_2', '\eta_1', '\eta_2'};
    
    
    for j = 1:length(out.fitted(tmp.ID,:))
        corr_plot = figure(j);
        annotation('textbox', [0 0.9 1 0.1], ...
        'String', [tmp.settings.params.param_names{j}], ...
        'EdgeColor', 'none', ...
        'HorizontalAlignment', 'center')
        y_legends{j} = tmp.settings.params.param_names{j};
        for i = 1:length(out.fitted(tmp.ID,:))
            subplot(2,4,i)
            plot(out.org(:,i),out.fitted(:,j),'.')
            xlabel('original param')
            ylabel('fitted param')
            rho = corr(out.org(:,i),out.fitted(:,j), 'rows','complete', 'Type','Pearson');
            parameter_recov_mat(i,j) = rho;
            x_legends{i} = tmp.settings.params.param_names{i};
            title([tmp.settings.params.param_names{i} ': rho=' num2str(rho)])
        end
        saveas(corr_plot, strcat(out_dir,'corr_plot_', int2str(j),'.png'))
        save(strcat(out_dir,'corr_plot_', int2str(j),'.mat'), 'corr_plot');
    end

    corr_mat=figure();
    imagesc(abs(parameter_recov_mat))
    xticks([1 2 3 4 5 6 7])
    xlabel('Fitted parameters')
    xticklabels({x_legends{1}, x_legends{2}, x_legends{3}, x_legends{4}, x_legends{5}, x_legends{6}, x_legends{7}})
    yticks([1 2 3 4 5 6 7])
    ylabel('Original parameters')
    yticklabels({x_legends{1}, x_legends{2}, x_legends{3}, x_legends{4}, x_legends{5}, x_legends{6}, x_legends{7}})
    colorbar('Ticks',[0:0.25:1]); 
    caxis([0 1])
    textStrings = num2str(parameter_recov_mat(:), '%0.2f');       % Create strings from the matrix values
    textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
    [x, y] = meshgrid(1:7);  % Create x and y coordinates for the strings
    hStrings = text(x(:), y(:), textStrings(:), ...  % Plot the strings
                    'HorizontalAlignment', 'center');
    midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range
%     title(strcat('Parameter recovery - ' ,32, algo, ' - ',32, int2str(n_per_dim),  ' per dim - Pearson - Kalman filter')) 
    saveas(corr_mat,strcat(out_dir,'corr_mat.png'))
    save(strcat(out_dir,'corr_mat.fig'), 'corr_mat');

end