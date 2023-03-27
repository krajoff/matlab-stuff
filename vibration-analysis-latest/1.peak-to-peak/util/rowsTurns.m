function n = rowsTurns(time, rtFreq, rtnrt) 
    ts = mean(diff(time));
    n = int32(1/(rtFreq*ts*rtnrt));  