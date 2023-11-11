  a = 0;
  b = pi/2;


  TOL = 1e-5;   ## 0.00001 default tolerance 5 decimal places
  N = 100;      ## N is max iterations
  points = 100; ## points plotted


  #function handle
  f = @(x) (x.^2) - (2.*x) + 1;
  x = linspace(a,b,points);
  y = f(x);

  ## Initial approximations
  p0 = 2.6;
  p1 = 2.5;

  q0 = f(p0);
  q1 = f(p1);


  for i = 2:N
    p = p1 - q1*(p1 - p0)/(q1 - q0);

    ## Check for convergence
    rel_error = fn_rel_err(p0, p);
    if (rel_error < TOL)
        fprintf('Converged to solution: p%d = %.8f\n',i, p);
        output = p;
        return;
    endif

    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = f(p);

  endfor
  hold off;
  error('Method failed after %d iterations, last value: %f',N, p);

