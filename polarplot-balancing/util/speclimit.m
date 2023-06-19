function speclimit(T)
    T = T(T ~= 0);
    h = length(T);       
    if h > 1
        for i = 1:h
            if T(i) < 0
                T(i) = 360 + T(i);
            end                
        end
        min = NaN;
        for angle = 0:10:350
            if sum(T<angle)>0 
                min = angle - 10;             
                break
            end
        end
        max = NaN;
        for angle = 350:-10:0
            if sum(T>angle)>0
                max = angle + 10;
                break
            end
        end  
    end
    thetalim([min max])  
end