function outputStr = recursiveExtract4(str)
    pattern = '\^\((.*)\)';
    unpaired = 0;                 # counts unpaired parenthesis

    for i = 1:length(str)
        if str(i) == '^'
            if str(i+1) == '('    # EXPONENT PARSE found!
                i = i+2;            # move pointer to after ^(

                if str(i) == '('    # parenthesis inside exponent substring
                    unpaired = unpaired + 1;

                elseif
                else
                  continue;



                endif



            endif
            found = true;

        else
            continue;
        endif
    end



end
