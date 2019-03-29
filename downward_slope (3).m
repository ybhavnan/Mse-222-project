%downward slope and horizontal path
function[result1] = downward_slope(a, distance)
% inputs are angle in degree and length of slope in m
global GlobalXYT;
global muy;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);


g= 9.81;
Coeff = muy;
slopeLength = distance;
angle = a*pi/180;

dtime = 0.01;
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-2,1))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
vi = sqrt(initialVelX.^2+initialVelY.^2); % assume initial velocity = 1m/s


acc = g*(sin(angle)- Coeff*cos(angle)); %acceleration

V_magnitude = sqrt(vi^2 + 10*g*sin(angle)/7);

%Solving for time
syms T;
eqn = 0 == 0.5*acc*T^2 + V_magnitude*T - slopeLength;
solT = double(solve(eqn,T));
calculatedT = solT(solT>0);
calculatedT = min(calculatedT);
t = 0: dtime: calculatedT;

d = V_magnitude * t +0.5 * acc * t.^2;
x = x0 + d * cos(angle);
y = y0 -d *sin(angle);
time = GlobalXYT(end,3) + t;
result1 = [x' y' time' ];

end






