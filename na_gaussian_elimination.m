  format;


  ## prompt user to input

   A = [1 -1 2 -1 -8;
       2 -2 3 -3, -20;
       1 1 1 0 -2;
       1 -1 4 3 4;
       ];
  #No unique solution:
  B = [1 -1 2 -1 -8;
       2 -2 3 -3, -20;
       1 1 1 0 -2;
       0 0 0 0 4;
       ];

  A = [5 1 1;
       1 4 1;
       1 1 3;];

  b = [5;        # column vector of right side equation
       4;
       3;];



    A = [1 -1 2 -1;
       2 -2 3 -3;
       1 1 1 0;
       1 -1 4 3;];
   b = [-8;
       -20;
       -2;
       4;];
  A = [A, b]  #Augmented Matrix


  ## Matrix size
  n = rows(A);        ## Number of Unknowns & Equations
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
    A
    L
endfor

A

    if (A(n,n) == 0)
      fprintf('No unique solution exists.\n');
      unique_solution = false;
      return;
    endif

    ## Backward Substitution
    x = zeros(1,n);        #Store the answers
    x(1, n) = A(n,n+1)./A(n,n);

    for i = n-1:-1:1
        summation = 0;
        for j = i+1:n
          summation = summation + (A(i,j) .* x(1, j));
        endfor
        ##debug fprintf('summation:%d\n',summation);
        x(1, i) = (A(i,n+1) - summation) ./ A(i,i);
    endfor

    fprintf("Procedure Completed Successfully\n");
    ## X is a row vector containing solutions
