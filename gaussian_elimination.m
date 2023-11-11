function [augmented_matrix, unique_solution] = gaussian_elimination(augmented_matrix)
    [rows, cols] = size(augmented_matrix);
    unique_solution = true;

    for i = 1:min(rows, cols - 1)
        % Find pivot row p
        p = find(augmented_matrix(i:end, i), 1) + i - 1;

        % Check if a valid pivot element is found
        if isempty(p)
            fprintf('No unique solution exists.\n');
            unique_solution = false;
            return;
        end

        % Swap rows i and p
        augmented_matrix([i, p], :) = augmented_matrix([p, i], :);

        % Elimination
        for j = i + 1:rows
            factor = augmented_matrix(j, i) / augmented_matrix(i, i);
            augmented_matrix(j, :) = augmented_matrix(j, :) - factor * augmented_matrix(i, :);
        end
    end

    fprintf('Gaussian elimination completed.\n');
end



