function A = fn_rel_err(true, aprx)

  if true == 0
    error("Undefined. True value cannot be Zero (0)");
  else
    A = (fn_abs_err(true,aprx) / abs(true));
  endif

end
