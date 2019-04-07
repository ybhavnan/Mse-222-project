%projectile after a slope
function [results] = projectile(x1,y1,x2,y2)
%x1,y1 anbd x2, y2 is the coordinate of the ramp
global GlobalXYT;
dtime = 0.001; %1 mili second
g =-9.81;

x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);
VelX = (GlobalXYT(end,1)-GlobalXYT(end-2,1))/(GlobalXYT(end,3)-GlobalXYT(end-2,3))
VelY = (GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3))

m = (y2-y1)/(x2-x1)
b = y2-(m*x2)

%solving for time 
syms x y t
eq1 = x == x0 + VelX*t;
eq2 = y == y0 + VelY*t + 0.5*g*t.^2;
eq3 = y == m*x +b;
[xCalc,yCalc,time]=solve([eq1,eq2,eq3],[x,y,t]);
time = double(time); %Convert symbol to double
calculatedTime = time(time>0); %Take positive time
calculatedTime = min(calculatedTime) %Take the smallest number in the array
t=0:dtime:calculatedTime;
time=GlobalXYT(end,3)+t;
x = x0 + VelX*t;
y = y0 + VelY*t + (g*t.^2)/2;
results = [x',y',time'];
end
