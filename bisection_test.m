  a = -2;
  b = 1.5;
  TOL = 1e-5; ##0.00001 default tolerance 5 decimal places
  N = 30;
  points = 100;
  ##where a, b are endpoints,
  ##TOL is tolerance
  ##N is max iterations

  ##prepare formatting
  format;
  %output_precision(digit)

  #function handle
  f = @(x) 3*(x + 1).*(x - 0.5).*(x - 1);

  #x values range from a to b
  x = linspace(a,b,points);
  y = f(x);

  Fa = f(a);
  Fb = f(b);

  if (Fa*Fb)>0
    error("f(a) and f(b) are not opposite signs!");
    return;
  endif

  ## PLOTTING
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
  ## END -- PLOTTING

  #store computed values
  bisection_result = zeros(0,7);
  column_labels = {'n', 'a', 'f(a)', 'b', 'f(b)', 'p', 'f(p)'};

  past_midpoint = a;
  for i = 1:N
    n_str = num2str(i);
    midpoint = (a + (b - a) / 2);
    fprintf('%3d\t   A:%f\t   B:%f\t   p:%f\n',i,a,b,midpoint);
    fprintf('eval%d\tf(a):%f\tf(b):%f\tf(p):%f ',i,f(a),f(b),f(midpoint));
    #p = midpoint;
    #Fp = f(p); #y of midpoint

    #Store data
    new_row = zeros(1,7);
    new_row(1,1) = i;
    new_row(1,2) = a;
    new_row(1,3) = f(a);
    new_row(1,4) = b;
    new_row(1,5) = f(b);
    new_row(1,6) = midpoint;
    new_row(1,7) = f(midpoint);
    bisection_result = vertcat(bisection_result, new_row);

    ##STOPPING CONDITION
    rel_error = fn_rel_err(midpoint, past_midpoint);
    abs_error = fn_abs_err(midpoint, past_midpoint);

    if (f(midpoint)==0) || (rel_error < TOL)
      output = midpoint;
      fprintf('ROOT REACHED\n');
      plot(midpoint, f(midpoint), 'g*');
      text(midpoint, f(midpoint), ['p' n_str],"fontsize",15);
      return;
    endif
    fprintf('\t abs err: %f\trel err: %f\n', abs_error, rel_error);

    if ((f(a).*f(midpoint))>0) #p replaces a; same sign
      a = midpoint;
      Fa = f(midpoint);
      ##solve for a[i], b[i];
    else
      b = midpoint;
      Fb = f(midpoint);
    endif
    past_midpoint = midpoint;

    ##PLOT the point
    plot(midpoint, f(midpoint), 'm+');
    text(midpoint, f(midpoint), ['p' n_str],"fontsize",15);
  endfor
  bisection_result_cell = [column_labels; num2cell(bisection_result)];
  error('Method failed after %d iterations, last value: %f',N, midpoint);
