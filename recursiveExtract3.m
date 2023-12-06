function outputStr = recursiveExtract3(str)
    pattern = '\^\((.*)\)';

    matches = regexp(str, pattern, 'tokens', 'once');

    if ~isempty(matches)
        resultString = matches{1}
        % Recursive call with the extracted substring
        innerStr = recursiveExtract3(resultString);

        % Check if there are more '(' after the current ')' in innerStr
        found = false;
        for i = 1:length(innerStr)
            if innerStr(i) == '('     #new parentheses parse starts,
                found = true;
                break;
            elseif innerStr(i) == ')'
                % CLOSING MARK, before any new parenthese pair starts. therefore this becomes }
                innerStr(i) = '}';  % Replace ')' with '}'
                break;
                #str = strrep(str, ['^(' resultString ')'], ['^{' innerStr(1:i) '})']);
                #outputStr = str;
                #return; % exit the function
            endif
        end

        % If '(' appears later, ignore the next ')'
        if found
            str = strrep(str, ['^(' resultString ')'], ['^{' innerStr '})']);
        else
            % Replace the original substring with the modified one
            str = strrep(str, ['^(' resultString ')'], ['^{' innerStr '}']);
        end
    end

    outputStr = str;
end

