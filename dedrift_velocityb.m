 function [v,x3,y3] = dedrift_velocityb(t,x,y,xo,yo,theta)
 
% This function is used to calculate ave. velocity when bead moves in X direction
% The pixel inf: 0.1065 um/pixel 

theta1 = degtorad(theta);

x2 = x*cos(theta1)+y*sin(theta1); %clockwise rotation
y2 = -x*sin(theta1)+y*cos(theta1);

plot(x2,y2,'r',x,y,'g',xo,yo,'b');
legend('rotated traj.','traj. after dedrift','Original traj.');
hold on;
axis equal;

figure;
x3 = 0.1065*x2;
y3 = 0.1065*y2;
plot(t,x3);
hold on;

dlm1 = fitlm(t,x3,'y~x1-1');
xfit = dlm1.Coefficients{1,1}*t;

plot(t,xfit);
axis equal;

xlabel('Time (s)'); ylabel('x (\mum)');

string2 = sprintf('x = %0.5f(um/s)t',dlm1.Coefficients{1,1});
text (5,30,string2);
v = dlm1.Coefficients{1,1};
end