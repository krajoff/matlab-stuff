function square = getsquare(data)
    sum = 0;
    square = 0;
    for i = 1:length(data)-1
        if data(i)*data(i+1)<0
            sum = sum + data(i);
            square(end+1) = sum;
            sum = 0;
        else
            sum = sum + data(i);
        end
    end
    square = square';
end