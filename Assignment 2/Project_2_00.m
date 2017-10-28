clear all; clc; clf; %Unit m,A
%Define Input
a1 = 0.06; %Birth Month
a2 = 0.27; %Birth Date
b = (a1+a2)/2;
N = 1997-1900; %Birth Year
I = 0.519; %Current
DL = 0.1e-2;
x = 0:DL/2:b;
DI = N/b * I;
%%
%Input for a specific point
disp('Input value for Point P');
fprintf('The input X value should between %.1d and %.1d\n',...
    (-2)*b,3*b);
fprintf('The input Y value should between %.1d and %.1d\n',...
    -a2,2*a2);
fprintf('The input Z value should between %.1d and %.1d\n',...
    -a1,2*a1);
X = input('The X-axis Value of P, in m, = ');
Y = input('The Y-axis Value of P, in m, = ');
Z = input('The Z-axis Value of P, in m, = ');
if(X<(-2)*b || X>3*b || ...
        Y<(-a2) || Y>3*a2 || ...
        Z<(-a1) || Z>(2*a1))
    disp('Invalid Input.');
    return
end
fprintf('\nThe entered values are: \n%.3d x + %.3d y + %.3d z \n\n', ...
    X,Y,Z);
%%
%Calculate the H from a single loop
H=[0,0,0]; H1=[0,0,0]; H2=[0,0,0]; H3=[0,0,0]; H4=[0,0,0]; HT=[];
H_x=[0,0,0]; H_y=[0,0,0]; H_z=[0,0,0]; syms d;
for lp1 = 2:2:(length(x)-1)
    x0 = x(1,lp1);
    %First Segment
    A1 = [-Z,0,X-x0];
    F1_x=@(d) (A1(1))./((X-x0).^2+(Y-d).^2+Z.^2);
    H_x = (DI/(4*pi))*integral(F1_x,0,a2);
    H1(1) = H1(1)+H_x;
    F1_z=@(d) (A1(3))./((X-x0).^2+(Y-d).^2+Z.^2);
    H_z = (DI/(4*pi))*integral(F1_z,0,a2);
    H1(3) = (H1(3))+H_z;
    %Second Segment
    A2 = [0,X-x0,Y-a2];
    F2_y=@(d) (A2(2))./((X-x0).^2+(Y-a2).^2+(Z-d).^2);
    F2_z=@(d) (A2(3))./((X-x0).^2+(Y-a2).^2+(Z-d).^2);
    H_y = (DI/(4*pi))*integral(F2_y,0,a1);
    H_z = (DI/(4*pi))*integral(F2_z,0,a1);
    H2 = [0,(H2(2))+H_y,(H2(3))+H_z];
    %Third Segment
    A3 = [Z-a1,0,-(X-x0)];
    F3_x=@(d) (A3(1))./((X-x0).^2+(Y-d).^2+(Z-a1).^2);
    F3_z=@(d) (A3(3))./((X-x0).^2+(Y-d).^2+(Z-a1).^2);
    H_x = (DI/(4*pi))*integral(F3_x,a2,0);
    H_z = (DI/(4*pi))*integral(F3_z,a2,0);
    H3 = [(H3(1))+H_x,0,(H3(3))+H_z];
    %Fourth Segment
    A4 = [-Y,X-x0,0];
    F4_x=@(d) (A4(1))./((X-x0).^2+Y.^2+(Z-d).^2);
    F4_y=@(d) (A4(2))./((X-x0).^2+Y.^2+(Z-d).^2);
    H_x = (DI/(4*pi))*integral(F4_x,a1,0);
    H_y = (DI/(4*pi))*integral(F4_y,a1,0);
    H4 = [(H4(1))+H_x,(H4(2))+H_y,0];
    %Sum
    HT = H1 + H2 + H3 + H4;
end

