
  # Gaussian Example 4
  A = [1 -1 2 -1;
       2 -2 3 -3;
       1 1 1 0;
       1 -1 4 3;];
   b = [-8;
       -20;
       -2;
       4;];

  A = [5 1 1;
       1 4 1;
       1 1 3;];
  b = [5;        # column vector of right side equation
       4;
       3;];



  augmented_A = [A, b]  #Augmented Matrix

  fn_gaussian_elimination(augmented_A);

