#{
 Construct an Octave function for the fixed-point iteration following the given algorithm in class.
#}

# function handle
g = @(x) x.^[x - cos(x)];


# initial guess: p0
p0 = 1.3;
p0 = 1.2;


fn_fixed_point_iteration(g, p0, 1e-10, 100)

## try multiple approximations


## from 0 to 5, and 6 attempts
tries = linspace(0,5,6);
