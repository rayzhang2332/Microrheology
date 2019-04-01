function v = aveV(filename)

a = importdata(filename);
t=a(:,1)-a(1,1);x=a(:,2)-a(1,2);y=a(:,3)-a(1,3);

plot(t,y);
hold on;

f = polyfit(t,y,1);
yf = f(1,1)*t +f(1,2);
plot(t,yf);
axis equal;

xlabel('Time (s)'); ylabel('y (\mum)');

string2 = sprintf('y = %0.5f(um/s)x + %0.5f',f(1,1),f(1,2));
text (5,30,string2);
v = f(1,1);
end
