function polarfun(cpx)
     p = polarplot(cpx, '-', 'LineWidth', 2);
     p.Color
     hold on;
     % arrows depicted 
     if (length(cpx) > 1)
         for i=2:length(cpx)
             delta = cpx(i-1)-cpx(i);
             resultant_length = abs(cpx(i));
             resultant_direction = angle(cpx(i));
             arrowhead_length = resultant_length/20; 
             num_arrowlines = 30;
             arrowhead_angle = deg2rad(30);
             t1 = repmat(resultant_direction,1,num_arrowlines);
             r1 = repmat(resultant_length,1,num_arrowlines);
             theta_prepare = linspace(angle(delta)-arrowhead_angle/2, ...
             angle(delta)+arrowhead_angle/2, num_arrowlines);          
             part_arraw = cpx(i) + arrowhead_length*exp(1j*theta_prepare);
             polarplot([t1; angle(part_arraw)],[r1; abs(part_arraw)])
         end
     end
    % polarplot(cmp, 'pm', 'LineWidth', .5) 
end