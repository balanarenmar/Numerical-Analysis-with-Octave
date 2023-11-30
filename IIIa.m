#{
 Create an Octave program that utilizes the given algorithm for Newton¡¯s method to approximate the root of
 any function. Put an additional column in the output for the function evaluations using approximations.
#}

f = @(x) exp(x) + exp(-x) - 5 - x;
p0 = 2;
fn_newtons_method(f, p0, 1e-8, 50)
