
  TOL = 1e-5;  ## 0.00001 default tolerance 5 decimal places
  N = 100;     ## N is max iterations
  points = 100;

  format;
  ## Matrix size
  n = 5;        ## Number of Unknowns & Equations
  m = n;


  #A = zeros(n,n+1); ## Initialize Matrix as zeros
  B = [1 1 0 3 4;
       2 1 -1 1 1;
       3 -1 -1 2 -3;
       -1 2 3 -1 4;
      ];
   A = [0 1 0 3 4;
         2 1 -1 1 1;
         3 -1 0 2 -3;
         0 0 1 4 5;
        ]

  En  = A(1, :);  ## row 1
  col = A(:, 1); ## colon 1



  for i = 1:n-1

    p = find(col, i);  ## Index of first non-zero value in col i
    fprintf('i:%d\tp:%d', i, p);
    if (p != i)
      #Swap
      temp_row = A(p, :);  ## temp row
      A(p, :) = A(i, :);
      A(i, :) = temp_row;
    endif


  endfor

