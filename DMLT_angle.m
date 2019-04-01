% Calculate the angle of DMLT traj.

function [theta] = DMLT_angle(filename)
a = importdata(filename);
x=a(:,2)-a(1,2);y=a(:,3)-a(1,3);
xr = x*cos(pi/4)+y*sin(pi/4);
yr = -x*sin(pi/4)+y*cos(pi/4); %clockwise rotation. We have to roatae 45 degree to get fit, then rotate back

f = polyfit(xr,yr,1);

% Rotate to be perfect vertical
x2 = xr*sin(atan(abs(f(1,1))))-yr*cos(atan(abs(f(1,1))));   %Assume theta >0, atan(f(1,1))=pi/4-theta, so rotate back pi/4, the angle=pi/2-theta  cos(pi/2-x)=sin(x), same for sin.
y2 = xr*cos(atan(abs(f(1,1))))+yr*sin(atan(abs(f(1,1))));

plot(x,y,'g',x2,y2,'r');
legend('traj.','rotated traj.');
axis equal;
hold on;

theta = -rad2deg(((atan(f(1,1))-(pi/4))));
string1 = sprintf('Angle = %0.2f degree', theta);
text(20,50,string1);


