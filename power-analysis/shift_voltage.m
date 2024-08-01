close all
w = pi*100;
t = 0:0.0001:0.02;
U1 = sin(w*t);
U2 = sin(w*t+w/3);
U3 = sin(w*t-w/3);
S = U1+U2+U3;
figure()
plot(t,U1,t,U2,t,U3,t,S,'LineWidth', 2);
grid on
hold on;
U1 = sin(w*t)-0.1*sin(w*t);
U2 = sin(w*t+w/3)-0.1*sin(w*t);
U3 = sin(w*t-w/3)-0.1*sin(w*t);
S = U1+U2+U3;
%plot(t,U1,t,U2,t,U3,t,S,'LineWidth', 2);
U1 = U1 - S/3;
U2 = U2 - S/3;
U3 = U3 - S/3;
plot(t,U1,t,U2,t,U3,t,S,'LineStyle','--','LineWidth', 3);
