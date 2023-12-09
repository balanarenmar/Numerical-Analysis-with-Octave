function x = fn_gaussian_elimination(A)

  format;
  ## Matrix size
  n = rows(A);        ## Number of Unknowns & Equations

  if (n >= columns(A))
      printf('error. The input was not an augmented matrix!!! aborting\n');
      error('input not in correct format.');
      x = [0];
      return;
  endif

  m = n;
  unique_solution = true;


  ## STEP 1
  for i = 1:n-1
      En  = A(i, :);  ## row i
      col = A(:, i);  ## column i

      col(1:i-1) = 0;    ## ignore rows above i

      ## STEP 2
      p = find(col, 1);  ## find index of first non-zero value in col i
      if isempty(p)
        fprintf('No unique solution exists.\n');
        error('no unique solutions.');
        unique_solution = false;
        return;
      endif

      ## STEP 3
      if (p != i) #Swap
          temp_row = A(p, :);  ## temp row
          A(p, :) = A(i, :);
          A(i, :) = temp_row;
      endif

      ## STEP 4
      for j = i+1:n

        ## STEP 5
        mji = A(j,i)/A(i,i);

        ## STEP 6
        Ej = A(j, :) - (mji.*A(i, :));
        A(j, :) = Ej;
      endfor

  endfor

    ## STEP 7
    if (A(n,n) == 0)
      fprintf('No unique solution exists.\n');
      error('no unique solutions.');
      unique_solution = false;
      return;
    endif

    ## Backward Substitution
    x = zeros(n,1);        #Store the answers. x is a row column containing solutions

    ## STEP 8
    x(n,1) = A(n,n+1)./A(n,n);

    ## STEP 9
    for i = n-1:-1:1
        summation = 0;
        for j = i+1:n
          summation = summation + (A(i,j) .* x(j,1));
        endfor
        ##debug fprintf('summation:%d\n',summation);
        x(i,1) = (A(i,n+1) - summation) ./ A(i,i);
    endfor
    fprintf("Augmented matrix in reduced echelon form:\n");
    disp(A);

    ## STEP 10
    fprintf("\nThe system of Linear equations A has been solved (Gaussian Elimination)! solution:\n");

    for(i=1:n)
        fprintf('\tx%d: %f\n',i,x(i,1));
    endfor



 end
