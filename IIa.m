#{
 Construct an Octave function for the fixed-point iteration following the given algorithm in class.
#}

g = @(x) (x.^5) - 3 .* (x.^3) - 2 .* (x.^2) + 2;
p0 = -2; # initial guess: p0
fn_fixed_point_iteration(g, p0, 1e-10, 100)
