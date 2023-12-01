#{
 What will happen if the bisection method is used with the function f(x) = 1 / (x − 2)
 and the interval is [3, 7]? You may try different values of tolerance if possible.
#}

f = @(x) 1 ./ (x - 2);
fn_bisection_method(3, 7, f, 1e-5, 50);
