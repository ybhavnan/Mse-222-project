function [x,y,time] = curve( r, phi, theta)
%theta is the angle of velocity at the end of arc
%phi is the angle of total arc
%r is radius of the curved
g = -9.81; %gravitational acceleration

global GlobalXYT;
phi = deg2rad(phi);
theta = deg2rad(theta);
dtheta = 0.001;
angle = theta: dtheta: phi;
l = 2*r* sin(dtheta/2); % length of curved after each theta
vi = 0;                 %initial velocity =0

time = 0 + GlobalXYT(end,3); %initializing the time
x = GlobalXYT(end,1);
y = GlobalXYT(end,2);

for i = angle(1:end-1)
    vf = sqrt(vi^2 + 10/7*g*r*(cos(i+dtheta)-cos(i)));
    dx = l*cos(i+dtheta);   %x distance moved through dtheta
    dy = -l*sin(i+dtheta);  %y distance moved through dtheta
    [x] = [x; x(end)+dx];   %adding increase dx
    [y] = [y; y(end)+dy];   %adding increase dy
    [time]=[time;time(end)+ ((dtheta*r/vf))];  %calculating time and adding it to the global time
     vi = vf;
end

end

    
    


