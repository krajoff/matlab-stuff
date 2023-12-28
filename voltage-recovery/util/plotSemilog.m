function plotSemilog(out,title)
    fh = figure('Name',title);
    fh.WindowState = 'maximized';
    semilogy(out.time,out.deltaU, ...
        out.time,out.deltaUfun(out.time),'Linewidth',2);
    %hold on;
    xticks(0:1:fix(out.time(end)));
    xlim([0,fix(out.time(end))]);
    ylim([out.deltaUfun(out.time(end))*0.9,out.deltaU(1)*1.1])
    legend ('\DeltaU''+\DeltaU''''', '\DeltaU''');
    grid on; 
    %semilogy(out.time,out.deltaUsub,'Linewidth',2);
end