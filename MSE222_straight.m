%Develop code that can take any input velocity, position, time, and
%acceleration as a starting condition and output it afterwards. 
%We define the origin at the bottom left corner of the apparatus
clear all;
clc;

A = [0, 0.3];
B = [0.3, 0.4];
i = 1;
w = [0];
v_x = [0];
v_y = [0];
x = [0.3];
y = [0.4];
result1 = 0;
[v_x, v_y, w, Alpha, x, y, t, result1] = straight(A, B, x, y, v_x, v_y, w, i);

% Fixed Parameters
function [v_x, v_y, W, Alpha, X, Y, T, result1] = straight(A, B, x, y, v_xi, v_yi, w, i)
%A = [0, 0.3];         % Left point of the line
%B = [0.3, 0.4];       % Right point of the line
% Determine the bounds for the 
i_initial = i;
if A(1) < B(1)
    x_1 = A(1);
    x_2 = B(1);
else
    x_1 = B(1);
    x_2 = A(1);
end

if A(2) < B(2)
    y_1 = A(2);
    y_2 = B(2);
else
    y_1 = B(2);
    y_2 = A(2);
end

theta = atan((B(2)-A(2))/(B(1)-A(1)));  % Angle in degrees ? ? [-?/2, ?/2]
m = 0.004;  % Mass
r = 0.0075; % Radius of marble
g = 9.81;   % Gravity 
mu_k = 0.56;   % Kinetic coefficient of friction 
mu_s = 0.78;   % Static coefficient of friction (there doesn't seem to be much information about the coefficients of friction)
I_G = 2/5*m*r^2;    % Moment of inertia about the center of gravity
I_P = 7/5*m*r^2;    % Moment of inertia about the point of contact
increment = 0.01;   % Time increment value
%i = 1;              % This i is arbitarily chosen

%Input Parameters
%v_xi = 0;   % Initial x velocity
%v_yi = 0;   % Initial velocity
v_i = v_xi(i)*cos(theta)+v_yi(i)*sin(theta); % Initial velocity in the direction of the slope
%w_i = 0;    % Initial angular velocity
%x_i = 0.3;    % Initial X-position
%y_i = 0.4;    % Initial Y-position 

%Check for if the ball is on the straight
slope = (B(2)-A(2))/(B(1)-A(1));
b = B(2) - slope*B(1);
if 0.99*(slope*x(i) + b) <= y(i) && y(i) <= 1.01*(slope*x(i) + b) % Accept values within 1%
    on = 1;
else
    on = 0;
end

%Check number 1 for slipping
alpha(i) = abs(m*g*r*sin(theta)/I_P);   % Assume no slip and find alpha(i) for it
F_f(i) = I_G*alpha(i)/r;                    % Find assumed frictional force
if F_f(i) > mu_s*m*g*cos(theta)         % If assumed frictional force is greater than possible, it slips
    slip1 = 1;                              % Assign boolean value true
else
    slip1 = 0;                              % Assign boolean value false.
end

%Additional variables for use in calculations
t = 0;
%x(i) = x_i;
%y(i) = y_i;
%w(i) = w_i;
v(i) = v_i;


%Calculations for acceleration, velocity, position.
while (x_1<=x(i) && x(i)<=x_2 && y_1<=y(i) && y(i)<=y_2 && on == 1)        % Loops while marble remains inside the bounds of the track     
    %Check number 2 for slipping
    if ((v(i) >= 0 && 0.99*v(i) <= -w(i)*r && -w(i)*r <= 1.01*v(i)) || (v(i) <= 0 && 1.01*v(i) <= -w(i)*r && -w(i)*r <= 0.99*v(i)) && slip1 == 0)
        % If velocity from rotation isn't the same as velocity, it is
        % slipping. We check to make sure it is within 1% of the value
        slip = 0;
        alpha(i) = m*g*r*sin(theta)/I_P;
        F_f(i) = I_G*alpha(i)/r;
        %{
        if angle_rad < 0
            alpha(i) = -alpha(i); % Change the value of alpha(i) to represent clockwise acceleration
        end
        %}        
    else
        slip = 1;
        if (-w(i)*r < v(i)) %((w(i) > 0)&&(-w(i)*r < v(i))) || ((w(i) == 0) && (v(i) > 0)) || ((w(i) < 0) && (-w(i)*r < v(i)))
            % Conditions for negative friction. If the rotation is
            % positive, but the velocity is slower than the true value, the
            % friction acts to 
            F_f(i) = -mu_k*m*g*cos(theta);      % Account for possible negative friction (directional)
        else
            F_f(i) = mu_k*m*g*cos(theta);
        end
        alpha(i) = F_f(i)*r/I_G;                    % Change alpha(i) to value for slipping
    end
    if slip == 0
        a(i) = -5/7*g*sin(theta);               % Calculate acceleration when not slipping
    else
        a(i) = -g*(sin(theta)-F_f(i)/(m*g));    % Calculate acceleration when slipping
    end
    v(i+1) = v(i) + a(i)*increment;                                         % Calculate velocity
    w(i+1) = w(i) + alpha(i)*increment;                                     % Calculate angular velocity
    x(i+1) = x(i) + cos(theta)*(v(i)*increment + 1/2*a(i)*increment^2); % Calculate x position
    y(i+1) = y(i) + sin(theta)*(v(i)*increment + 1/2*a(i)*increment^2); % Calculate y position
    %{
    Aidan's request for when it goes to 0
    if sign(v(i+1)) ~= sign(v(i))
        if y(i+1) > y(i)
            t_max = t + increment;
            i_max = i + 1;
        else
            t_max = t;
            i_max = i;
        end
    end
    %}
    t = t + increment;                          % Increment Time
    i = i+1;
end

% Plot graphs
hold on;
plot(x(i_initial:i), y(i_initial:i));
xlim([0,0.585]);
ylim([0,0.585]);

% Return values
T = [0:increment:t];
t
v_x = [v_xi v*cos(theta)];
v_y = [v_yi v*sin(theta)];
X = x;
Y = y;
W = w;
Alpha = [alpha alpha];
result1 = [X(i_initial:i)' Y(i_initial:i)' T'];
end
