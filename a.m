% Prompt the user for the number of rows and columns in the matrix
num_rows = input('Enter the number of rows: ');
num_cols = input('Enter the number of columns: ');

% Initialize an empty matrix
user_matrix = zeros(num_rows, num_cols);

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
        if(user_input == x)
          fprintf('program terminated.\n');
          return;
        endif

        values = str2num(user_input);
    end

    user_matrix(i, :) = values;
end

% Display the resulting matrix
disp('User Matrix:');
disp(user_matrix);

