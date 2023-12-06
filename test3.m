#% Example usage:
str = 'e^(abcd(ignore)^(efg(ignore))hijk)';
str = 'e^(x)+e^(-x)-5-x(x)'

newstr = recursiveExtract3(str)
#fprintf(newstr);test3
