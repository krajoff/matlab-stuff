function out = createLogFun(out,opt)
    % Cutting values for logistic function
    out.timeCutting = out.time(opt.cutPoints:end);
    out.yUCutting = out.deltaU(opt.cutPoints:end);
        
    % Create the objective function
    out.logfun = @(beta,timeCutting)...
        beta(1)+beta(2).*exp(-beta(3).*timeCutting);
    
    % Create an anonymous function    
    out.beta = lsqcurvefit(out.logfun, opt.beta0, ...
        out.timeCutting, out.yUCutting);
    out.deltaUfun = @(time)...
        out.beta(1)+out.beta(2).*exp(-out.beta(3).*time);
    out.deltaUsub = out.deltaU-out.deltaUfun(out.time); 
end