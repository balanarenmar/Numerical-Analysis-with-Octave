function [px, i] = fn_FPI_noGraph(f, p0, TOL, N)

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


  #store computed values
  fixedpoint_result = zeros(0,3);
  column_labels = {'n', 'p', 'f(p)'};
  midpoint = (a + (b - a) / 2);

  #initial guess: p0
  px = p0;

  ## FIX EQUATION FORMATTING for legend printing
  function_str = func2legend(f);
  fprintf('Fixed point iteration of f(x) = %s \n',function_str);
  #fprintf('n\tp\t\tf(p)\t\ta_error\t\tr_error\n');
  init_aprox = p0;
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
    #rel_error = fn_rel_err(px, py);

    #fprintf('%d\t%.10f\t%.10f\t%.11f \n',i,px,py,abs_error); ## no rel_error
    if (abs_error < TOL)
      output = py;
      fprintf('\nFIXED POINT REACHED at x=%f at iteration %d, from p0=%f\n',px,i,init_aprox);
      fixedpoint_result_cell = [column_labels; num2cell(fixedpoint_result)];

      return;
    endif

    ##UPDATE VALUES
    px = py;

endfor

  #output = px, i;
  fprintf('error. Method failed after %d iterations, p0=%f. last value: %f\t\n',N,init_aprox, py);
end
