function cntnm = getcountertime(counter, time, poles)
    if (abs(max(counter))>abs(min(counter)))
        range = max(counter)*.2;
    else
        range = min(counter)*.2; 
    end
    counter(counter > range) = 1;
    ts = mean(diff(time));
    cnt = find(counter == 1);
    cntnm = int16(cnt(1)*ts/.01) + 1;
    for i = 2:length(cnt)-1
        if (cnt(i+1)-cnt(i))*ts > (poles-1)/100
            cntnm(end+1) = int16(cnt(i+1)*ts/.01)+1;
        end
    end
    cntnm = cntnm';
end