function [] = render_sim_points(generated, param_bounds, ticks_, title_, letter, legend_position, mean_, std_, max_freq)

col = [0.39215686917305 0.474509805440903 0.635294139385223];

set(gca,'TickLabelInterpreter','tex')

histogram(generated, 30, 'FaceColor',col); hold on;
m = plot(mean_*ones(size(0:100:20000,2),1), 0:100:20000);
b = plot(100,1,'w*'); hold on;

l = legend([m, b],{strcat('mean= ', num2str(round(mean_,3))),...
    strcat(32,32,'(std=', num2str(round(std_,3)), ')')}); legend boxoff;
set(l,'Position',legend_position, 'FontSize',12);

xlim([param_bounds(1) param_bounds(2)])
ylim([0 max_freq])
xticks([ticks_])


% Number and title
text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)     
title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

set(gca,'box','off')

end

