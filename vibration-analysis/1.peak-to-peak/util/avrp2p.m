function average = avrp2p(data, rT, NumberTurns)
    average = 0;
    for j = 1:NumberTurns
        average = average + peak2peak(data((j-1)*rT+1:j*rT));
    end
    average = int32(average/NumberTurns);
end