#function output = fn_bisection_method(a, b, TOL, N)
function output = fn_bisection_method()
  a = -2;
  b = 1.5;
  TOL = 1e-10; ##0.0000000001 default tolerance
  N = 30;
  points = 100;
  ##where a, b are endpoints,
  ##TOL is tolerance
  ##N is max iterations

  ##prepare formatting
  format;
  #output_precision(digit)

  #function handle
  f = @(x) 3*(x + 1).*(x - 0.5).*(x - 1);

  #x values range from a to b
  x = linspace(a,b,points);
  y = 3*(x+1).*(x-0.5).*(x-1);

  Fa = f(a);
  Fb = f(b);

  if (Fa*Fb)>0
    error("f(a) and f(b) are not opposite signs!");
    return;
  endif

  plot(x,y) ##TEST plot
  grid on;
  title('Bisection Method');
  set(gca,'FontSize',20);

  y_min = min(y);
  y_max = max(y);
  % Calculate the range for both x and y
  x_range = b - a;
  y_range = y_max - y_min;
  % Determine the maximum range for the aspect ratio
  max_range = max(x_range, y_range);
  % Calculate the new axis limits
  x_center = (b + a) / 2;
  y_center = (y_max + y_min) / 2;
  x_limit = [x_center - max_range / 2, x_center + max_range / 2];
  y_limit = [y_center - max_range / 2, y_center + max_range / 2];
  % Determine the tick locations at intervals of 2
  x_ticks = floor(x_limit(1)/2)*2 : 2 : ceil(x_limit(2)/2)*2;
  y_ticks = floor(y_limit(1)/2)*2 : 2 : ceil(y_limit(2)/2)*2;
  % Set the aspect ratio to 'equal' and specify axis limits and tick locations
  axis([x_limit, y_limit]);
  axis equal;
  hold on;
  #plot points a and b.
  plot(a, Fa, 'ro');
  plot(b, Fb, 'ro');
  text(a, Fa, "A","fontsize",20);
  text(b, Fb, "B","fontsize",20);

  p  = zeros(2,N);
  as = zeros(2,N);
  bs = zeros(2,N);

  for i = 1:N

    midpoint = (a + (b - a) / 2);
    fprintf('%d\tA:%f\tB:%f\tmid:%f\n',i,a,b,midpoint);
    fprintf('eval%d\tA:%f\tB:%f\tmid:%f\n',i,f(a),f(b),f(midpoint));
    #fprintf('A:%f\tB:%f\n',a,b);
    #fprintf('p(%d):%f A:%f B:%f f(mid):%f fa:%f fb:%f\n',i,midpoint,a,b,f(midpoint),Fa,Fb);

    #p = midpoint;
    Fp = f(p); #evaluate p

    if (i>1)
      if (f(midpoint)==0) || (fn_rel_err(midpoint, past_midpoint) < TOL)
        output = p;
        fprintf('REACHED\n');
        return;
      endif
    else
      past_midpoint = midpoint;
      if (f(midpoint)==0)
        output = p;
        fprintf('REACHED\n');
        return;
      endif
    endif

    if ((f(a).*f(midpoint))>0) #p replaces a; same sign
      a = midpoint;
      Fa = f(midpoint);
      ##solve for a[i], b[i];
    else
      b = midpoint;
      Fb = f(midpoint);
    endif
    plot(midpoint, f(midpoint), 'm+');
    text(midpoint, f(midpoint), "p","fontsize",15);
  endfor
  error('Method failed after %d iterations, last value: %f',N, midpoint);

end
