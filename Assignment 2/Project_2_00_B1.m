H=[0,0,0]; H1=[0,0,0]; H2=[0,0,0]; H3=[0,0,0]; HT=[];
for lp1 = 2:2:(length(X)-1)
    x0 = X(1,lp1);
    H1 = (DI/(4*pi))*integral((cross([0,-1,0],[X-x0,Y-a2/2,Z])./...
        ((X-x0)^2+(Y-a2/2)^2+Z^2)),a2,0);
    H2 = (DI/(4*pi))*integral((cross([0,0,-1],[X-x0,Y-a2,Z-a1/2])./...
        ((X-x0)^2+(Y-a2)^2+(Z-a1/2)^2)),a1,0);
    H3 = (DI/(4*pi))*integral((cross([0,1,0],[X-x0,Y-a2/2,Z-a1])./...
        ((X-x0)^2+(Y-a2/2)^2+(Z-a1)^2)),0,a2);
    H4 = (DI/(4*pi))*integral((cross([0,0,1],[X-x0,Y,Z-a1/2])./...
        ((X-x0)^2+Y^2+(Z-a1/2)^2)),0,a1);
    H = H1+H2+H3+H4
    HT = [HT H];
end
