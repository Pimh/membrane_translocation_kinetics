function memb_loc = cal_memb_translocation(profile, t)
% Calculate the ratio of membrane localized protein 

[tidx,n] = size(profile);

% Define membrane location
memb_idx = 7:17;
memb_width = 10;

for i = 1:tidx
    int_tot = sum(profile(i,:));
    profile_norm = profile(i,:)/int_tot;
    
    if i > 4
        [m,idx] = max(profile_norm);
        if ((m - min(profile_norm)) > 0.01) & (idx < n-(memb_width/2))...
                & (idx > 1+(memb_width/2))
            memb_idx = idx-(memb_width/2):idx+(memb_width/2);
        end
    end   
    memb_loc(i) = sum(profile_norm(memb_idx));
    
    % Plot normalized profile
    plot(profile_norm)
    hold on
    plot([memb_idx(1) memb_idx(1)],[0 0.5],':k')
    plot([memb_idx(end) memb_idx(end)],[0 0.5],':k')
    title(i)
    axis([0 n 0.01 0.06])
    hold off
    pause
end

% Plot degree of membrane localizaiton
plot(t, memb_loc,'o')