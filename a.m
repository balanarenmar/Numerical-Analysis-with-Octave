% Assume x_min and x_max are the original x-axis limits
x_min = 0;
x_max = 10;

% Initial approximation p0 and the x-value of the absolute point px
p0 = 2;
px = 6;

% Calculate the desired x-distance
desired_x_distance = (x_max - x_min) / 3;

% Calculate the new x-axis limits based on the desired x-distance
new_x_min = px - desired_x_distance;
new_x_max = px + desired_x_distance;

% Plot your data
x = linspace(x_min, x_max, 100);
y = sin(x);
plot(x, y);
hold on;

% Mark the points p0 and px on the plot
scatter(p0, sin(p0), 'ro', 'filled');  % Mark p0 in red
scatter(px, sin(px), 'bo', 'filled');  % Mark px in blue

% Adjust the x-axis limits
xlim([new_x_min, new_x_max]);

xlabel('X-axis');
ylabel('Y-axis');
title('Graph with Adjusted X-axis Limits');

