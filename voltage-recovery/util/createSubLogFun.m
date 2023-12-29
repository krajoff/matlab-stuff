function out = createSubLogFun(out,opt)
    % Cutting values for logistic function
    out.timeSub = out.time(int32(.1/opt.splineTime):int32(1/opt.splineTime));
    out.yUSub = out.deltaUsub(int32(.1/opt.splineTime):int32(1/opt.splineTime));
    
    % Create the objective function
    out.logsubfun = @(beta,timeSub)...
        beta(1)+beta(2).*exp(-beta(3).*timeSub);
    
    % Create an anonymous function    
    out.betasub = lsqcurvefit(out.logsubfun,opt.beta0, ...
        out.timeSub,out.yUSub);
    out.deltaUsubfun = @(time)...
        out.betasub(1)+out.betasub(2).*exp(-out.betasub(3).*time);
end