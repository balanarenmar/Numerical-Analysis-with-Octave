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

      #fprintf(' solution:\n');
      #fprintf(' \xCE\xB1 = %f\n',x(1,1));
      #fprintf(' \xCE\xB2 = %f\n',x(2,1));
      #fprintf(' \xCE\xB3 = %f\n',x(3,1));

