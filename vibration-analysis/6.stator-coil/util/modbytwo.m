function [time, data] = modbytwo(time, data)
if ~(mod(length(data), 2) == 0)
    time = time(1:end-1);
    data = data(1:end-1);
end    
end

