% downward slope and horizontal path
function[result1] = downward_slope(a, distance,b)
% inputs are angle in degree and length of slope in m and whether the there
% is impact at the start
global GlobalXYT;
global muy;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);
e=0.8;

g= 9.81;
Coeff = muy;
slopeLength = distance;
angle = a*pi/180;
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-2,1))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
dtime = 0.01;
vi = initialVelY*sin(angle)- initialVelX*cos(angle);

if (b == false)               %there is no impact before the downward slope
    V_magnitude = sqrt(vi^2 + 10*g*sin(angle)/7);
else                          %there is impact to the wall and it bounces back
    V_along_ramp_X = -e*vi*cos(pi-angle);
    V_along_ramp_Y = -e*vi*sin(pi-angle);
    V_after =  V_along_ramp_Y*sin(pi-angle)- V_along_ramp_X*cos(pi-angle);
    V_magnitude = sqrt(V_after^2 + 10*g*sin(angle)/7);
end 

%acc = g*(sin(angle)- Coeff*cos(angle)); %acceleration
acc = 5*g*sin(angle)/7;


%Solving for time
syms T;
eqn = 0 == 0.5*acc*T^2 + V_magnitude*T - slopeLength;
solT = double(solve(eqn,T));
calculatedT = solT(solT>0);
calculatedT = min(calculatedT);
t = 0: dtime: calculatedT;
d = V_magnitude* t +0.5 * acc * t.^2;
x = x0 + d * cos(angle);
y = y0 - d * sin(angle);
time = GlobalXYT(end,3) + t;
result1 = [x' y' time' ];

end




