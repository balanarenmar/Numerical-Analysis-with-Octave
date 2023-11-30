function output = fn_newtons_method(f, p0, TOL, N)


  offset = 4;     # determines the size of plotted graph
  a = p0 - offset;
  b = p0 + offset;
  points = 1000;

  pkg load symbolic
  syms sym_x;
  sym_f = sym(f(sym_x));

  sym_df = diff(sym_f);
  df = function_handle(sym_df);

  ## NEWTON's FORMULA pn = pn-1 - [(f(pn-1))/(f'(pn-1))]
  # Convert function handle to string
  function_str = func2str(f);

  function_str = strrep(function_str, '.', '');       # Remove periods from the string
  function_str = strrep(function_str, '@(x)', '');
  function_str = strrep(function_str, 'exp', 'e ^');   ## FIX FORMATTING
  function_str = strtrim(function_str);       # Remove the leading and trailing whitespaces

  derivative_str = func2str(df);
  derivative_str = strrep(derivative_str, '.', '');
  derivative_str = strrep(derivative_str, 'sym_x', 'x');
  derivative_str = strrep(derivative_str  , 'exp', 'e ^');
  derivative_str = strrep(derivative_str, '@(x)', '');

  pn_formula_str = ["pn-1 - [(", function_str, ") / (", derivative_str, ")]"];
  pn_formula_str = strrep(pn_formula_str, 'x', 'pn-1');

  x = linspace(a,b,points);
  y = f(x);
  dy = df(x);

  ## PLOTTING
    plot(x,y,'b','LineWidth', 0.5);
    grid on;
    title('Newton-Raphson Method');
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

    y0 = zeros(1,points);
    plot(x,y0,'k','LineWidth', 0.5);

    #plot initial approximation p0
    scatter(p0, f(p0), 10, 'k', 'filled');
    text(p0, f(p0), ['p0=' num2str(p0)],"fontsize",15);
  ## END -- PLOTTING

  #store computed values
  newtons_result = zeros(0,5);
  column_labels = {'n', 'p', 'f(p)', 'p+1', "f(p+1)"};

  p = p0; #initial approximation

  #{#}
  %Perform Newton-Raphson iteration
  for i = 1:N

      p = p0 - f(p0) / df(p0);
      fprintf('Iteration %d: p = %.9f\tf(p)=%.9f\n', i, p, f(p));

      %STORE data
      new_row = zeros(1,5);
      new_row(1,1) = i-1;
      new_row(1,2) = p0;
      new_row(1,3) = f(p0);
      new_row(1,4) = p;
      new_row(1,5) = f(p);
      newtons_result = vertcat(newtons_result, new_row);
      newtons_result_cell = [column_labels; num2cell(newtons_result)];
      assignin('base', 'newtons_result', newtons_result_cell);

      % Check for convergence
      #rel_error = fn_rel_err(p0, p);
      abs_error = fn_abs_err(p0, p);

      if (abs_error < TOL)  ## CHANGED to absolute error to accept 0 as initial guess
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
          #{


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
          #}
          fprintf("NEWTON's FORMULA:\npn= %s\n", pn_formula_str);


          #zoom the plot, centered on p
          xlim([p-offset, p+offset]);  % Set x-axis limits
          ylim([f(p)-offset, f(p)+offset]);

          hold off;
          return;
      endif
      % Update the approximation
      p0 = p;

      ## mark the current approximation as a dot
      scatter(p, f(p), 10, 'b', 'filled');

  endfor
  hold off;
  error('Method failed after %d iterations, last value: %f',N, p);
  end
