S = cell_dis;
t = td';
for i = 1:numel(S)
    figure(1)
    plot(t, S(i).Intensity,'-o')
    
    S(i).corrected_intensity = S(i).Intensity.*exp(Tbleach_avg*(t+ta(end)));
    f = fit(t,S(i).corrected_intensity,'exp1')
    figure(2)
    plot(t, S(i).corrected_intensity,'-o')
    hold on
    plot(f,t,S(i).corrected_intensity)
    hold off
    pause
end