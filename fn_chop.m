function A = fn_chop(x, digit)
  format;
  #output_precision(digit)

  if digit<=0
    error("Significant digits must be a positive integer");
  endif
  decimal = mod(x,1);

  significant = x*(10^digit);
  fprintf('step1: %f\n',significant);
  A = floor(significant);
  fprintf('step2: %f\n',A);
  A = A*(10^(-1*digit));
  fprintf('step3: %f\n',A);

end
