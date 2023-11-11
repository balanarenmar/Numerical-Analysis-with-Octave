  a =0;
  b = pi/2;

  #p0 = 1.5;    ## Initial approximation
  TOL = 1e-5;  ## 0.00001 default tolerance 5 decimal places
  N = 100;      ##N is max iterations
  points = 100;

  pkg load symbolic
  syms sym_x;
  #sym_f = (sym_x)^2 - (sym_x) + 2;
  sym_f = cos(sym_x) - (sym_x);
  f = function_handle (sym_f);

  sym_df = diff(sym_f);
  df = function_handle(sym_df);

  x = linspace(a,b,points);
  y = f(x);
  dy = df(x);

  ## PLOTTING
  plot(x,y,'b','LineWidth', 1);
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
  plot(a, f(a), 'ro');
  plot(b, f(b), 'ro');
  #text(a, f(a), "A","fontsize",20);
  #text(b, f(b), "B","fontsize",20);
  ## END -- PLOTTING

  #store computed values
  newtons_result = zeros(0,5);
  column_labels = {'n', 'p', 'f(p)', 'p+1', "f(p)+1"};
  #initial approximation

  p0 = 1.5;
  p = p0;

  #{#}
  %Perform Newton-Raphson iteration
  for i = 1:N

      p = p0 - f(p0) / df(p0);
      fprintf('Iteration %d: p = %.8f\n', i, p);

      %STORE data
      new_row = zeros(1,4);
      #column_labels = {'n', 'p', 'f(p)', "f(p)+1"};
      new_row(1,1) = i-1;
      new_row(1,2) = p0;
      new_row(1,3) = f(p0);
      new_row(1,4) = p;
      new_row(1,5) = f(p);
      newtons_result = vertcat(newtons_result, new_row);
      newtons_result_cell = [column_labels; num2cell(newtons_result)];
      % Check for convergence
      rel_error = fn_rel_err(p0, p);
      if (rel_error < TOL)
          fprintf('Converged to solution: p%d = %.8f\n',i-1, p);
          ## PLOT last tangent line
          pn = newtons_result(i,2);
          tangent_line = df(pn) * (x - pn) + f(pn);
          plot(x,tangent_line,'g--', 'LineWidth', .5);
          scatter(pn, f(pn), 50, 'g', 'filled');  % Mark the root
          n_str = num2str(i);
          text(pn, f(pn), ['p' n_str],"fontsize",12);
          j=i-1;
          k=0;
          ## PLOT the last 2 tangent lines
          while[j>0 && k<2]
            %point slope form: y - y0 = m(x-x0); where m=f'(p) and [x0,y0]=[p,f(p)];
            pn = newtons_result(j,2);
            tangent_line = df(pn) * (x - pn) + f(pn);
            plot(x,tangent_line,'r--', 'LineWidth', .5);
            plot(pn, f(pn), 'm+');
            n_str = num2str(j);
            text(pn, f(pn), ['p' n_str],"fontsize",10);
            j = j-1;
            k = k+1;
          endwhile
          hold off;
          return;
      endif
      % Update the approximation
      p0 = p;
  endfor
  hold off;
  error('Method failed after %d iterations, last value: %f',N, p);
