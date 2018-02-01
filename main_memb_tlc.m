% Compute tau off based on membrane localization kinetic 
% Mask employed here is a line drawn across cell boundary/membrane

stack = 'light_repeated_1min_1_dissociation_mcherry.tif';
stack_mask = 'line_stack.tif';
addpath('images')
t = t_light_rep_disso;
t_length = length(t);

for i = 1:20 
    mat_profile{i} = timelapse_profile_line(stack,stack_mask,i);
    memb_loc(i,1:t_length) = cal_memb_translocation(mat_profile{i}, t);
end

tau = cal_tau_memb_loc(memb_loc,t);

% Select the signal with a good exponential fit
good_fit_idx = (tau > 0 & tau < 1000);
tau_off_fit = tau(good_fit_idx);

% Calculate tau off mean and SEM
tau_off_mean = mean(tau_off_fit);
tau_off_SEM = std(tau_off_fit)/sqrt(length(tau_off_fit));

% Normalize membrane localization signal
memb_loc_subtract = bsxfun(@minus, memb_loc, min(memb_loc,[],2));
range = (max(memb_loc,[],2)-min(memb_loc,[],2));
norm_memb_loc = bsxfun(@rdivide, memb_loc_subtract, range);

% Plot normalized membrane localization
signal_avg = mean(norm_memb_loc(good_fit_idx,:));
signal_std = std(norm_memb_loc(good_fit_idx,:));
errorbar(t, signal_avg,signal_std)
xlabel('time (s)')
ylabel('Norm. membrane localization')

% Plot normalized membrane localization (Shaded error)
figure()
addpath('boundedline')
boundedline(t,signal_avg,signal_std,'o');
hold on
plot(fittedmodelfit_avg_cftool)
xlabel('time (s)')
ylabel('Norm. membrane localization')
axis([0 600 0 1])
hold off
