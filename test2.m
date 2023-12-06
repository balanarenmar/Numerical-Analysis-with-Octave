% Example usage:
#str = 'e^(abcd(ignore)^(efg(ignore))hijk)'
#newstr = recursiveExtract2(str)
#fprintf(newstr);

f = @(x) exp(x) + exp(-x) -5 -x;
function_str = func2legend(f);



