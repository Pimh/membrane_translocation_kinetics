function [tau, norm_signal] = cal_tau_off(cell,t)
% Calculate membrane dissociation kinetics based on change in intensity

tau_bleach = 993.5;
fit_idx = 1:length(t);
tau = []; norm_signal = [];
for i = 1:numel(cell)
    
    signal = cell(i).Intensity(fit_idx);
    %signal = cell(i).PCC(fit_idx)';
    plot(t(fit_idx), signal)
    hold on
    pause
    
    corrected_signal = correct_bleaching(signal,t(fit_idx),tau_bleach);
    plot(t(fit_idx), corrected_signal)
    hold off
    
    s_max = max(corrected_signal);
    f = fit(t(fit_idx), corrected_signal-s_max,'exp1');
    plot(f, t(fit_idx), corrected_signal-s_max);
    title(i)
    
    tau = [tau; -1/f.b];
    
    norm_signal = [norm_signal; normalize_signal(corrected_signal)'];
    pause
end

function correctec_signal = correct_bleaching(signal,t,tau)

correctec_signal = signal.*exp(t/tau);

function norm_signal = normalize_signal(signal)

maxs = max(signal);
mins = min(signal);
norm_signal = (signal-mins)/(maxs-mins);