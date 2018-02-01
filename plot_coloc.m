function plot_coloc(corr)
% plot time-series co-localization of two proteins 

line_spec = {'-'};
colr = {'r','g','b','m','c','y','k' };
t_intv = 20; %seconds
ncell = numel(corr);

selected_cells = [1,7,14,15,18,19];

for i = 1:ncell
    
    if sum(i == selected_cells)
        n_time = length(corr(i).PCC);
        time = (0:n_time-1)*t_intv;
        plot_spec = [line_spec{1} colr{rem(i,7)+1}];

        figure(1)
        title('Pearsons correlation coefficient (PCC)','FontSize',14)
        xlabel('Time (s)','FontSize',14)
        ylabel('PCC','FontSize',14)
        plot(time, corr(i).PCC, plot_spec,'LineWidth',1);
        axis([0 620 0 1])
        hold on

        disp(i)
        pause()
    end
end
