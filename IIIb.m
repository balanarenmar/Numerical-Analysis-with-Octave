#{
 NEWTONS METHOD

 Create an Octave program that utilizes the given algorithm for Newton¡¯s method to approximate the root of
 any function. Put an additional column in the output for the function evaluations using approximations.
#}

f = @(x) x + exp(-x.^[2])*1 .* cos(x);
p0 = 0; ## Error is caught when checking for relative error.
#p0 = 1;
fn_newtons_method(f, p0, 1e-8, 50)

