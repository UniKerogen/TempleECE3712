Y = 6; Z = 4;
XG = zeros(1,(Xend+1)/2);
for X = 1:2:Xend
    %Calculate the E from the first plate
    E1 = [0,0,0];
   for a = 2:2:(Xend-1)
        for b = 2:2:(Yend-1)
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
    for c = 2:2:(Xend-1)
        for d = 2:2:(Yend-1)
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
    XG(2,1+(X-1)/2) = Y;
    XG(3,1+(X-1)/2) = Z;
end
disp('The total Electric Field Tensity for the first situation is: ');
fprintf('%.3e x + %.3e y + %.3e z (V/cm) \n',...
    Etotal(1),Etotal(2),Etotal(3));
clf;figure(1);view(3);
plot3(XG(1,:),XG(2,:),XG(3,:));