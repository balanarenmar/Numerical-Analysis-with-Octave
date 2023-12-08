function x = fn_LU_decomposition(A, b)

  ## where A is a square matrix
  ## and b is a column vector of right side of equation

  ## Check if matrix A is nxn. else
  if (rows(A) != columns(A))
      printf('error. A is NOT a square matrix!!!\n');
      errer('aborted.');
      x = [0];
      return;
  endif

  n = rows(A);

  [U, L] = fn_LU_factorization(A);

  # forward substitution
  # A * x = b.        # let A = L * U
  # L * U * x = b     # let y = U * x
  # L * y = b         #solve for y.

  L
  U

  x = zeros(n,1);        #column vector
  y = zeros(n,1);

  y(1, 1) = b(1,1)./L(1,1);

  for (i=2:n)
      summation = 0;
      for j = 1:i-1
          summation = summation + (L(i,j) .* y(j, 1));
      endfor
      y(i,1) = b(i,1) - summation;
  endfor

 # y
 #{#}
  fprintf('   Computed y values:\n');
  for(i=1:n)
      fprintf('\ty%d: %f\n',i,y(i,1));
  endfor
  fprintf('\n');

  # backward substitution
  x(n,1) = y(n,1) / U(n,n);


  for i = n-1:-1:1
      summation = 0;
      for j = i+1:n
        summation = summation + (U(i,j) .* x(j, 1));
      endfor
      ##debug fprintf('summation:%d\n',summation);
      x(i, 1) = (y(i,1) - summation) ./ U(i,i);
  endfor

  fprintf("The system of Linear equations A has been solved (LU Decomposition)! solution:\n");
    for(i=1:n)
        fprintf('\tx%d: %f\n',i,x(i,1));
    endfor

  return;
  end
