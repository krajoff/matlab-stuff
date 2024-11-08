function plotSemilog(out,opt,title)
    out = reactances(out,opt);
    figure('Name',title,'Position',[100,50,600,600*1.2]);
    semilogy(out.time,out.deltaU, ...
        out.time,out.deltaUfun(out.time),'Linewidth',2);
    hold on;
    semilogy(out.tTran,out.deltaUfun(0)/exp(1),'b+','Linewidth',2);
    xticks(0:1:fix(out.time(end)));
    xlim([0,fix(out.time(end))]);
    ylim([out.deltaUfun(out.time(end))*0.9,out.deltaU(1)*1.1])
    legend ('\DeltaU''+\DeltaU''''', '\DeltaU''');
    grid on; 
    [~,name,~] = fileparts(opt.name);
    saveas(gcf, ['pictures\', ...
        name,'_',...
        char(title),...
        '_iF=',char(num2str(opt.iFilter)),...
        '_nF=',char(num2str(opt.nFilter)),'.png'])
    %figure('Name',title,'Position',[100,50,600,600*1.2])
    %semilogy(out.time,out.deltaUsub, ...
    %    out.time,out.deltaUsubfun(out.time), 'Linewidth',2);
end