 function [v,x3,y3] = dedrift_velocity(t,x,y,xo,yo,theta)
theta1 = degtorad(theta);

x2 = x*cos(theta1)-y*sin(theta1); %counter clockwise rotation
y2 = x*sin(theta1)+y*cos(theta1);

plot(x,y,'g',x2,y2,'r',xo,yo,'b');
legend('traj. after dedrift','rotated traj.','Original traj.');
hold on;
axis equal;

figure;
x3 = 0.07686*x2;
y3 = 0.07686*y2;
plot(t,y3);
hold on;

dlm1 = fitlm(t,y3,'y~x1-1');
yf = dlm1.Coefficients{1,1}*t;

plot(t,yf);
axis equal;

xlabel('Time (s)'); ylabel('y (\mum)');

string2 = sprintf('y = %0.5f(um/s)x',dlm1.Coefficients{1,1});
text (5,30,string2);
v = dlm1.Coefficients{1,1};
end
%title('DMLT(-3)-0-1151   velocity'); %phi=0.3-0-1066