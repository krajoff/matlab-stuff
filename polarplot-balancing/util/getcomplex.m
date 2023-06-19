function complex = getcomplex(amplitude, phase)
    %% Complex double from amplitude and phase
    complex = amplitude.*exp(1j*deg2rad(phase));
end