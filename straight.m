function [result1] = straight(x,y)
%(x,y) is the coordinate of the endpoint of the ramp
global GlobalXYT;
global muy;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);


g= 9.81;
Coeff = muy;
angle = double(atan2(y-y0,x-x0)*180/pi);
slopeLength = sqrt((y-y0).^2+(x-x0).^2);

dtime = 0.01;
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-2,1))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
vi = sqrt(initialVelX.^2+initialVelY.^2); % assume initial velocity = 1m/s


acc = g*(sin(angle)- Coeff*cos(angle)); %acceleration
%solving for time
syms T;
eqn = 0 == 0.5*acc*T^2 + vi*T - slopeLength;
solT = double(solve(eqn,T));
calculatedT = solT(solT>0);
calculatedT = min(calculatedT);
t = 0: dtime: calculatedT;
d = vi * t +0.5 * acc * t.^2;
x = x0 + d * cos(angle);
y = y0 + d *sin(angle);
time = GlobalXYT(end,3) + t;
result1 = [x' y' time' ];

end
