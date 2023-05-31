    %%%Data %%%%
    resultant_direction = rand(1)*2*pi;
    resultant_length = 50 + (1-0.5).*rand(1);
    %%%%arrow head %%%%
    arrowhead_length    = resultant_length/15; % arrow head length relative to resultant_length
    num_arrowlines = 6;
    arrowhead_angle = deg2rad(15); % degrees
    %%%%arrow tip coordinates %%%%
    t1 = repmat(resultant_direction,1,num_arrowlines);
    r1 = repmat(resultant_length,1,num_arrowlines);
    %%%%arrow base coordinates %%%%
    b = arrowhead_length.*tan(linspace(0,arrowhead_angle,num_arrowlines/2));
    theta = atan(b./(resultant_length-arrowhead_length));
    pre_t2 = [theta, -theta];
    r2 = (resultant_length-arrowhead_length)./cos(pre_t2);
    t2 = t1(1)+pre_t2;
    %%%%plot %%%%
    figure(1)
    polarplot([t1(1) t1(1)],[0 r1(1)-0.9*arrowhead_length],'r','linewidth',3)
    hold on
    polarplot([t1; t2],[r1; r2],'r')