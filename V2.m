#{
  GAUSSIAN ELIMINATION

 Construct a code that utilizes the given algorithm in class for Gaussian elimination with backward
 substitution to solve the solution of any linear system.
#}

  A = [5 1 1;
       1 4 1;
       1 1 3;];
  b = [5;        # column vector of right side equation
       4;
       3;];


  augmented_A = [A, b]  #Augmented Matrix

  x = fn_gaussian_elimination(augmented_A);

  #fprintf('The alpha symbol is: \xCE\xB1\n');
  #fprintf('Beta: \xCE\xB2\n');
  #fprintf('Gamma: \xCE\xB3\n');

