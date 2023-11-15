  format;
  ## Matrix size
  n = 4;        ## Number of Unknowns & Equations
  m = n;



  L = eye(n);   ## Diagonal Identity Matrix
  U = eye(n);

  A =[ 1  1  0  3;
       2  1 -1  1;
       3 -1 -1  2;
      -1  2  3 -1;
     ]

  b = [4;1;-3;4]; ## right hand side

  #{
  L = [1  0  0  0;
       2  1  0  0;
       3  4  1  0;
      -1 -3  0  1;
      ];
#}
  U = [1  1  0  3;
       0 -1 -1  -5;
       0  0  3 13;
      0  0  0 -13;
      ];


  if ( L(1,1).*U(1,1) == 0 )
     error('Factorization Impossible. Aborted');
  endif

  if (A(1,1) == 0)
    error('Factorization Impossible. Aborted');
  endif

  for j = 2:n
    U(1,j) = A(1,j) / L(1,1);   ## first row of U
    L(j,1) = A(j,1) / U(1,1);   ## first col of L
  endfor

  for i = 2:n-1
      ## STEP 4
      #{
      summation = 0;
      for k = 1:i-1
        summation = summation + (L(i,k) * U(k,i));
      endfor
      #}
      if ( L(1,1).*U(1,1) == 0 )
         error('Factorization Impossible. Aborted');
      endif

      for j = i+1:n
        summation1 = 0;
        for k = 1:i-1
          summation1 = summation1 + (L(i,k) * U(k,j));
        endfor

        summation2 = 0;
        for k = 1:i-1
          summation2 = summation2 + (L(j,k) * U(k,i));
        endfor

        U(i,j) = 1/L(i,i) .* (A(i,j) - summation1);   ## ith row of U
        L(j,i) = 1/U(i,i) .* (A(j,i) - summation2);   ## ith col of L
        i
        U
        L
      endfor
  endfor

  ## Step 6
  summation3 = 0;
  for k = 1:n-1
    summation3 = summation3 + (L(n,k) * U(k,n));
  endfor

  if (L(n,n) * U(n,n) == 0)
    printf('Note: the matrix A is singular.\n');
  elseif ((L(n,n) * U(n,n)) != A(n,n)-summation3)
    error('Something went wrong!');
  endif

  ## Step 7


