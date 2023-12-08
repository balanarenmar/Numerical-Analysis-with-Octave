function output = fn_bisection_method(a, b, f, TOL, N)
  ## a, b are endpoints,
  ## f is function
  ## TOL is tolerance
  ## N is max iterations

  ##prepare formatting
  format;
  %output_precision(digit)
  points = 10000;

  offset = 3;     # determines the size of plotted graph
  left_edge = a - offset;
  right_edge = b + offset;

  #x values range from a to b
  x = linspace(left_edge,right_edge,points);
  y = f(x);

  Fa = f(a);
  Fb = f(b);
  function_str = func2legend(f);

  fprintf('bisection method of %s:\n\n',function_str);

  #{

  if (Fa*Fb)>0
    fprintf('n\ta\t\tf(a)\t\tb\t\tf(b) \n');
    fprintf('1\t%.6f\t%.6f\t%.6f\t%.6f \n',a,f(a),b,f(b));
    error("error: f(a) and f(b) are not opposite signs!");
    return;
  endif
  #}

  ## PLOTTING
  plot(x,y);
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
  plot_a = scatter(a, Fa, 20, 'r', 'filled');
  plot_b = scatter(b, Fb, 20, 'r', 'filled');
  text(a, Fa, " a","fontsize",18);
  text(b, Fb, " b","fontsize",18);
  ## END -- PLOTTING

  #store computed values
  bisection_result = zeros(0,7);
  column_labels = {'n', 'a', 'f(a)', 'b', 'f(b)', 'p', 'f(p)'};

  past_midpoint = a;
  starting_a = a;
  starting_b = b;



  fprintf('n\ta\t\tf(a)\t\tb\t\tf(b)\t\tp - midpoint\tf(p)\t\ta_error\t\tr_error\n');
  for i = 1:N
    n_str = num2str(i);
    midpoint = (a + (b - a) / 2);

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
    bisection_result_cell = [column_labels; num2cell(bisection_result)];
    assignin('base', 'bisection_result', bisection_result_cell);


    rel_error = fn_rel_err(midpoint, past_midpoint);
    abs_error = fn_abs_err(midpoint, past_midpoint);

    fprintf('%d\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f \n',i,a,f(a),b,f(b),midpoint,f(midpoint),abs_error,rel_error);
    ## STOPPING CONDITION
    ## STEP 4
    if (f(midpoint)==0) || (abs_error < TOL)
      iteration = i;
      output = midpoint;
      p = midpoint;
      fprintf('\nROOT REACHED: %.8f\n',midpoint);
      plot(midpoint, f(midpoint), 'g*');
      text(midpoint, f(midpoint), [' p_{' n_str '}'],"fontsize",20);

          # plot the midpoints
          for(i=1:iteration)
              scatter(bisection_result(i, 6), bisection_result(i,7), 5, 'b', 'filled');
          endfor
          plot(midpoint, f(midpoint), 'g*');
          #FIX Zooming
          maxX_value = max(p, max(starting_a, starting_b));
          minX_value = min(p, min(starting_a, starting_b));
          maxY_value = max(f(p), max(f(starting_a), f(starting_b)));
          minY_value = min(f(p), min(f(starting_a), f(starting_b)));

          midX_value = median([p, starting_a, starting_b]);
          midY_value = median([f(p), f(starting_a), f(starting_b)]);

          ydist = abs(maxY_value - minY_value);
          xdist = abs(maxX_value - minX_value);

          maxDist = max(xdist, ydist);
          ## Plot size  = axisBorder * 2
          ## axisBorder = maxDist * multiplier
          axisBorder = (5/8 * maxDist);   ## plot square = 3/4*(axisBorder) + 1/8 (margin)

          #center of plot
          xm = (maxX_value + minX_value)/2;
          ym = (maxY_value + minY_value)/2;

          # Set x-axis limits as "ZOOM"
          xlim([xm-axisBorder, xm+axisBorder]);
          ylim([ym-axisBorder, ym+axisBorder]);

      legend({function_str, 'a', 'b', 'final approximation p_n','midpoints'}, 'Location', 'northwest');
      hold off;
      return;
    endif


    ##solve for a[i], b[i];
    if ((f(a).*f(midpoint))>0) #p replaces a; same sign
      a = midpoint;
      Fa = f(midpoint);
    else
      b = midpoint;
      Fb = f(midpoint);
    endif
    past_midpoint = midpoint;

    ##PLOT the midpoint
    #scatter(midpoint, f(midpoint), 5, 'b', 'filled');
    #text(midpoint, f(midpoint), ['p' n_str],"fontsize",15);
  endfor


  # plot the midpoints
          #for(i=1:N)
              #scatter(bisection_result(i, 6), bisection_result(i,7), 5, 'b', 'filled');
          #endfor
          #FIX Zooming
          maxX_value = max(starting_a, starting_b);
          minX_value = min(starting_a, starting_b);
          maxY_value = max(f(starting_a), f(starting_b));
          minY_value = min(f(starting_a), f(starting_b));
          ydist = abs(maxY_value - minY_value);
          xdist = abs(maxX_value - minX_value);
          maxDist = max(xdist, ydist);
          ## Plot size  = axisBorder * 2
          ## axisBorder = maxDist * multiplier
          axisBorder = (2/2 * maxDist);
          #center of plot
          xm = (maxX_value + minX_value)/2;
          ym = (maxY_value + minY_value)/2;
          # Set x-axis limits as "ZOOM"
          xlim([xm-axisBorder, xm+axisBorder]);
          ylim([ym-axisBorder, ym+axisBorder]);
      #legend({function_str, 'a', 'b', 'final approximation p_n','midpoints'}, 'Location', 'northwest');
  hold off;
  fprintf('error. Method failed after %d iterations, TOL:%f,\t last midpoint: %f\n',N, TOL, midpoint);

end
