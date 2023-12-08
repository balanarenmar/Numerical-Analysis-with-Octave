#{
  FIXED POINT ITERATION

 Construct an Octave function for the fixed-point iteration following the given algorithm in class.
#}

# function handle
g = @(x) x.^[x - cos(x)];

# initial guess: p0
p0 = 2;

fn_fixed_point_iteration(g, p0, 1e-8, 100);


