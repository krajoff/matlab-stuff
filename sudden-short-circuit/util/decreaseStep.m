function data = decreaseStep(data, opt)
    ts = mean(diff(data.Time));
    step = int32(opt.disTime/ts);
    if step > 0
        data = data(1:step:end,:); 
    end
end