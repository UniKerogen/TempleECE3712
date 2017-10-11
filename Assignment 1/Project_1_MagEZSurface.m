clear;clc;clf;
month = 6;
date = 27;
year = 1997;
DS = 0.1; %cm
eps = 1e-11/(36*pi);S = (DS)^2;
[X1,Y1] = meshgrid(0:(DS/2):month,0:(DS/2):date);
[Yend, Xend] = size(X1);
Z1 = (month+date)/2;
theta = degtorad((year-1985)*2);
%First Metal Plate
Z21 = 0*(X1+Y1);
p1 = 0.1; % C/cm2
%Second Metal Plate
Z2 = Z1 + Y1*tan(theta);
p2 = 0.4; % C/cm2
%Calculation
Z = 4;
Mag = zeros(3,(Yend+1)/2);
for asurf = 1:2:Yend
    Y = Y1(asurf,1);
   for bsurf = 1:2:Xend
       X = X1(1,bsurf);
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
        %YG(1,1+(a21-1)/2) = X;
        %YG(2,1+(a21-1)/2) = Y;
        %YG(3,1+(a21-1)/2) = norm(Etotal);
        Mag(1+(bsurf-1)/2,1+(asurf-1)/2)=norm(Etotal);
   end
end
figure(1);view(3);
colormap cool;
surf(Mag,'EdgeColor','none'); 