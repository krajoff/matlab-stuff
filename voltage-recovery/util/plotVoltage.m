function plotVoltage(data,VoltageAnalysis,out,opt,title)
    fh = figure('Name', "Stator voltage, envelope, peaks (" + title + ")");
    fh.WindowState = 'maximized';
    subplot(2,1,1);
    plot(data.Time, VoltageAnalysis, 'Linewidth', 1); 
    hold on
    plot(data.Time, out.initialFiltered, ':', 'Linewidth', 2); 
    plot(out.timePeaks, out.valuePeaks, 'ko');
    plot(out.timeSpline, out.valueSpline, '-', 'Linewidth', 2);
    plot(out.timeSpline, out.valueFiltered, '--', 'Linewidth', 2);
    xlim([opt.startTime-0.5, opt.endTime]);
    legend ('Raw data', 'Initial filtration', 'Peaks', out.legendspline, ...
    out.legendfilteredspline);
    grid on;
    
    subplot(2,1,2);
    plot(data.Time, VoltageAnalysis, 'Linewidth', 1); 
    hold on
    plot(data.Time, out.initialFiltered, ':', 'Linewidth', 2); 
    plot(out.timePeaks, out.valuePeaks, 'ko', 'MarkerFaceColor', 'b');
    plot(out.timeSpline, out.valueSpline, '-', 'Linewidth', 2);
    plot(out.timeSpline, out.valueFiltered, '--', 'Linewidth', 2);
    timelimit = .2;
    xlim([opt.startTime-.05, opt.startTime+timelimit]);
    maxvalue = max(out.valueSpline(1:fix(timelimit/opt.splineTime)));
    ylim([-fix(maxvalue/5) 1.1*maxvalue]);
    legend ('Raw data', 'Initial filtration', 'Peaks', out.legendspline, ...
        out.legendfilteredspline);
    legend('Location','northwest');
    grid on;   
end