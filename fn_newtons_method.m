function output = fn_newtons_method(f, p0, TOL, N)

  offset = 4;     # determines the size of plotted graph
  a = p0 - offset;
  b = p0 + offset;
  points = 1000;

  pkg load symbolic;
  syms sym_x;
  sym_f = sym(f(sym_x));

  sym_df = diff(sym_f);
  df = function_handle(sym_df);

  ## NEWTON's FORMULA pn = pn-1 - [(f(pn-1))/(f'(pn-1))]

  ## FIX EQUATION FORMATTING for legend printing
  function_str = func2legend(f);

  derivative_str = func2str(df);
  derivative_str = strrep(derivative_str, '.', '');
  derivative_str = strrep(derivative_str, 'sym_x', 'x');
  derivative_str = strrep(derivative_str  , 'exp', 'e ^');
  derivative_str = strrep(derivative_str, '@(x)', '');
  derivative_str = strrep(derivative_str, ' ', '');
  derivative_str = strrep(derivative_str, '*', '');

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
    axis equal;
    hold on;

    y0 = zeros(1,points);
    plot(x,y0,'k','LineWidth', 0.5);

    #plot initial approximation p0
    scatter(p0, f(p0), 10, 'k', 'filled');
    text(p0, f(p0), [' p_{0}=' num2str(p0)],"fontsize",15);
  ## END -- PLOTTING

  #store computed values
  newtons_result = zeros(0,5);
  column_labels = {'n', 'p', 'f(p)', 'p+1', "f(p+1)"};


  init_approx = p0;
  p = p0; #initial approximation

  fprintf('f(x):\t%s\n',function_str);
  fprintf('f''(x):\t%s\n\n',derivative_str);

  %Perform Newton-Raphson iteration
  ## STEP 1, 2, 5
  for i = 1:N

      ## STEP 3
      p = p0 - f(p0) / df(p0);

      fprintf('i%d: p%d = %.9f\tf(p%d) = %.9f\tp%d = %.9f\tf(p%d) = %.9f\n', i, i-1, p0, i-1, f(p0), i, p, i, f(p));

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

      ## STEP 4
      if (abs_error < TOL)  ## CHANGED to absolute error to accept 0 as initial guess
          fprintf('Converged to solution: p%d = %.9f using Newton-Raphson Method.\n\n',i, p);

          ## PLOT last tangent line
          pn = newtons_result(i,2);
          tangent_line = df(pn) * (x - pn) + f(pn);
          plot(x,tangent_line,'g--', 'LineWidth', .5);

          ## Mark the root
          scatter(pn, f(pn), 50, 'g', 'filled');
          n_str = num2str(i);
          text(pn, f(pn), [' p_{', n_str, '}'],"fontsize",20);
          j=i-1;
          k=0;

          fprintf("NEWTON's FORMULA:\npn= %s\n", pn_formula_str);

          #zoom the plot, centered on p
          #xlim([p-offset, p+offset]);  % Set x-axis limits
          #ylim([f(p)-offset, f(p)+offset]);

          xDist=abs(init_approx-p);        # distance from initial approx to fixed point
          yDist=abs(f(init_approx)-f(p));
          maxDist = max(xDist, yDist);
          axisBorder = 3/2 * maxDist;   ## Makes plot axis 3x of maxDist
          xm = (init_approx + p) / 2;   ## Calculate the midpoint
          ym = (f(init_approx) + f(p)) / 2;

          ## MAKE CASE IF P0 is already a ROOT
          if (xDist == 0)
            xlim([a, b]);
            ylim([a, b]);
          else
            xlim([xm-axisBorder, xm+axisBorder]);  # Set x-axis limits
            ylim([ym-axisBorder, ym+axisBorder]);
          end

          legend({function_str, 'x axis', 'initial approx.', 'final tangent line', 'final approx.'}, 'Location', 'northwest');

          hold off;
          return;
      endif

      ## STEP 6
      p0 = p; % Update the approximation

      ## mark the current approximation as a dot
      #scatter(p, f(p), 10, 'b', 'filled');

  endfor
  hold off;
  error('Method failed after %d iterations, last value: %f',N, p);
  end
