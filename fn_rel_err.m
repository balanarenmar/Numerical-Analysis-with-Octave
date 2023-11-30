function A = fn_rel_err(true_val, aprx)

  if true_val == 0
    error("Undefined. True value cannot be Zero (0)");
  else
    A = (fn_abs_err(true_val,aprx) / abs(true_val));
  endif

end
