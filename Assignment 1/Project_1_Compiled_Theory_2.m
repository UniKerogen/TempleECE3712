%Start of the Code
clear all; clc; clf;%Universial Unit: cm C
%Define
bmonth = 6;
bdate = 27;
year = 1997;
DS = 0.1; %cm
%Comparison
if bdate < bmonth
    Xm = bdate;
    Yd = bmonth;
else
    Yd = bdate;
    Xm = bmonth;
end
%Create the matrix and corresponding value
[X1,Y1] = meshgrid(0:(DS/2):Xm,0:(DS/2):Yd);
E1mag = [];E2mag = [];
[Yend, Xend] = size(X1);
Z1 = (Xm+Yd)/2;
theta = degtorad((year-1985)*2);
%First Metal Plate
Z21 = 0*(X1+Y1);
p1 = 0.1; % C/cm2
%Second Metal Plate
Z2 = Z1 + Y1*tan(theta);
p2 = 0.4; % C/cm2
%Plot two plate in Coordinate System
figure(1);view(3);
Plate1 = surface(X1,Y1,Z21);
hold on;
Plate2 = surface(X1,Y1,Z2);
set(Plate1, 'edgecolor','green');
set(Plate2, 'edgecolor','blue');
title('The Position of Two Plates');
xlabel('X Axis');ylabel('Y Axis');zlabel('Z Axis');
%Informations
eps = 1e-11/(36*pi);S = (DS)^2;
%%
%First Situation
Y = Yd/2; Z = Z1/2;
EG = zeros(1,(Xend+1)/2);
for X = 1:2:Xend
    %Calculate the E from the first plate
    E1 = [0,0,0];
   for a = 2:2:(Xend-1)
        for b = 2:2:(Yend-1)
            E1(1) = E1(1) + ((p1*S)/(4*pi*eps))*(X-X1(1,a)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
            E1(2) = E1(2) + (p1*S)/(4*pi*eps)*(Y-Y1(b,1)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
            E1(3) = E1(3) + (p1*S)/(4*pi*eps)*Z ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
        end
    end
    %Calculate the E from the second plate
    E2 = [0,0,0];
    for c = 2:2:(Xend-1)
        for d = 2:2:(Yend-1)
            E2(1) = E2(1) + (p2*S)/(4*pi*eps)*(X-X1(1,c))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
            E2(2) = E2(2) + (p2*S)/(4*pi*eps)*(Y-Y1(d))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
            E2(3) = E2(3) + (p2*S)/(4*pi*eps)*(Z-Z2(d,1))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
        end
    end
    Etotal = E1 + E2;
    EG(1,1+(X-1)/2) = Etotal(1);
    EG(2,1+(X-1)/2) = Etotal(2);
    EG(3,1+(X-1)/2) = Etotal(3);
end
figure(2);view(3);
x = 0:DS:Xm;
y = Y*ones(1,(Xend+1)/2);
y = Y*ones(size(x));
z = Z*ones(size(x));
u = EG(1,:);
v = EG(2,:);
w = EG(3,:);
quiver3(x,y,z,u,v,w);
title('Electrical Field Vector on a Fixed Y and Z Varying X');
xlabel('X Axis');ylabel('Y Axis');zlabel('Z Axis');
%%
%Second situation
X = Xm/2; Z = Z1/2;
EG = zeros(1,(Yend+1)/2);
for Y = 1:2:Yend
    %Calculate the E from the first plate
    E1 = [0,0,0];
   for a = 2:2:(Xend-1)
        for b = 2:2:(Yend-1)
            E1(1) = E1(1) + ((p1*S)/(4*pi*eps))*(X-X1(1,a)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
            E1(2) = E1(2) + (p1*S)/(4*pi*eps)*(Y-Y1(b,1)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
            E1(3) = E1(3) + (p1*S)/(4*pi*eps)*Z ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
        end
    end
    %Calculate the E from the second plate
    E2 = [0,0,0];
    for c = 2:2:(Xend-1)
        for d = 2:2:(Yend-1)
            E2(1) = E2(1) + (p2*S)/(4*pi*eps)*(X-X1(1,c))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
            E2(2) = E2(2) + (p2*S)/(4*pi*eps)*(Y-Y1(d))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
            E2(3) = E2(3) + (p2*S)/(4*pi*eps)*(Z-Z2(d,1))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
        end
    end
    Etotal = E1 + E2;
    EG(1,1+(Y-1)/2) = Etotal(1);
    EG(2,1+(Y-1)/2) = Etotal(2);
    EG(3,1+(Y-1)/2) = Etotal(3);
end
figure(3);view(3);
x = 0:DS:Yd;
y = X*ones(1,(Yend+1)/2);
y = X*ones(size(x));
z = Z*ones(size(x));
u = EG(1,:);
v = EG(2,:);
w = EG(3,:);
quiver3(x,y,z,u,v,w);
title('Electrical Field Vector on a Fixed X and Z Varying Y');
xlabel('X Axis');ylabel('Y Axis');zlabel('Z Axis');
%%
%Input for a specific point
disp('Input value for Point P');
fprintf('The input X value should between %.1d and %.1d\n',...
    0.2*Xm,0.7*Xm);
fprintf('The input Y value should between %.1d and %.1d\n',...
    0.2*Yd,0.7*Yd);
fprintf('The input Z value should between %.1d and %.1d\n',...
    0.2*Z1,0.7*Z1);
X = input('The X-axis Value of P, in cm, = ');
Y = input('The Y-axis Value of P, in cm, = ');
Z = input('The Z-axis Value of P, in cm, = ');
if(X<0.2*Xm || X>0.7*Xm || ...
        Y<0.2*Yd || Y>0.7*Yd || ...
        Z<0.2*Z1 || Z>0.7*Z1)
    disp('Invalid Input.');
    return
end
fprintf('\nThe entered values are: \n%.3d x + %.3d y + %.3d z \n\n', ...
    X,Y,Z);
%%
%Calculation for the specific point
E1 = [0,0,0];
ET = [0,0,0];
for a = 2:2:(Xend-1)
    for b = 2:2:(Yend-1)
        ET(1)= ((p1*S)/(4*pi*eps))*(X-X1(1,a)) ...
            /(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
        ET(2) = ((p1*S)/(4*pi*eps))*(Y-Y1(b,1)) ...
            /(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
        ET(3) = ((p1*S)/(4*pi*eps))*Z...
            /(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2)^(3/2));
        E1(1)=E1(1)+ET(1);E1(2)=E1(2)+ET(2);E1(3)=E1(3)+ET(3);
    end
end
E2 = [0,0,0];
for c = 2:2:(Xend-1)
    for d = 2:2:(Yend-1)
        E2(1) = E2(1) + (p2*S)/(4*pi*eps)*(X-X1(1,c))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
        E2(2) = E2(2) + (p2*S)/(4*pi*eps)*(Y-Y1(d))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
        E2(3) = E2(3) + (p2*S)/(4*pi*eps)*(Z-Z2(d,1))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2)^(3/2));
    end
end
Etotal = E1+E2;
disp('The total Electric Field Tensity is: ');
fprintf('%.3e x + %.3e y + %.3e z (V/cm) \n',...
    Etotal(1),Etotal(2),Etotal(3));
%End of the Code