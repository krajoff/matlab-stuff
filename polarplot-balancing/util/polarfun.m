function color = polarfun(complex)
     p = polarplot(complex, '-', 'LineWidth', 2);
     color = p.Color;
end