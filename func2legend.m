function function_str = func2legend(f)

  ## FIXES EQUATION FORMATTING for legend printing

  function_str = func2str(f);
  function_str = strrep(function_str, '.', '');       # Remove periods from the string

  ## REMEMBER TO ADD *1 to end example: e^{}*1
  function_str = strrep(function_str, ' * 1', '}');   # trick to close brackets when e has exponent.
  function_str = strrep(function_str, '@(x)', '');
  function_str = strrep(function_str, 'exp', 'e^{');
  function_str = strrep(function_str, 'e^{ ', 'e^{');
  function_str = strrep(function_str, '[', '{');
  function_str = strrep(function_str, ']', '}');
  function_str = strrep(function_str, ' ^ ', '^');
  function_str = strrep(function_str, '^ ', '^');
  function_str = strrep(function_str, 'cos (', 'cos(');
  function_str = strtrim(function_str);               # Remove leading and trailing whitespaces
  return;
  end
