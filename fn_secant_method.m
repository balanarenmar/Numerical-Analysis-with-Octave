function output = fn_secant_method(f, p0, p1, TOL, N)


  ## f is the function
  ## p0, p1 as initial approximations
  ## TOL is tolerance
  ## N is max iterations
  points = 1000; ## points plotted

  offset = 4;     # determines the size of plotted graph
  a = p0 - offset;
  b = p0 + offset;

  x = linspace(a,b,points);
  y = f(x);

  q0 = f(p0);
  q1 = f(p1);

  #store computed values
  secant_result = zeros(0,5);
  column_labels = {'n', 'p', 'f(p)', 'p+1', "f(p+1)"};

  ## SECANT FORMULA pn = pn-1 - [(f(pn-1))(pn-1 - pn-2)/(f(pn-1) - f(pn-2))]
  # Convert function handle to string
  function_str = func2legend(f);

    ## PLOTTING
    plot_function = plot(x,y,'b','LineWidth', 0.5);
    grid on;
    title('Secant Method');
    set(gca,'FontSize',20);

    axis equal;
    hold on;

    #Plot p0 and p1
    plot_p0 = scatter(p0, q0, 20, 'b', 'filled');
    plot_p1 = scatter(p1, q1, 20, 'b', 'filled');
    text(p0, q0, " p_{0}","fontsize",18);
    text(p1, q1, " p_{1}","fontsize",18);

    slope_secant = (q1 - q0) / (p1 - p0);
    intercept_secant = q0 - slope_secant * p0;
    x_values_secant = linspace(p0-1, p1+1, 100);
    y_values_secant = slope_secant * (x_values_secant - p0) + q0;
    plot_secant = plot(x_values_secant, y_values_secant, 'k--', 'LineWidth', 0.25);

    p = p1 - q1*(p1 - p0)/(q1 - q0);


  ## END -- PLOTTING

  fprintf('SECANT METHOD for f(x)= %s\n',function_str);
  fprintf('Initial Approximations: p0=%.8f \t p1=%.8f\n\n',p0,p1);
  fprintf(' pn-2\t\t\tf(pn-2) \t\tpn-1 \t\t\tf(pn-1) \t\tp(n) \t\t\tf(pn)\n');
  OG_p0 = p0;
  OG_p1 = p1;

  ## STEP 1,2,5
  q0 = f(p0);
  q1 = f(p1);
  for i = 2:N

    ## STEP 3
    p = p1 - q1*(p1 - p0)/(q1 - q0);  # Compute p's of i

    fprintf(' p%d = %.7f\t\tf(p%d) = %.7f\tp%d = %.7f\t\tf(p%d) = %.7f\tp%d = %.7f\t\tf(p%d) = %.8f\n',i-2,p0,i-2,f(p0), i-1,p1, i-1,f(p1), i,p, i,f(p));

    %STORE data
      new_row = zeros(1,5);
      new_row(1,1) = i;
      new_row(1,2) = p0;
      new_row(1,3) = f(p0);
      new_row(1,4) = p;
      new_row(1,5) = f(p);
      secant_result = vertcat(secant_result, new_row);
      secant_result_cell = [column_labels; num2cell(secant_result)];
      assignin('base', 'secant_result', secant_result_cell);
      #plot the next p
      #scatter(p, f(p), 10, 'b', 'filled');

    ## Check for convergence
    abs_error = fn_abs_err(p, p0);
    rel_error = fn_rel_err(p0, p);

    ## STEP 4
    if (abs_error < TOL)
        fprintf('\nConverged to solution: p%d = %.8f using Secant Method.\n\n',i, p);
        scatter(p, f(p), 20, 'g', 'filled');
        text(p, f(p), [' p_{' num2str(i) '}'],"fontsize",20);

        maxX_value = max(p, max(OG_p0, OG_p1));
        minX_value = min(p, min(OG_p0, OG_p1));
        maxY_value = max(f(p), max(f(OG_p0), f(OG_p1)));
        minY_value = min(f(p), min(f(OG_p0), f(OG_p1)));

        midX_value = median([p, OG_p0, OG_p1]);
        midY_value = median([f(p), f(OG_p0), f(OG_p1)]);

        ydist = abs(maxY_value - minY_value);
        xdist = abs(maxX_value - minX_value);

        maxDist = max(xdist, ydist);
        ## Plot size  = axisBorder * 2
        ## axisBorder = maxDist * multiplier
        axisBorder = (5/8 * maxDist);   ## because plot square = 2*(axisBorder)

        #center of plot

        xm = (maxX_value + minX_value)/2;
        ym = (maxY_value + minY_value)/2;

        # Set x-axis limits as "ZOOM"
        xlim([xm-axisBorder, xm+axisBorder]);
        ylim([ym-axisBorder, ym+axisBorder]);

        #function_str
        legend({function_str, 'p_0', 'p_1', 'secant of p_0 p_1','final approximation p_n'}, 'Location', 'northwest');

        output = p;
        hold off;
        return;
    endif

    ## STEP 6 - update values
    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = f(p);

  endfor
  hold off;

  ## STEP 7
  error('Method failed after %d iterations, last value: %f',N, p);
end
