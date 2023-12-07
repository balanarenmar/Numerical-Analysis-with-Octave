#{
  SECANT METHOD

 Construct an Octave code that uses the given algorithm for the secant method to approximate
 the solution of any function. In the output, also indicate the function values at the obtained approximations.
#}

f = @(x) x.^[4] - 2*(x.^[2]) - 4;
p0 = 2;
p1 = 3;
p = fn_secant_method(f, p0, p1, 1e-6, 100)
