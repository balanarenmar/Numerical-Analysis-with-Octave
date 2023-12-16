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

  #{#}
  ## ERROR CATCHING. f(a) and f(b) must be opposite signs!
  if (Fa*Fb)>0
    fprintf('n\ta\t\tf(a)\t\tb\t\tf(b) \n');
    fprintf('1\t%.6f\t%.6f\t%.6f\t%.6f \n',a,f(a),b,f(b));
    fprintf("error: f(a) and f(b) are not opposite signs!\n");

    prompt = sprintf('Would you like to continue bisection method despite f(a) and f(b) not being opposite signs?\n\t[Enter ''yes'' or ''no'']\n\t>> ');
    user_input = input(prompt, 's');

    # Check if the input is "yes" or "no" (case-insensitive)
    while ~strcmpi(user_input, 'yes') && ~strcmpi(user_input, 'no')
        fprintf('Invalid input. Please enter "yes" or "no".\n');
        user_input = input(prompt, 's');
    end

    if strcmpi(user_input, 'no')
        error('program terminated.');
    end

  endif


  ## PLOTTING
  plot(x,y);
  grid on;
  title('Bisection Method');
  set(gca,'FontSize',20);
  axis equal;
  hold on;
  #plot points a and b.
  plot_a = scatter(a, Fa, 20, 'r', 'filled');
  plot_b = scatter(b, Fb, 20, 'r', 'filled');
  text(a, Fa, " a","fontsize",18);
  text(b, Fb, " b","fontsize",18);
  ## END -- PLOTTING

  ## store computed values
  bisection_result = zeros(0,7);
  column_labels = {'n', 'a', 'f(a)', 'b', 'f(b)', 'p', 'Fp'};

  past_p = a;
  starting_a = a;
  starting_b = b;

  fprintf('n\ta\t\tf(a)\t\tb\t\tf(b)\t\tp - midpoint\tf(p)\t\ta_error\t\tr_error\n');
  ## STEP 1 & 2 & 5
  for i = 1:N
    ## STEP 3
    n_str = num2str(i);
    p = (a + (b - a) / 2);
    Fp = f(p);

    #Store data
    new_row = zeros(1,7);
    new_row(1,1) = i;
    new_row(1,2) = a;
    new_row(1,3) = f(a);
    new_row(1,4) = b;
    new_row(1,5) = f(b);
    new_row(1,6) = p;
    new_row(1,7) = Fp;
    bisection_result = vertcat(bisection_result, new_row);
    bisection_result_cell = [column_labels; num2cell(bisection_result)];
    assignin('base', 'bisection_result', bisection_result_cell);

    rel_error = fn_rel_err(p, past_p);
    abs_error = fn_abs_err(p, past_p);

    fprintf('%d\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%.6f\t%-.6f \n',i,a,f(a),b,f(b),p,Fp,abs_error);
    ## STOPPING CONDITION
    ## STEP 4
    if (Fp==0) || (abs_error < TOL)
      iteration = i;
      output = p;
      p = p;
      fprintf('\nROOT REACHED: %.8f\n',p);
      plot(p, Fp, 'g*');
      text(p, Fp, [' p_{' n_str '}'],"fontsize",20);

          # plot the ps
          for(i=1:iteration)
              scatter(bisection_result(i, 6), bisection_result(i,7), 5, 'b', 'filled');
          endfor
          plot(p, Fp, 'g*');
          #FIX Zooming
          maxX_value = max(p, max(starting_a, starting_b));
          minX_value = min(p, min(starting_a, starting_b));
          maxY_value = max(Fp, max(f(starting_a), f(starting_b)));
          minY_value = min(Fp, min(f(starting_a), f(starting_b)));

          midX_value = median([p, starting_a, starting_b]);
          midY_value = median([Fp, f(starting_a), f(starting_b)]);

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

      legend({function_str, 'a', 'b', 'final approximation p_n','ps'}, 'Location', 'northwest');
      hold off;
      return;
    endif

    ## STEP 6
    ##solve for a[i], b[i];
    if ((f(a)*Fp)>0) #p replaces a; same sign
      a = p;
      Fa = Fp;
    else
      b = p;
      Fb = Fp;
    endif


    past_p = p;

    ##PLOT the p
    #scatter(p, Fp, 5, 'b', 'filled');
    #text(p, Fp, ['p' n_str],"fontsize",15);
  endfor

          # plot the ps
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

  hold off;

  ## STEP 7
  fprintf('error. Method failed after %d iterations, TOL:%f,\t last p: %f\n',N, TOL, p);
end
