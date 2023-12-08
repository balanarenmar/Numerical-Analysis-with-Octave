function A = fn_rel_err(true_val, aprx)

  if true_val == 0
    error("Cannot compute relative error of %f and %f. Denominator cannot be Zero (0). Undefined.\n",true_val, aprx);
    return;
  else
    A = (fn_abs_err(true_val,aprx) / abs(true_val));
  endif

end
