#{
  Write an Octave code that gives the LU factorization of any matrix.

  user inputs an nxn matrix o
#}

clc;
printf('\t\tNumerical Analysis\n');
fprintf('\t\t---Coding Exam---\n\n');
n = input('Enter the size of your square matrix: ');


while ~isnumeric(n) || ~isscalar(n) || n <= 1
    clc
    fprintf('\t\tNumerical Analysis\n');
    fprintf('\t\t---Coding Exam---\n\n');
    disp('Invalid input. Please enter a positive integer greater than 1.\n');
    n = input('Enter the size of your square matrix: ');
end

fprintf('\nmatrix size: %d\n\n',n);

num_rows=n;
num_cols=n;
A = zeros(n,n);

% Prompt the user for each row in the matrix
for i = 1:num_rows
    prompt = sprintf('Enter row %d values (separated by spaces): ', i);
    user_input = input(prompt, 's'); % 's' flag reads input as a string

    % Split the input string into individual values
    values = str2num(user_input);

    % Check if the input is numeric and has the correct number of columns
    while ~isnumeric(values) || numel(values) ~= num_cols
        fprintf('Invalid input. Please enter %d numeric values.\t or enter ''x'' to quit\n', num_cols);
        user_input = input(prompt, 's');

        if(user_input == 'x')
          fprintf('\nprogram terminated.\n\n');
          return;
        endif
        values = str2num(user_input);
    end

    A(i, :) = values;
end

% Display the resulting matrix
clc;
printf('\t\tNumerical Analysis\n');
fprintf('\t\t---Coding Exam---\n\n');
fprintf('\nmatrix size: %d\n\n',n);
fprintf('User Matrix:\n');
disp(A);
fprintf('\n\n');

[U, L] = fn_LU_factorization(A);

fprintf('Upper triangular matrix U:\n');
disp(U);
fprintf('\n\n');

fprintf('Lower triangular matrix L:\n');
disp(L);
fprintf('\n\n');

  find_solutions = false;

  fprintf('Would you like to continue and find solutions?\n');
    prompt2 = sprintf('\t[1] Enter 1 for Yes.\n\t[0] Enter 0 for No.\n>> ');
    user_input_str = input(prompt2, 's');
    user_input = str2double(user_input_str);

    ## validate input
    while isnan(user_input) || ~ismember(user_input, [0, 1])
        fprintf('\nInvalid input. Please enter 0 or 1.\n');
        user_input_str = input(prompt2, 's');
        user_input = str2double(user_input_str);
    end

  if user_input == 1

      b = zeros(n,1);

      # perform input of b
      for i = 1:num_rows
          prompt = sprintf('\tEnter b%d: ', i);
          b(i, 1) = input(prompt);
      endfor

      x = fn_LU_decomposition(A,b);
      clc;
      printf('\t\tNumerical Analysis\n');
      fprintf('\t\t---Coding Exam---\n\n');
      fprintf('\nmatrix size: %d\n\n',n);
      fprintf('User Matrix:\n');
      disp(A);
      fprintf('\n\n');
      fprintf('Upper triangular matrix U:\n');
      disp(U);
      fprintf('\n\n');
      fprintf('Lower triangular matrix L:\n');
      disp(L);
      fprintf('\n\n');
      fprintf('right side of equations:\n');
      for(i=1:num_rows)
          fprintf('\tb%d: %f\n',i,b(i,1));
      endfor
      fprintf('\nUnique solution found:\n');
      for(i=1:num_rows)
          fprintf('\tx%d: %f\n',i,x(i,1));
      endfor

  else
      fprintf('\nprogram terminated.\n\n');
      return;
  endif




