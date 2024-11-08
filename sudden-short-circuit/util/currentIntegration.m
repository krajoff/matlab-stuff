function data = currentIntegration(data,opt)
    data.(opt.currentA) = cumtrapz(data.(opt.currentA));
    data.(opt.currentB) = cumtrapz(data.(opt.currentB));
	data.(opt.currentC) = cumtrapz(data.(opt.currentC));
end