#{
  LU FACTORIZATION

  Write an Octave code that gives the LU factorization of any matrix.
#}

  A = [1 1 0 4;
       2 -1 5 0;
       5 2 1 2;
       -3 0 2 6;];

  b = [1;
       -33;
       20;
       -15;]; # column vector

  [U, L] = fn_LU_factorization(A);
  x = fn_LU_decomposition(A, b);
