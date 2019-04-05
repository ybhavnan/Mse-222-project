%Free fall function
function [result2] = freefall(h)
global GlobalXYT;
x0 = GlobalXYT(end,1);
y0 = GlobalXYT(end,2);

%For this part I assume the velocity to be V= (change of distance)/(change
%of time)
initialVelX=0;
initialVelY=(GlobalXYT(end,2)-GlobalXYT(end-2,2))/(GlobalXYT(end,3)-GlobalXYT(end-2,3));

g = 9.81; 
fall_time = sqrt(2*h/g);
t2 = 0:0.001:fall_time;
x = x0+ initialVelX*t2;
y = y0 +initialVelY* t2- 0.5 *g * t2.^2;
t2 = t2 + GlobalXYT(end,3);
result2 = [x' y' t2'];
end
