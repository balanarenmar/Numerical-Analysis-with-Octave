function A = fn_rel_err(true_val, aprx)

  if true_val == 0
    fprintf("error: Cannot compute relative error. Denominator cannot be Zero (0). Undefined.\n");
    return;
  else
    A = (fn_abs_err(true_val,aprx) / abs(true_val));
  endif

end
