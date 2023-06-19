function arrowpolarplot(complex, color)
    %% Add arrows to polar plot
     if (length(complex) > 1)
         for i=2:length(complex)
             delta = complex(i-1)-complex(i);
             resultant_length = abs(complex(i));
             resultant_direction = angle(complex(i));
             arrowhead_length = resultant_length/20; 
             num_arrowlines = 30;
             arrowhead_angle = deg2rad(30);
             t1 = repmat(resultant_direction,1,num_arrowlines);
             r1 = repmat(resultant_length,1,num_arrowlines);
             theta_prepare = linspace(angle(delta)-arrowhead_angle/2, ...
             angle(delta)+arrowhead_angle/2, num_arrowlines);          
             part_arraw = complex(i) + arrowhead_length*exp(1j*theta_prepare);
             polarplot([t1; angle(part_arraw)],[r1; abs(part_arraw)], ...
                 'Color', color)
         end
     end
end