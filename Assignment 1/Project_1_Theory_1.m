clear all; clc; clf;%Universial Unit: cm C
%Define
month = 6;
date = 27;
year = 1997;
%Create the matrix and corresponding value
[X1,Y1] = meshgrid(0:0.1:month,0:0.1:date);
E1mag = [];
E2mag = [];
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
%%
%Input Value for P
disp('Input value for Point P');
fprintf('The input X value should between %.1d and %.1d\n',...
    0.2*month,0.7*month);
fprintf('The input Y value should between %.1d and %.1d\n',...
    0.2*date,0.7*date);
fprintf('The input Z value should between %.1d and %.1d\n',...
    0.2*Z1,0.7*Z1);
X = input('The X-axis Value of P, in cm, = ');
Y = input('The Y-axis Value of P, in cm, = ');
Z = input('The Z-axis Value of P, in cm, = ');
if(X<0.2*month || X>0.7*month || ...
        Y<0.2*date || Y>0.7*date || ...
        Z<0.2*Z1 || Z>0.7*Z1)
    disp('Invalid Input.');
    return
end
fprintf('\nThe entered values are: \n%.3d x + %.3d y + %.3d z \n\n', ...
    X,Y,Z);
%%
%Calculate a specific point
%Calculation for E from the first plate
eps = 1e-11/(36*pi); %F/cm
S1 = month*date; %cm^2
E1 = [0,0,0];
for a = 1:1:Xend
    for b = 1:1:Yend
        E1(1) = E1(1) + ((p1*S1)/(4*pi*eps))*(X-X1(1,a)) ...
            ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
        E1(2) = E1(2) + (p1*S1)/(4*pi*eps)*(Y-Y1(b,1)) ...
            ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
        E1(3) = E1(3) + (p1*S1)/(4*pi*eps)*Z ...
            ./(((X-X1(1,a))^2+(Y-Y1(b,1))^2+Z^2));
    end
end
%Calculate the E from the second plate
E2 = [0,0,0];
S2 = month*date*sqrt(1+(tan(theta))^2); %cm^2
for c = 1:1:Xend
    for d = 1:1:Yend
        E2(1) = E2(1) + (p2*S2)/(4*pi*eps)*(X-X1(1,c))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
        E2(2) = E2(2) + (p2*S2)/(4*pi*eps)*(Y-Y1(d))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
        E2(3) = E2(3) + (p2*S2)/(4*pi*eps)*(Z-Z2(d,1))...
            ./(((X-X1(1,c))^2+(Y-Y1(d,1))^2+(Z-Z2(d,1))^2));
    end
end
%%
%Calculate the total E
Etotal = E1 + E2;
disp('The total Electric Field Tensity is: ');
fprintf('%.3e x + %.3e y + %.3e z (V/cm) \n',...
    Etotal(1),Etotal(2),Etotal(3));
