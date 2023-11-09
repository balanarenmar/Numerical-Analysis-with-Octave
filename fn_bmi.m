function A = fn_bmi()
  height = [1.78 1.85 1.73 1.68 1.81];
  weight = [68 89 64 51 106];

  ## For loop: You know how many times

  for i = 1:5
    BMI (i) = weight(i)/height(i)^2;

    if BMI(i) <18.5
      category = 'Underweight';
    elseif BMI(i) < 25
      category = 'Normal Weight';
    elseif BMI(i) < 30
      category = 'Over Weight';
    else
      category = 'Obese';
    end
    fprintf('%d %.2f %3d %.1f %s\n',i,height(i),weight(i),BMI(i),category);
  endfor

  A = BMI;

end
