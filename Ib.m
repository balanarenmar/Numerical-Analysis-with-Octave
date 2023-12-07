#{
 2.b Solve the equation f(x) = e^x - x^3 - within the interval [−2, −1] accurate to at least within
  10^-4.
#}

f = @(x) exp(x)*1 - x.^[3] - 5;
fn_bisection_method(-2, -1, f, 1e-4, 100);
