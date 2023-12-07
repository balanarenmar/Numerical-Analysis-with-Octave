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

  L = eye(n); ##lower triangular matrix

  unique_solution = true;
  for i = 1:n-1
    En  = A(i, :);  ## row i
    col = A(:, i);  ## column i

    col(1:i-1) = 0;    ## ignore rows above i
    p = find(col, 1);  ## find index of first non-zero value in col i
    if isempty(p)
      fprintf('No unique solution exists.\n');
      error('no unique solutions.');
      unique_solution = false;
      return;
    endif

    ##debug fprintf('col:%d\tpivot index:%d\n', i, p);
    if (p != i) #Swap
        temp_row = A(p, :);  ## temp row
        A(p, :) = A(i, :);
        A(i, :) = temp_row;
    endif


    for j = i+1:n
      mji = A(j,i)/A(i,i);

      L(j,i) = mji; ##store lambda

      Ej = A(j, :) - (mji.*A(i, :));
      A(j, :) = Ej;
    endfor

endfor

A

    if (A(n,n) == 0)
      fprintf('No unique solution exists.\n');
      unique_solution = false;
      return;
    endif

    ## Backward Substitution
    x = zeros(n,1);        #Store the answers
    x(n,1) = A(n,n+1)./A(n,n);

    for i = n-1:-1:1
        summation = 0;
        for j = i+1:n
          summation = summation + (A(i,j) .* x(j,1));
        endfor
        ##debug fprintf('summation:%d\n',summation);
        x(i,1) = (A(i,n+1) - summation) ./ A(i,i);
    endfor

    fprintf("Procedure Completed Successfully\n");
    x
    ## X is a row vector containing solutions

 end
