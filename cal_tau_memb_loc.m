function tau = cal_tau_memb_loc(memb_loc,t)
% compute association and dissociation coefficients usig exponential fit

tau = [];
[n,~] = size(memb_loc);

for i =1:n    
    % Exponential fit
    signal = memb_loc(i,:)';
    base = min(signal);
    f = fit(t, signal-base,'exp1','StartPoint',[max(signal-base),-.002]);
    
    % Plot the signal and the exponential fit
    plot(f, t, signal-base);
    
    % Store tau value
    tau = [tau; -1/f.b];
       
    pause
end