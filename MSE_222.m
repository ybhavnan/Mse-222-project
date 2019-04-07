clear global;
close all;
clc;
clearvars;

%constant list 
global mass;
mass = 0.004; %kg
global radius;
radius = 0.0075;%m
initialX = 0.01; %m
initialY = 0.59;%m
global muy; %coeficient of friction
muy = 0.2;
global e; %coefficient of restituition
e =0.3;


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


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % slope 2 degree length 251.27 mm
 [result1] = downward_slope(0.0036,0.25127,false);
 %the angle here cant take 0 cause the velocity is too small , however it is aproaching the result as long as angle ->0
 % the boolean is false as there is no impact at first. Same for other
 % downward_slope function 
 GlobalXYT = [GlobalXYT; result1];
 plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 hold on;
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %impact to the hanging rod 
 [result3] = rod_rotate(mass, 0.05, 0.0075, 0.07);% we assume the ball gonna stick with the rod and rolling before dropping down
 GlobalXYT = [GlobalXYT; result3];
 plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 hold on;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %freefall 44.89mm - this different from projectile - neglect velocity in y
 %direction
 [result4] = freefall(0.04489);
 GlobalXYT = [GlobalXYT; result4];
 plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
 hold on;
 


 %assume energy loss after impact to the next ramp:
 %Energy_loss();
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

%ramp 176 degree length 390.95mm
calculatedLength1 = sqrt((GlobalXYT(end,1)-0.22).^2 + (GlobalXYT(end,2)-0.50469).^2);
[result5] = downward_slope(176,calculatedLength1,false);
GlobalXYT = [GlobalXYT; result5];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%projectile after the ramp - THis is Aidan'free fall but I like to call
%projectile :>
[result6] = projectile(0.01,0.47436,0.44711, 0.4); %(0,0.55 - 0.345,0.52)
GlobalXYT = [GlobalXYT; result6];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 3RD RAMP - For the following ramp,after the projectile, the ball will be boucing up on the
%ramp then move forward before rolling downward along the ramp

%impact to the ramp - bouncing up
[result7] = Bouncing_left(4,e);
GlobalXYT = [GlobalXYT; result7];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%upward slope- the ball moves forward
[result8] = upward_slope(4);
GlobalXYT = [GlobalXYT; result8];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope -the ball then goes down along the slope
calculatedLength2 = sqrt((GlobalXYT(end,1)-0.4).^2 + (GlobalXYT(end,2)-0.44711).^2);
[result9] = downward_slope(4,calculatedLength2,false);
GlobalXYT = [GlobalXYT; result9];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the slope
[result10] = projectile(0.22,0.38952,0.61,0.41679);
GlobalXYT = [GlobalXYT; result10];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 4th RAMP - The same procedure apply -> we just calling the same
%function with different parameter


%impact to the ramp
[result11] = Bouncing(4,e);
GlobalXYT = [GlobalXYT; result11];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope
[result12] = upward_slope(176);
GlobalXYT = [GlobalXYT; result12];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;
% 
%downward slope lenght 
calculatedLength3 = sqrt((GlobalXYT(end,1)-0.22).^2 + (GlobalXYT(end,2)-0.38952).^2);
[result13] = downward_slope(176,calculatedLength3,false);
GlobalXYT = [GlobalXYT; result13];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile to the 5th ramp
[result14] = projectile(0.01,0.3602,0.4,0.33193);
GlobalXYT = [GlobalXYT; result14];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 5th RAMP - The same procedure apply -> we just calling the same
%function with different parameter

%impact to the ramp
[result11] = Bouncing_left(4,e);
GlobalXYT = [GlobalXYT; result11];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope 5th
[result15] = upward_slope(4);
GlobalXYT = [GlobalXYT; result15];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope 5th 
calculatedLength4 = sqrt((GlobalXYT(end,1)-0.4).^2 + (GlobalXYT(end,2)-0.33193).^2);
[result16] = downward_slope(4,calculatedLength4,false);
GlobalXYT = [GlobalXYT; result16];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the slope
[result17] = projectile(0.22,0.27435,0.61,0.30162);
GlobalXYT = [GlobalXYT; result17];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 6th RAMP - The same procedure apply -> we just calling the same
%function with different parameter

