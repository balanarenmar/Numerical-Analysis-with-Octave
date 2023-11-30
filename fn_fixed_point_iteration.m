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
  text(px, f(px), ['p0=' num2str(px)],"fontsize",15);


  ## Fixed Point Iteration LOOP
  for i = 1:N
    n_str = num2str(i);
    py = f(px);

    fprintf('%3d\t p:%f\t p:%f\n',i,px,py);

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
    if (abs_error < TOL)
      output = py;
      fprintf('FIXED POINT REACHED at %f\n',py);
      #plot(px, py, 'k*');
      scatter(px, py, 20, 'g', 'filled');

      text(px, py, ['p' n_str '=' num2str(px)],"fontsize",15, 'Color','k', 'FontSize', 15);
      fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];

      fprintf('%f - %f = %f\n', p0, px, abs(p0-px));
      xdist=abs(p0-px);

      # Calculate the midpoint
      xm = (p0 + px) / 2;
      ym = (f(p0) + py) / 2;

      xlim([xm-xdist, xm+xdist]);  # Set x-axis limits
      ylim([ym-xdist, ym+xdist]);
      hold off;

      return;
    endif
    fprintf('\t abs err: %f\trel err: %f\n', abs_error, rel_error);

    ## mark the current approximation as a dot
    scatter(px, py, 5, 'b', 'filled');
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
