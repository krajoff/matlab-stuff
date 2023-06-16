%clear all, clc
GeneralFolder = [fileparts(pwd) '\2.data\'];

exfile = {'80%n'; '90%n'; '100%n'; '110%n'; ...
          '100%U'; ...
          '0MW'; '12MW'; '20MW'; '30MW'; '40MW'; '50MW'; '60MW'};


%folder = 'TB-RB\';
%folder = 'GB-RB\';
folder = 'Bearing support\';
%folder = 'Turbine cover\';
%folder = 'Stator Core HR\';

rangeTime = 32; % time for analisys, s
d = readmatrix([GeneralFolder folder '0MW.csv']);  
Time = d(:,1);
Ts = mean(diff(Time));
TimeStart = length(d) - rangeTime/Ts + 1;
d = d(TimeStart:end,:);

L = size(d,1);
Fs = 1/Ts;
Fn = Fs/2;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;
Iv = 1:length(Fv);
A = zeros(L/2+1, 0);
P = zeros(L/2+1, 0);

n = length(exfile);      
expower = 1:n;
for i = 1:length(exfile)
    Good = readmatrix([GeneralFolder folder exfile{i}]);
    Good = Good(TimeStart:end,2);
    Good = Good - mean(Good);
    Y = fft(Good)/L;
    A = [A 2*abs(Y(Iv))];
    Pm (1:L/2+1, :) = expower(i);
    P = [P Pm];    
end

% Limits of graphics
ribboncoloredZ(Fv,A,.5)
xlim([.5 n+.5])
ylim([0 20])
colorlim = 20; zlim([0 colorlim])


c = colorbar;
c.Position = [.05 .1 .02 .8];
c.FontSize = 20;
caxis([0 colorlim]);
set(gca, 'CameraPosition',[20 10 colorlim])


slCharacterEncoding('windows-1251')
feature('DefaultCharacterSet', 'windows-1251');

names = {'XXT 80%n_í','XXT 90%n_í','XXT 100%n_í','XXT 110%n_í', ...
         'ÕÕÃ 100%U_í',...
         '0 ÌÂò', '12 ÌÂò', '20 ÌÂò','30 ÌÂò','40 ÌÂò','50 ÌÂò','60 ÌÂò'};     
set(gca, 'xtick', 1:n, 'xticklabel', names, 'FontSize', 17)
%xlabel('Ðåæèìû ðàáîòû', 'FontSize', 20)
%ylabel('f, Ãö', 'FontSize', 20)
zlabel('A, ìêì', 'FontSize', 20)
set(get(gca,'zlabel'), 'rotation', 0)
ax = gca;
ax.ZLabel.Position = [22 0 colorlim*1.15];
%ax.ZTick =[0:5:colorlim];
ax.YTick =[0:1:10];
ax.XTickLabelRotation = -30;
set(gcf, 'units', 'normalized', 'outerposition', [0 0 1 1]);
if not(isfolder('pictures'))
	mkdir('pictures')
end   
saveas(gcf, ['pictures\' folder(1:end-1) '.png'])