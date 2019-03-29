clear global;
close all;
clc;
clearvars;

%constant list 
mass = 0.004; %kg
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

% curved path radius 0.05m
[x,y,t] = curve(0.05,90,0);
GlobalXYT = [GlobalXYT; [x,y,t]];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

% slope 0 degree length 0.1 m
[result1] = downward_slope(0,0.1);
GlobalXYT = [GlobalXYT; result1];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

% freefall 
[result2] = freefall();
GlobalXYT = [GlobalXYT; result2];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

elapsedTime = GlobalXYT(end,3); %total time
%Plotting Y-X
x = GlobalXYT(:, 1);
y = GlobalXYT(:, 2);
plot(x ,y,'LineWidth' , 1 , 'color' ,'b');
title('Y-X');
xlim([0,0.7]);
ylim([0,0.7]);

%plotting extra X-t and Y-t
elapsedTime = GlobalXYT(end,3)
figure;

%x with respect to time
subplot(1,2,1)
t = GlobalXYT(:, 3);
plot(x ,t)
title('x wrt t');
xlim([0,1]);
ylim([0,1]);

%y with respect to time
subplot(1,2,2)
plot(y,t)
title('y wrt t')
xlim([0,1]);
ylim([0,1]);