%impact to the ramp
[result18] = Bouncing(4,e);
GlobalXYT = [GlobalXYT; result18];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;
 
%upward slope 6th
[result19] = upward_slope(176);
GlobalXYT = [GlobalXYT; result19];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%impacting the wall - we assume the ball goes up then hit the wall then
%fall down the slope - the boolean is true
calculatedLength5 = sqrt((GlobalXYT(end,1)-0.22).^2 + (GlobalXYT(end,2)-0.27435).^2);
[result20] = downward_slope(176,calculatedLength5,true);
GlobalXYT = [GlobalXYT; result20];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%projectile after this slope
[result21] = projectile(0.01,0.24403,0.4,0.21676);
GlobalXYT = [GlobalXYT; result21];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 7th RAMP - The same procedure apply -> we just calling the same
%function with different parameter

%impact against the ramp
[result22] = Bouncing_left(4,e);
GlobalXYT = [GlobalXYT; result22];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope 7th
[result23] = upward_slope(4);
GlobalXYT = [GlobalXYT; result23];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope 7th 
calculatedLength6 = sqrt((GlobalXYT(end,1)-0.4).^2 + (GlobalXYT(end,2)-0.21676).^2);
[result24] = downward_slope(4,calculatedLength6,false);
GlobalXYT = [GlobalXYT; result24];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the slope
[result25] = projectile(0.29775,0.08797,0.61,0.16662);
GlobalXYT = [GlobalXYT; result25];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 8th RAMP - The same procedure apply -> we just calling the same
%function with different parameter


%impact to the ramp
[result26] = Bouncing(4,e);
GlobalXYT = [GlobalXYT; result26];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;
 
%upward slope 8th
[result27] = upward_slope(176);
GlobalXYT = [GlobalXYT; result27];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope 8th
calculatedLength7 = sqrt((GlobalXYT(end,1)-0.29775).^2 + (GlobalXYT(end,2)-0.08797).^2);
[result28] = downward_slope(165.86,calculatedLength7,false);
GlobalXYT = [GlobalXYT; result28];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%projectile after the 8th ramp:
[result29] = projectile(0.01,0.08816,0.61,0.01478);
GlobalXYT = [GlobalXYT; result29];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%THE 9th RAMP - The same procedure apply -> we just calling the same
%function with different parameter

%impact against the ramp
[result30] = Bouncing_left(6.97,0.25);
GlobalXYT = [GlobalXYT; result30];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%upward slope 9th
[result31] = upward_slope(6.97);
GlobalXYT = [GlobalXYT; result31];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope 9th 
calculatedLength8 = sqrt((GlobalXYT(end,1)-0.61).^2 + (GlobalXYT(end,2)-0.01478).^2);
[result32] = downward_slope(6.97,calculatedLength8,false);
GlobalXYT = [GlobalXYT; result32];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%the ball goes a little bit up after the impact
[result33] = upward_slope_impact(6.97,e);
GlobalXYT = [GlobalXYT; result33];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;

%downward slope 9th 
calculatedLength9 = sqrt((GlobalXYT(end,1)-0.61).^2 + (GlobalXYT(end,2)-0.01478).^2);
[result34] = downward_slope(6.97,calculatedLength9,false);
GlobalXYT = [GlobalXYT; result34];
plot (GlobalXYT(end,1), GlobalXYT(end,2), 'O', 'MarkerSize' , 8 ,'MarkerFaceColor' , 'r');
hold on;




% % 
% % 
% % 
% 


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
xlim([0,20]);
ylim([0,20]);

%y with respect to time
subplot(1,2,2)

plot(t,y)
title('y wrt t')
xlim([0,20]);
ylim([0,20]);







