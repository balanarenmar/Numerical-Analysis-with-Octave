#{
  FIXED POINT ITERATION
  series of p0 values

 Construct an Octave function for the fixed-point iteration following the given algorithm in class.
#}

# function handle
g = @(x) (x.^[5]) - 3*(x.^[3]) - 2*(x.^[2]) + 2;

## a: smallest p0 to try
## b: largest  p0 to try
## N: number of p0 to try

a = 0.61803398;
b = 0.6180339888;

a=0.72593059;
b=0.72593065;
N = 1000;

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
#disp(fixed_point_attempts);
