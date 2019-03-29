% we can assume the time of impact is very less

function[vin] = impact(vout, wout)
vin = 5;                % initial velocity
radius = (7.5*10E-3);    % radius of the ball
win = vin/radius        % initial angular velocity
e =   0.8;              % co-efficient of restitution
  
% as the wall is stationary, the initial and final velocities is going to
% be zero

vout = - e*vin;          % final velocity
wout = vout/(7.5*10E-3); % final angular velocity (assuming rolling without slipping)

end 