%%
%Calculate general graph
%for a0 = (0.2*month):0.1:(0.7*month)
%    for b0 = (0.2*date):0.1:(0.7*date)
%        for c0 = (0.2*Z1):0.1:(0.7*Z1)
%            %Shuffle exam point
%            XG = a0; YG = b0; ZG = c0;
%            %Calculation for E from the first plate
%            E1tmp = [0,0,0];
%            for a1 = 1:1:Xend
%                for b1 = 1:1:Yend
%                    E1tmp(1) = ((p1*S1)/(4*pi*eps))*(XG-X1(1,a1)) ...
%                        ./(((XG-X1(1,a1))^2+(YG-Y1(b1,1))^2+ZG^2));
%                    E1tmp(2) = (p1*S1)/(4*pi*eps)*(YG-Y1(b1,1)) ...
%                        ./(((XG-X1(1,a1))^2+(YG-Y1(b1,1))^2+ZG^2));
%                    E1tmp(3) = (p1*S1)/(4*pi*eps)*ZG ...
%                        ./(((XG-X1(1,a1))^2+(YG-Y1(b1,1))^2+ZG^2));
%                    E1mag(a1,b1) = norm(E1tmp);
%                end
%            end
%            %Calculate the E from the second plate
%            E2tmp = [0,0,0];
%            for c1 = 1:1:Xend
%                for d1 = 1:1:Yend
%                    E2tmp(1) = (p2*S2)/(4*pi*eps)*(XG-X1(1,c1))...
%                        ./(((XG-X1(1,c1))^2+(YG-Y1(d1,1))^2+(ZG-Z2(d1,1))^2));
%                    E2tmp(2) = (p2*S2)/(4*pi*eps)*(YG-Y1(d1,1))...
%                        ./(((XG-X1(1,c1))^2+(YG-Y1(d1,1))^2+(ZG-Z2(d1,1))^2));
%                    E2tmp(3) = (p2*S2)/(4*pi*eps)*(ZG-Z2(d1,1))...
%                        ./(((XG-X1(1,c1))^2+(YG-Y1(d1,1))^2+(ZG-Z2(d1,1))^2));
%                    E2mag(c1,d1) = norm(E2tmp);
%                end
%            end
%        end
%    end
%end
%Etotalmag = E1mag + E2mag;
%%
%Plot the first 2D Graph
YG1 = Y/2; ZG1 = Z1/2; E1G = [0,0,0]; E2G = [0,0,0]; EtotalmagG1 = zeros();
for f2 = 1:1:Xend
    XG1 = X1(1,f2);
    %Calculate Specific Graph 1
    for a2 = 1:1:Xend
        for b2 = 1:1:Yend
            E1G(1) = E1G(1) + ((p1*S1)/(4*pi*eps))*(XG1-X1(1,a2)) ...
                ./(((XG1-X1(1,a2))^2+(YG1-Y1(b2,1))^2+ZG1^2));
            E1G(2) = E1G(2) + (p1*S1)/(4*pi*eps)*(YG1-Y1(b2,1)) ...
                ./(((XG1-X1(1,a2))^2+(YG1-Y1(b2,1))^2+ZG1^2));
            E1G(3) = E1G(3) + (p1*S1)/(4*pi*eps)*ZG1 ...
                ./(((XG1-X1(1,a2))^2+(YG1-Y1(b2,1))^2+ZG1^2));
        end
    end
    E1Gmag = norm(E1G);
    %Calculate the E from the second plate
    for c2 = 1:1:Xend
        for d2 = 1:1:Yend
            E2G(1) = E2G(1) + (p2*S2)/(4*pi*eps)*(XG1-X1(1,c2))...
                ./(((XG1-X1(1,c2))^2+(YG1-Y1(d2,1))^2+(ZG1-Z2(d2,1))^2));
            E2G(2) = E2G(2) + (p2*S2)/(4*pi*eps)*(YG1-Y1(d2,1))...
                ./(((XG1-X1(1,c2))^2+(YG1-Y1(d2,1))^2+(ZG1-Z2(d2,1))^2));
            E2G(3) = E2G(3) + (p2*S2)/(4*pi*eps)*(ZG1-Z2(d2,1))...
                ./(((XG1-X1(1,c2))^2+(YG1-Y1(d2,1))^2+(ZG1-Z2(d2,1))^2));
        end
    end
    E2Gmag = norm(E2G);
    EtotalmagG1 = [EtotalmagG1 E1Gmag + E2Gmag];
end
figure(2);
subplot(1,2,1);
plot(EtotalmagG1);
%%
%Plot the second 2D Graph
XG2 = X1/2; ZG2 = Z1/2; E1G2 = [0,0,0]; E2G2 = [0,0,0]; EtotalmagG2 = zeros();
for f3 = 1:1:Yend
    YG2 = Y1(f3,1);
    %Calculate Specific Graph 1
    for a3 = 1:1:Xend
        for b3 = 1:1:Yend
            E1G2(1) = E1G2(1) + ((p1*S1)/(4*pi*eps))*(XG2-X1(1,a3)) ...
               /((XG2-X1(1,a3))^2+(YG2-Y1(b3,1))^2+ZG2^2);
            E1G2(2) = E1G2(2) + (p1*S1)/(4*pi*eps)*(YG2-Y1(b3,1)) ...
                /(((XG2-X1(1,a3))^2+(YG2-Y1(b3,1))^2+ZG2^2));
            E1G2(3) = E1G2(3) + (p1*S1)/(4*pi*eps)*ZG2 ...
                /(((XG2-X1(1,a3))^2+(YG2-Y1(b3,1))^2+ZG2^2));
        end
    end
    E1Gmag = norm(E1G2);
    %Calculate the E from the second plate
    for c2 = 1:1:Xend
        for d2 = 1:1:Yend
            E2G2(1) = E2G2(1) + (p2*S2)/(4*pi*eps)*(XG2-X1(1,c2))...
                ./(((XG2-X1(1,c2))^2+(YG2-Y1(d2,1))^2+(ZG2-Z2(d2,1))^2));
            E2G2(2) = E2G2(2) + (p2*S2)/(4*pi*eps)*(YG2-Y1(d2,1))...
                ./(((XG2-X1(1,c2))^2+(YG2-Y1(d2,1))^2+(ZG2-Z2(d2,1))^2));
            E2G2(3) = E2G2(3) + (p2*S2)/(4*pi*eps)*(ZG2-Z2(d2,1))...
                ./(((XG2-X1(1,c2))^2+(YG2-Y1(d2,1))^2+(ZG2-Z2(d2,1))^2));
        end
    end
    E2Gmag = norm(E2G2);
    EtotalmagG2 = [EtotalmagG2 E1Gmag + E2Gmag];
end
figure(2);
subplot(1,2,2);
plot(EtotalmagG2);