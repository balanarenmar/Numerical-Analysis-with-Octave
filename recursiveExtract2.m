function outputStr = recursiveExtract2(str)
    pattern = '\^\((.*)\)';

    matches = regexp(str, pattern, 'tokens', 'once');

    if ~isempty(matches)
        resultString = matches{1};
        % Recursive call with the extracted substring
        innerStr = recursiveExtract2(resultString)

        % Replace the original substring with the modified one
        str = strrep(str, ['^(' resultString ')'], ['^{' innerStr '}'])
    end

    outputStr = str;
end


