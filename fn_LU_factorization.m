function [U, L] = fn_LU_factorization(A)


  if (rows(A) != columns(A))
      printf('error. A is NOT a square matrix!!!\n');
      output = [0];
      return;
  endif

  n = rows(A);

  L = eye(n); ##lower triangular matrix
  U = eye(n);

  ## START LU FACTORIZATION:

    ## STEP1:
    U(1,1) = A(1,1) / L(1,1);
    if (L(1,1) * U(1,1)) == 0
        fprintf('error. LU Factorization impossible.\n');
        return;
    endif

    ## STEP2:
    for (j=2:n)
        U(1,j) = A(1,j)/L(1,1);   # first row of U
        L(j,1) = A(j,1)/U(1,1);   # first col of L
    endfor

    #fprintf('DEBUG #%d\n',1);
    #L
    #U

    ## STEP3:
    for(i=2:n-1)

        ## STEP4:
        summation = 0;
        for (k=1:i-1)
            summation = summation + (L(i,k) * U (k,i));
        endfor
        U(i,i) = (A(i,i) - summation)/ L(i,i);

        if (L(i,i)*U(i,i)) == 0
          fprintf('error. LU Factorization impossible.\n');
          return;
        endif

        ## STEP5:
        for(j=i+1:n)
            summation1=0;
            summation2=0;
            ## summation:
            for(k=1:i-1)
                summation1 = summation1 + (L(i,k) .* U(k,j));
                summation2 = summation2 + (L(j,k) .* U(k,i));
            endfor

            U(i,j) = 1/(L(i,i)) * (A(i,j) - summation1);
            L(j,i) = 1/(U(i,i)) * (A(j,i) - summation2);
        endfor



    endfor

    ## STEP6:
    summation = 0;
    for (k=1:n-1)
        summation = summation + (L(n,k) * U (k,n));
    endfor
    U(n,n) = (A(n,n) - summation)/ L(n,n);

    if (L(n,n) .* U(n,n)) == 0
        fprintf('NOTE: matrix A is singular.\n');
    endif

    ## STEP7:
    ## A is now factored into U and L triangular matrices.
    # L
    # U
    # L*U

  end
