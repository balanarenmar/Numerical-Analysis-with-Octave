function A = fn_round(x, digit)
  format;
  #output_precision(digit) ##SETS HOW MANY DIGITS TO USE

  if digit<=0
    error("Significant digits must be a positive integer");
  endif
  decimal = mod(x,1);
  digit = digit + 1;

  significant = x*(10^digit);
  next_digit = mod(significant,10);

  ## Round Up
  if next_digit >= 5
    significant = significant + 10 - next_digit;
  endif


  fprintf('step1: %f\n',significant);
  A = floor(significant);
  fprintf('step2: %f\n',A);
  A = A*(10^(-1*digit));
  fprintf('step3: %f\n',A);

end
