close all
n = 60:1800;
p = -.069;
Sab = 217*n.^p;
Sbc = 360*n.^p; 
Scd = 723*n.^p; 
figure('Name','ISO 7919-5','Position',[50,50,600,800]);
loglog(n,Sab,n,Sbc,n,Scd,'Linewidth',2,'Color','#0076a8');

text(300,100,'A','FontSize',14)
text(300,180,'B','FontSize',14)
text(300,330,'C','FontSize',14)
text(300,600,'D','FontSize',14)

text(500,150,'217\cdotn^{-0.069}','FontSize',12)
text(500,250,'360\cdotn^{-0.069}','FontSize',12)
text(500,500,'723\cdotn^{-0.069}','FontSize',12)

xlim([60,1800]);
xticks([60,100,200,500,1000,1800]);
ylim([50,1000]);
yticks([50,60,70,80,90,100,150,200,250,...
    300,350,400,450,500,550,600,700,800,900,1000]);
set(gca,'LineWidth',1,'TickLength',[0.025 0.025]);
xlabel('Maximum speed, r/min','Units','Pixels',...
    'Position', [380 40],'FontSize',12)
ylabel('Shaft relative vibration peak-to-peak displacement, S_{p-p}, \mum', ...
'Units', 'Pixels', 'Position', [200 665], 'FontSize', 12, 'Rotation', 0)
grid on