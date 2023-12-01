function output = fn_secant_method(f, p0, p1, TOL, N)
  ## Initial approximations
  p0 = 2.6;
  p1 = 2.5;

  #function handle
  f = @(x) (x.^2) - (2.*x) + 1;

  q0 = f(p0);
  q1 = f(p1);

  a = 0 - min(p0, p1) - .25;
  b = 0 + max(p0, p1) + .25;
  TOL = 1e-5;   ## 0.00001 default tolerance 5 decimal places
  N = 100;      ## N is max iterations
  points = 1000; ## points plotted

  x = linspace(a,b,points);
  y = f(x);

  #store computed values
  secant_result = zeros(0,5);
  column_labels = {'n', 'p', 'f(p)', 'p+1', "f(p+1)"};

  ## PLOTTING
    plot(x,y,'b','LineWidth', 1);
    grid on;
    title('Secant Method');
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
    #Plot p0 and p1
    scatter(p0, q0, 20, 'b', 'filled');
    scatter(p1, q1, 20, 'b', 'filled');
    text(p0, q0, "p0","fontsize",12);
    text(p1, q1, "p1","fontsize",12);

    slope_secant = (q1 - q0) / (p1 - p0);
    intercept_secant = q0 - slope_secant * p0;
    x_values_secant = linspace(p0-1, p1+1, 100);
    y_values_secant = slope_secant * (x_values_secant - p0) + q0;
    plot(x_values_secant, y_values_secant, 'k--', 'LineWidth', 0.25);

    p = p1 - q1*(p1 - p0)/(q1 - q0);
    % Calculate the y-value of the secant line at point p
    y_secant_at_p = slope_secant * (p - p0) + q0;
    plot([p, p], [f(p), y_secant_at_p], 'k-', 'LineWidth', 0.5);

    scatter(p, f(p), 20, 'b', 'filled');
    text(p, f(p), "p2","fontsize",12);


  ## END -- PLOTTING

  for i = 2:N
    p = p1 - q1*(p1 - p0)/(q1 - q0);
    fprintf('P%02d = %.8f \n', i, p );

    %STORE data
      new_row = zeros(1,5);
      new_row(1,1) = i;
      new_row(1,2) = p0;
      new_row(1,3) = f(p0);
      new_row(1,4) = p;
      new_row(1,5) = f(p);
      secant_result = vertcat(secant_result, new_row);
      secant_result_cell = [column_labels; num2cell(secant_result)];

      scatter(p, f(p), 10, 'b', 'filled');


    ## Check for convergence
    rel_error = fn_rel_err(p0, p);
    if (rel_error < TOL)
        fprintf('Converged to solution: p%d = %.8f\n',i, p);
        scatter(p, f(p), 20, 'g', 'filled');
        text(p, f(p), ['p' num2str(i)],"fontsize",13);

        output = p;
        hold off;
        return;
    endif

    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = f(p);

  endfor
  hold off;
  error('Method failed after %d iterations, last value: %f',N, p);
end
