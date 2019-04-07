function[result1] = upward_slope_impact(a,e)
% inputs are angle in degree and length of slope in m
% this is specific function for the ball on the downwar slope then hit the
% wall then bounce up
global GlobalXYT;
global muy;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);


g= 9.81;
Coeff = muy;
angle = a*pi/180;

dtime = 0.001;
initialVelX=(GlobalXYT(end,1)-GlobalXYT(end-2,1))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));
vi = -initialVelY*sin(angle)+ initialVelX*cos(angle);

V_along_ramp_X = -e*vi*cos(angle);
V_along_ramp_Y = e*vi*sin(angle);
V_after =  V_along_ramp_Y*sin(angle)- V_along_ramp_X*cos(angle);
%V_magnitude = sqrt(V_after^2 + 10*g*sin(angle)/7);

 
%acc = g*(sin(angle)- Coeff*cos(angle)); %acceleration
acc = -5*g*sin(angle)/7;
%V_magnitude = sqrt(vi^2 + 10*g*sin(angle)/7);

%Solving for time
syms T;
eqn = 0 == acc*T + V_after; % the ball goes up on the hill until the velocity is 0
solT = double(solve(eqn,T));
calculatedT = solT(solT>0);
calculatedT = min(calculatedT);
t = 0: dtime: calculatedT;
d = V_after * t + 0.5 * acc * t.^2;
x = x0 - d * cos(angle);
y = y0 + d * sin(angle);
time = GlobalXYT(end,3) + t;
result1 = [x' y' time' ];

end