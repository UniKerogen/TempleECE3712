clear all; clc; clf;%Universial Unit: cm C
%Define
month = 6;
date = 27;
year = 1997;
DS = 0.2; %cm
%Create the matrix and corresponding value
[X1,Y1] = meshgrid(0:(DS/2):month,0:(DS/2):date);
E1mag = [];E2mag = [];
[Yend, Xend] = size(X1);
Z1 = (month+date)/2;
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
%Calculate E Magnitude
eps = 1e-11/(36*pi);S = (DS)^2;
Y = 6; Z = 4;
XG = zeros(1,(Xend+1));
for X = 1:2:Xend
    %Calculate the E from the first plate
    E1 = [0,0,0];
   for a = 1:2:Xend
        for b = 1:2:Yend
            E1(1) = E1(1) + ((p1*S)/(4*pi*eps))*(X-X1(1,a)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
            E1(2) = E1(2) + (p1*S)/(4*pi*eps)*(Y-Y1(b,1)) ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
            E1(3) = E1(3) + (p1*S)/(4*pi*eps)*Z ...
                ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
        end
    end
    %Calculate the E from the second plate
    E2 = [0,0,0];
    S2 = month*date*sqrt(1+(tan(theta))^2); %cm^2
    for c = 1:2:Xend
        for d = 1:2:Yend
            E2(1) = E2(1) + (p2*S)/(4*pi*eps)*(X-X1(1,c))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
            E2(2) = E2(2) + (p2*S)/(4*pi*eps)*(Y-Y1(d))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
            E2(3) = E2(3) + (p2*S)/(4*pi*eps)*(Z-Z2(d,1))...
                ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
        end
    end
    Etotal = E1 + E2;
    XG(1,1+(X-1)/2) = norm(Etotal);
end
disp('The total Electric Field Tensity for the first situation is: ');
fprintf('%.3e x + %.3e y + %.3e z (V/cm) \n',...
    Etotal(1),Etotal(2),Etotal(3));
