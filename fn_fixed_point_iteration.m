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
  % Set the aspect ratio to 'equal' and specify axis limits and tick locations
  #axis([x_limit, y_limit]);

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
  text(px, f(px), ['p_{0}=' num2str(px)],"fontsize",15);

  ## FIX EQUATION FORMATTING for legend printing
  function_str = func2legend(f);

  fprintf('n\tp\t\tf(p)\t\ta_error\t\tr_error\n');

  ## Fixed Point Iteration LOOP
  for i = 1:N
    n_str = num2str(i);
    py = f(px);

    #Store data
    new_row = zeros(1,3);
    new_row(1,1) = i;
    new_row(1,2) = px;
    new_row(1,3) = py;
    fixedpoint_result = vertcat(fixedpoint_result, new_row);
    fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];
    assignin('base', 'fixedpoint_result', fixedpoint_result_cell);

    ##STOPPING CONDITION
    abs_error = fn_abs_err(px, py);
    rel_error = fn_rel_err(px, py);

    fprintf('%d\t%.10f\t%.10f\t%.11f\t%.11f \n',i,px,py,abs_error,rel_error);

    if (rel_error < TOL)
      output = py;
      fprintf('FIXED POINT REACHED at x=%f\n',py);
      #plot(px, py, 'k*');
      scatter(px, py, 20, 'g', 'filled');


      fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];

      xdist=abs(p0-px);        # distance from initial approx to fixed point
      ydist=abs(f(p0)-f(px));
      maxDist = max(xdist, ydist);
      axisBorder = 1.5 * maxDist;   ## Makes plot axis 3x of maxDist
      xm = (p0 + px) / 2;      # Calculate the midpoint
      ym = (f(p0) + py) / 2;

      ## MAKE CASE IF P0 is exactly a FIXED POINT
      if (xdist == 0)
        xlim([a, b]);
        ylim([a, b]);
      else
        text(px, py, ['p_{', n_str, '}=' num2str(px)],"fontsize",15, 'Color','k', 'FontSize', 15);
        xlim([xm-axisBorder, xm+axisBorder]);  # Set x-axis limits
        ylim([ym-axisBorder, ym+axisBorder]);
      end
      #fprintf(function_str);
      xlabel ('x');ylabel ('y');


      function_str
      legend({function_str, 'y=x', 'initial approx.', 'final approx.'}, 'Location', 'northwest');

      hold off;

      return;
    endif

    ## mark the current approximation as a dot
    #scatter(px, py, 5, 'b', 'filled');
    #text(px, py, ['p' n_str],"fontsize",15);

    ##UPDATE VALUES
    px = py;

endfor

  #if not found
  text(px, f(px), ['px=' num2str(px)],"fontsize",15);

  #zoom the plot, centered on p0
  xlim([p0-15, p0+15]);  % Set x-axis limits
  ylim([f(p0)-15, f(p0)+15]);

  hold off;
  error('Method failed after %d iterations, last value: %f',N, py);

end
