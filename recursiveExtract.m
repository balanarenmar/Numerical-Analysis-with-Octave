function recursiveExtract(str)
    pattern = '\^\((.*)\)';

    matches = regexp(str, pattern, 'tokens', 'once');

    if ~isempty(matches)
        exponentPart = matches{1};
        disp(exponentPart);
        % Recursive call with the extracted substring
        recursiveExtract(exponentPart);
    else
        disp(' -no more found');
    end
end

