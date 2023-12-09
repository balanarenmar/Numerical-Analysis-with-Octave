function output = fn_fixed_point_iteration(f, p0, TOL, N)

  offset = 5;   # determines the size of plotted graph
  a = p0 - offset;
  b = p0 + offset;

  points = 10000;
  ## a, b are endpoints of graph
  ## p0 is initial approximation

  ##prepare formatting
  format;
  %output_precision(digit)

  #x values range from a to b
  x = linspace(a,b,points);
  y = f(x);

  Fa = f(a);
  Fb = f(b);

  ## PLOTTING
  plot(x,y) ##plot the line
  grid on;
  title('Fixed Point Iteration');
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
  % Set the aspect ratio to equal
  axis equal;
  hold on;

  edge = max(max(abs(x_limit)), max(abs(y_limit)));
  xy = linspace(-edge,edge,5);
  plot(xy, xy, 'r--');
  label_x = xy(4);  % Adjust as needed for label placement
  label_y = xy(4);  % Adjust as needed for label placement
  text(label_x, label_y, 'y=x', 'FontSize', 20, 'Color', 'r');

  #store computed values
  fixedpoint_result = zeros(0,3);
  column_labels = {'n', 'p', 'f(p)'};
  midpoint = (a + (b - a) / 2);

  #initial guess: p0
  px = p0;
  #plot p0
  scatter(px, f(px), 10, 'k', 'filled');
  text(px, f(px), [' p_{0}=' num2str(px)],"fontsize",15);

  ## FIX EQUATION FORMATTING for legend printing
  function_str = func2legend(f);
  fprintf('Fixed point iteration of f(x) = %s \n',function_str);
  fprintf('n\tp\t\tf(p)\t\ta_error\t\n');
  init_aprox = p0;

  ## Fixed Point Iteration LOOP
  ## STEP 1, 2, & 5
  for i = 1:N
    n_str = num2str(i);
    ## STEP 3
    p = f(p0);

    #Store data
    new_row = zeros(1,3);
    new_row(1,1) = i;
    new_row(1,2) = p0;
    new_row(1,3) = p;
    fixedpoint_result = vertcat(fixedpoint_result, new_row);
    fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];
    assignin('base', 'fixedpoint_result', fixedpoint_result_cell);

    ##STOPPING CONDITION
    abs_error = fn_abs_err(p0, p);
    #rel_error = fn_rel_err(p0, p);

    fprintf('%d\t%.10f\t%.10f\t%.11f \n',i,p0,p,abs_error); ## no rel_error
    if (abs_error < TOL)
      output = p;
      fprintf('\nFIXED POINT REACHED at x=%f at iteration %d, from p0=%f\n',p0,i,init_aprox);
      #plot(p0, p, 'k*');
      scatter(p0, p, 20, 'g', 'filled');

      fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];

      xdist=abs(p0-p0);        # distance from initial approx to fixed point
      ydist=abs(f(p0)-f(p0));
      maxDist = max(xdist, ydist);
      axisBorder = 1.5 * maxDist;   ## Makes plot axis 3x of maxDist
      xm = (p0 + p0) / 2;      # Calculate the midpoint
      ym = (f(p0) + p) / 2;

      ## MAKE CASE IF P0 is exactly a FIXED POINT
      if (xdist == 0)
        xlim([a, b]);
        ylim([a, b]);
      else
        text(p0, p, [' p_{', n_str, '}=' num2str(p0)],"fontsize",15, 'Color','k', 'FontSize', 15);
        xlim([xm-axisBorder, xm+axisBorder]);  # Set x-axis limits
        ylim([ym-axisBorder, ym+axisBorder]);
      end
      #fprintf(function_str);
      xlabel ('x');ylabel ('y');

      legend({function_str, 'y=x', 'initial approx.', 'final approx.'}, 'Location', 'northwest');

      hold off;

      return;
    endif

    ## mark the current approximation as a dot
    #scatter(p0, p, 5, 'b', 'filled');
    #text(p0, p, ['p' n_str],"fontsize",15);

    ## UPDATE VALUES
    ## STEP 6
    p0 = p;

endfor

  #if not found
  text(init_aprox, f(init_aprox), [' px=' num2str(init_aprox)],"fontsize",15);

  #zoom the plot, centered on p0
  xlim([init_aprox-15, init_aprox+15]);  % Set x-axis limits
  ylim([f(init_aprox)-15, f(init_aprox)+15]);
  output = p;
  hold off;

  ## STEP 7
  fprintf('error. Method failed after %d iterations, p0=%f. last value: %f\t\n',N,init_aprox, p);

end
