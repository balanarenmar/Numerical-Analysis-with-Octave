#{
 2.a Find the largest root of f(x) = x^6 - x - 1 = 0  accurate to within 10^-5 for the interval [1, 2].
     Discuss your observations regarding the convergence of the approximations.
#}

f = @(x) (x.^6) - x - 1;
fn_bisection_method(1, 2, f, 1e-5, 100);
