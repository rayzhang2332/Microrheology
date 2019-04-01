function [theta] = DMLT_angle1(x,y)



% Clockwise rotation, to x-axis
xr = ox*cos(atan(f(1,1))) + oy*sin(atan(f(1,1)));
yr = -ox*sin(atan(f(1,1))) + oy*cos(atan(f(1,1)));

plot(x,y,'g',xr,yr,'r');
legend('traj.','rotated traj.');
axis equal;
hold on;

theta = -rad2deg(((atan(f(1,1))-(pi/4))));
string1 = sprintf('Angle = %0.2f degree', theta);
text(20,50,string1);