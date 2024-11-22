f = 50;
w = 2*pi*f;
h = 1/f/1e4;
loop = 2;
t = 0:h:loop/f;

i0 = sin(w*t); e0 = diff(i0);
ratio = max(e0)/max(i0);

i1 = 240*sin(w*t)+350*sin(3*w*t+1);
e1 = diff(i1)+0.05*rand(1,length(i1)-1);
i1_re = cumtrapz(e1);


linear = polyfit(t(1:end-1), i1_re, 1);
function_fit = polyval(linear,t);
i1_re =i1_re -function_fit(1:end-1);
        
plot(t, i1, t(1:end-1), i1_re); legend('i_real', 'i_recal');
grid on; xlim([0,loop/f]); 