function [result]= Bouncing(angle, c)
%Bounce functions are similiar to projtile function with decreasing velocity after each bounce.
%Time: The total time the ball takes to bounce in seconds
global GlobalXYT;
g=9.81;
localtime = 0;
timejump = 0.001; %Time step size is 1 ms
t= 0.000;
stop = false;
angle = deg2rad(angle); %slope angle
Vx = ((GlobalXYT(end,1) - GlobalXYT(end-1,1))/(GlobalXYT(end,3) - GlobalXYT(end-1,3)))*c%velocity after impact in x direction
Vy = -((GlobalXYT(end,2) - GlobalXYT(end-1,2))/(GlobalXYT(end,3) - GlobalXYT(end-1,3)))*c% velocity after impact in y -direction
velocity = sqrt(Vx.^2 + Vy.^2) %calculating the initial velocity from the last element data
x0=GlobalXYT(end,1)
y0= GlobalXYT(end,2)
t0 = GlobalXYT(end,3)
x=x0;
y=y0;
result = [x0' y0' t0']
%Real contact will be acot(vx/vy) + 2*angle, not the one below.
bounce_angle= acot(Vx/Vy);%Contact angle change after each bounce.
landingtime = abs((2*velocity*sin(bounce_angle))/(g*cos(angle))); %Total time to complete 1 bounce

while (stop == false)
    if (localtime < landingtime) %This check whether or not a bounce is completed and move to a new bounce.
        localtime = localtime + timejump %Local time of each bounce. t is the temp time (only use inside this function).
        t= t + timejump
        x = Vx*localtime + x0
        y = Vy*localtime - 0.5*g*localtime^2 + y0
        result = [ x' y' (t0+t)']  %Output.
    else
        localtime=0;
        x0=x;
        y0=y;
        Vy = -(Vy - g*landingtime)*c;
        Vx = Vx*c;
        velocity=(sqrt((Vx.^2) + (Vy.^2))); %New bounce velocity
        bounce_angle = acot(Vx/Vy); %Contact angle change after each bounce.
        landingtime = abs((2*velocity*sin(bounce_angle-angle))/(g*cos(angle)));%Total time to complete 1 bounce
    end
    if ((bounce_angle - angle) <= 0)
        stop = true;
        break; %Exit the function if the contact angle become too close to slope angle.
    end
end
end