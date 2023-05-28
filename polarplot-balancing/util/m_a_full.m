function m_a_full(z1, z2)
    close all
    z1.ComplexMass = z1.Mass.*exp(1j*deg2rad(z1.PhaseMass));
    z2.ComplexMass = z2.Mass.*exp(1j*deg2rad(z2.PhaseMass));
    dm = z2.ComplexMass - z1.ComplexMass;
    fmass = abs(dm);
    fangel = angle(dm);
    if fmass < 0 
        d = z2.Complex - z1.Complex;
    else
        d = z1.Complex - z2.Complex;
    end
    rmass = abs(fmass).*abs(z1.Complex)./abs(d);
    rangle = wrapToPi(angle(z1.Complex) - angle(d));
    ot = rmass.*exp(1j*(rangle + deg2rad(z1.PhaseMass)));
    res = ot + z1.ComplexMass;
    
    fprintf(['!Ќеобходимо сн€ть все груза! ”гол между местом,\n'...
    'где был установлен груз из первой записи и \n' ...
    'куда необходимо поставить балансировочный груз (по\n' ...
    'вращению от первого груза, если знак "+" и против \n' ...
    'вращени€, если знак "-") составл€ет: %0.0f', ...
    char(176), '\n'], rad2deg(wrapToPi(angle(res) - ...
    deg2rad(z1.PhaseMass))));
    fprintf('ћасса груза: %0.1f   %0.1f кг \n',  abs(ot), abs(res)); 
    
    polarplot([z1.Complex, z2.Complex], '*--', 'LineWidth', ...
        1, 'MarkerEdgeColor', 'k') 
    hold on
    polarplot(ot, '*', 'MarkerEdgeColor', 'b') 
    polarplot(dm, '*', 'MarkerSize', 10, ...
        'MarkerEdgeColor', 'g') 
    polarplot(res, '*', 'MarkerSize', 10, ...
        'MarkerEdgeColor', 'r') 
    legend Z1-Z2 temptMass+angleZ1 Z2.Mass-Z1.Mass RESULT
    

end