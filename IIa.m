#{
 Construct an Octave function for the fixed-point iteration following the given algorithm in class.
#}

g = @(x) (x.^[5]) - 3*(x.^[3]) - 2*(x.^[2]) + 2;


p0 = 2.1; # no
p0 = -1.5028089500915; ## WORKED  #when roots are input, it converges to fixed point
p0 = 0.725930633961802; ##works
p0 = 1.93834595799199; ## works

fn_fixed_point_iteration(g, p0, 1e-10, 100);
