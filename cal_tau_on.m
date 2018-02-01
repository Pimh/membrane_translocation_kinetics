function [tau, norm_signal] = cal_tau_on(cell,t)
% Calculate membrane translocation kinetics based on change in intensity

fit_idx = 3:15;
tau = []; norm_signal = [];
for i = 1:numel(cell)
    
    signal = cell(i).Intensity(fit_idx); 
    base = min(signal);
    f = fit(t(fit_idx), signal-base,'exp1');
    plot(f, t(fit_idx), signal-base);
    
    tau = [tau; -1/f.b];
    
    norm_signal = [norm_signal; normalize_signal(signal)'];
    pause
end

function norm_signal = normalize_signal(signal)

maxs = max(signal);
mins = min(signal);
norm_signal = (signal-mins)/(maxs-mins);