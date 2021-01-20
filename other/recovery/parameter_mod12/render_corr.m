function [] = render_corr(fitted, generated, param_bounds, ticks_, title_, letter, legend_position)

col = [0.39215686917305 0.474509805440903 0.635294139385223];

set(gca,'TickLabelInterpreter','tex')

b = plot(0.5,0.5,'w*'); hold on;
plot(fitted, generated,'o','MarkerEdgeColor',col); hold on;
plot([-12 12],[-12 12],':k')
r = corr(fitted,generated, 'rows','complete', 'Type','Pearson');
l = legend([b],strcat('r =',32, num2str(round(r,2)))); legend boxoff;
set(l,'Position',legend_position, 'FontSize',16);

xlim([param_bounds(1) param_bounds(2)])
ylim([param_bounds(1) param_bounds(2)])
xticks([ticks_])
yticks([ticks_])

ylabel('Original value','FontName','Arial','Fontweight','bold','FontSize',12);
xlabel('Fitted value','FontName','Arial','Fontweight','bold','FontSize',12);

% Number and title
text(0-0.2, 1+0.2,letter,'Units', 'Normalized', 'VerticalAlignment', 'Top','FontSize', 26)     
title(title_,'FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

set(gca,'box','off')

end

