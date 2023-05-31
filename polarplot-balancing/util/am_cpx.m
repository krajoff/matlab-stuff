function m_necessaty = am_cpx(a1, a2, m1, m2)
    a = a2 - a1;
    m = m2 - m1;
    k = a/m;
    m_necessaty = -a1/k;
    fprintf(['Correcting weight = %0.2f/%0.0f' char(176) '\n'], ...
        abs(m_necessaty), ...
        rad2deg(wrapToPi(angle(m_necessaty))));
end