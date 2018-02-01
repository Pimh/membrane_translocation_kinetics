% Compute tau ON based on membrane localization kinetic 
% Mask employed here is a line drawn across cell boundary/membrane

stack = 'light_repeated_1min_1_association_mcherry.tif';
stack_mask = 'line_stack.tif';
addpath('images')
t = t_light_rep_asso;
t_length = length(t);

for i = 1:20 
    mat_profile{i} = timelapse_profile_line(stack,stack_mask,i);
    memb_loc(i,1:t_length) = cal_memb_translocation(mat_profile{i}, t);
end

% Normalize membrane localization signal
memb_loc_subtract = bsxfun(@minus, memb_loc, min(memb_loc,[],2));
range = (max(memb_loc,[],2)-min(memb_loc,[],2));
norm_memb_loc = bsxfun(@rdivide, memb_loc_subtract, range);

% Compute tau on
idx_fit = 3:15;
norm_memb_loc_corrected = bsxfun(@minus, 1, norm_memb_loc);
tau = cal_tau_memb_loc(norm_memb_loc_corrected(:,idx_fit),t(idx_fit));

% Select the signal with a good exponential fit
good_fit_idx = (tau > 0 & tau < 40);
tau_on_fit = tau(good_fit_idx);

% Calculate tau on mean and SEM
tau_on_mean = mean(tau_on_fit);
tau_on_SEM = std(tau_on_fit)/sqrt(length(tau_on_fit));

% Plot normalized membrane localization
signal_avg = mean(norm_memb_loc(good_fit_idx,:));
signal_std = std(norm_memb_loc(good_fit_idx,:));
errorbar(t, signal_avg,signal_std,'o')
hold on
plot(fit_tau_on_cftool,t(idx_fit), signal_avg(idx_fit))
xlabel('time (s)')
ylabel('Norm. membrane localization')
axis([0 70 -.1 1.1])
hold off

% Plot normalized membrane localization (Shaded error)
figure()
addpath('boundedline')
boundedline(t,signal_avg,signal_std,'o');
hold on
plot(fit_tau_on_cftool,t(idx_fit), signal_avg(idx_fit))
xlabel('time (s)')
ylabel('Norm. membrane localization')
axis([0 70 0 1])
hold off