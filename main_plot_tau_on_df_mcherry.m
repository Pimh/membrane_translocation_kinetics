% Plot tau on using change in cytosolic mcherry intensity
load('data_light_rep.mat')

% Calculate signal mean and s.d.
signal_avg = mean(norm_signal_light_rep_asso);
signal_std = std(norm_signal_light_rep_asso);
t = t_light_rep_asso(3:15);

% Plot average signal with errorbars
errorbar(t,signal_avg,signal_std,'o')
hold on
plot(fit_tau_on_cftool)
xlabel('time (s)')
ylabel('Norm. change in cytosolic mCherry intensity')

% Plot normalized signal (Shaded error)
figure()
addpath('boundedline')
boundedline(t,signal_avg,signal_std,'o');
hold on
plot(fit_tau_on_cftool)
xlabel('time (s)')
ylabel('Norm. membrane localization')
hold off
