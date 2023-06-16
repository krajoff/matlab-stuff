function res = maxinpole(data)
    cnt = 0;
    res = 0;
    for i=1:length(data)-1
        if data(i)*data(i+1)<0
            cnt = cnt+1;
            if mod(cnt,2) == 0
                Amax = abs(max(data(bnd:i)));
                Amin = abs(min(data(bnd:i)));
                if Amax > Amin 
                    res = [res; Amax];
                else
                    res = [res; Amin];
                end
                cnt = cnt - 1;
            end
            bnd = i;
        end
    end
    res = res(1:end,:);
end