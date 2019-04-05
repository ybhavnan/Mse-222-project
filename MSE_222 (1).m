clear global;
close all;
clc;
clearvars;

%constant list 
global mass;
mass = 0.004; %kg
global diameter;
diameter = 0.015;%m
initialX = 0; %m
initialY = 0.6;%m
global muy;
muy = 0.2;
%constant list end

% set up the coordinate
global GlobalXYT;
GlobalXYT = [initialX, initialY, 0];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 12 ,'MarkerFaceColor' , 'r');
hold on;

% curved path radius 42.5mm
[x,y,t] = curve(0.0425,90,0);
GlobalXYT = [GlobalXYT; [x,y,t]];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;



 % slope 2 degree length 251.27 mm
 %[result1] = downward_slope(2,0.25127);
 %GlobalXYT = [GlobalXYT; result1];
 %plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 %hold on;
 
 %horizontal slope length 0.2 m
 [result2] = straight(0.31,0.55599);
 GlobalXYT = [GlobalXYT; result2];
 plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 hold on;

 %impact to the hanging rod (this one is wrong in some way)
 [result3] = rod_rotate(mass, 0.05, 0.0075, 0.07);
 GlobalXYT = [GlobalXYT; result3];
 plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 hold on;
 
 %freefall 44.89mm
[result4] = freefall(0.04489);
GlobalXYT = [GlobalXYT; result4];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%ramp 176 degree length 390.95mm
[result5] = downward_slope(176,0.110);
GlobalXYT = [GlobalXYT; result5];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the ramp
[result6] = projectile(0.01,0.47436,0.44711, 0.4); %(0,0.55 - 0.345,0.52)
GlobalXYT = [GlobalXYT; result6];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%impact to the ramp
[result7] = Bouncing(4,0.2);
GlobalXYT = [GlobalXYT; result7];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope
[result9] = upward_slope(4);
GlobalXYT = [GlobalXYT; result9];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope lenght 0.3m
[result8] = downward_slope(4,0.4);
GlobalXYT = [GlobalXYT; result8];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the slope
[result10] = projectile(0.22,0.38952,0.61,0.41679);
GlobalXYT = [GlobalXYT; result10];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%impact to the ramp
[result11] = Bouncing(94,0.2);
GlobalXYT = [GlobalXYT; result11];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope
[result12] = upward_slope(-4);
GlobalXYT = [GlobalXYT; result12];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope lenght 0.3m
[result13] = downward_slope(176,0.18);
GlobalXYT = [GlobalXYT; result13];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;






 


elapsedTime = GlobalXYT(end,3) %total time
%Plotting Y-X
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x ,y,'LineWidth' , 1 , 'color' ,'b');
title('Y-X');
xlim([0,1]);
ylim([0,1]);

%plotting extra X-t and Y-t
figure;

%x with respect to time
subplot(1,2,1)
t = GlobalXYT(:, 3);
plot(t ,x)
title('x wrt t');
xlim([0,3]);
ylim([0,3]);

%y with respect to time
subplot(1,2,2)

plot(t,y)
title('y wrt t')
xlim([0,3]);
ylim([0,3]);





