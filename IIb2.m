#{
  FIXED POINT ITERATION
  series of p0 values

 Construct an Octave function for the fixed-point iteration following the given algorithm in class.

  TRYING OUT MULTIPLE INITIAL approximations
#}

# function handle
g = @(x) x.^[x - cos(x)];

## a: smallest p0 to try
## b: largest  p0 to try
## N: number of attempts

a = 0.5;
b = 2;
N = 100;

p0_values = linspace(a,b,N);
p0_values = p0_values';
fixed_point_attempts = zeros(N,3);

#{#}
for(i=1:N)
  fixed_point_attempts(i,1) = p0_values(i,1);
  [fixed_point_attempts(i,2), fixed_point_attempts(i,3)]  = fn_FPI_noGraph(g, p0_values(i,1), 1e-8, 100);

endfor

column_labels = {'p0', 'fixed point', 'iterations'};
fixed_point_attempts = [column_labels; num2cell(fixed_point_attempts)];
disp(fixed_point_attempts);

