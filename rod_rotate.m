
function[result] = rod_rotate(mb, mr,rb,l)
global GlobalXYT;
%mb; mass of ball
%mr: mass of rod
%rb: radius of ball
%l: rod length
g = 9.81;
e = 0.2; % coefficient of restituition

%Conservation of momentum
v1= (GlobalXYT(end,1)- GlobalXYT(end-1,1))/(GlobalXYT(end,3)-GlobalXYT(end-1,3));
syms V2 VR2
I = (1/3)*mr*(l^2)+ 0.4*mb*rb^2+ mb*(l-rb)^2;
Ir = (1/3)*mr*(l^2);
eqns =[(l-rb)*mb*(V2 -v1)+I*VR2*(l-rb)==0 ,VR2-V2 -v1*e ==0];
[v2, vR2] = solve(eqns, [V2, VR2]);
v2 = double(v2);
vR2= double(vR2);
wr2 = vR2/(l-rb);%wr2 angular velocity of the rod
y1 = (mr*(l/2) + 0*(l-rb))/(mr + 0);

%conservation of energy
syms anglee
eqanglee = 0.5*mb*((v2^2))+(0.5*Ir*(wr2^2))-mr*y1*g == -mr*y1*g*cos(anglee)+ 0.5*mb*((l-rb)*0)+(0.5*Ir*0);
Sol_angle = double(solve(eqanglee, anglee));
angle = Sol_angle(Sol_angle>0);
angle = deg2rad(angle);
dtheta = 0.0001;
theta = 0:dtheta:angle;
omegaF =0;
t = 0+ GlobalXYT(end,3);
x = GlobalXYT(end,1);
y = GlobalXYT(end,2);

 for i = theta(1:(end-2))
     syms OM;
     eqn = 0.5*mb*((v2^2))+(0.5*Ir*(wr2^2))- mr*y1*g*cos(i) == (-mr*y1*g*cos(i+dtheta)+ 0.5*mb*((v2^2)) +(0.5*Ir*(OM.^2)));
     omega = solve(eqn, OM);
     omegad = double(omega);
     omegad = omegad(omegad>0);
     
     timee = dtheta ./ omegad;
     [omegaF] = [omegaF; omegad];
     x = [x; x(end) + l.*sin(dtheta)];
     y = [y; y(end) + l.*(1-cos(dtheta))];
     t = [t; t(end) + timee];
     wr2= omegad;
     v2 = omegad*l;
     y1 = y(end);
 end
 result =[x y t];

%figure;
%plot(tF, omegaF, 'b');
%xlabel('Time (s)');
%ylabel('Angular Velocity (rad/s)');
%hold on;

%figure;
%alphaF = diff(omegaF)./diff(tF(1:length(omega))');
%plot(tF(1:length(alphaF)), alphaF, 'r')
%xlabel('Time (s)');
%ylabel('Angular Acceleration (rad/s^2)');



end

