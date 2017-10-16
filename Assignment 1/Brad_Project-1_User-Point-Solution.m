clear; clf; clc;

birthdate = 26;
birthmonth = 5;
birthyear = 1997;

if birthdate > birthmonth
    X1 = birthmonth;
    Z1 = birthdate;
    Y1 = (X1 + Z1) / 2;
else
    X1 = birthdate;
    Z1 = birthmonth;
    Y1 = (X1 + Z1) / 2;
end

theta = (birthyear - 1985) * 2;
theta = degtorad(theta);

S1 = X1 * Z1;
S2 = X1 * (Z1 * sqrt(1 + tan(theta)^2));
rho_S1 = 0.1; % C/cm^2
rho_S2 = 0.4; % C/cm^2
epsilon = 8.854 * 10^(-12);

x = input(['Enter an x coordinate between ', num2str(0.2 * X1), ' and ', num2str(0.7 * X1), ' cm: ']);
while x < 0.2 * X1 || x > 0.7 * X1
    x = input('Not a valid coordinate. Try again: ');
end
y = input(['Enter a y coordinate between ', num2str(0.2 * Y1), ' and ', num2str(0.7 * Y1), ' cm: ']);
while y < 0.2 * Y1 || y > 0.7 * Y1
    y = input('Not a valid coordinate. Try again: ');
end
z = input(['Enter a z coordinate between ', num2str(0.2 * Z1), ' and ', num2str(0.7 * Z1), ' cm: ']);
while z < 0.2 * Z1 || z > 0.7 * Z1
    z = input('Not a valid coordinate. Try again: ');
end

fprintf(['The point selected is located at (', num2str(x), ' cm, ', num2str(y), ' cm, ', num2str(z), ' cm). \n']);

% plot surfaces
figure(1);

x_1 = linspace(0, X1, 6);
x_1 = repmat(x_1, 6, 1);
x_1 = x_1';
y_1 = zeros(6);
z_1 = linspace(0, Z1, 6);
z_1 = repmat(z_1, 6, 1);
surf(x_1, z_1, y_1);
xlabel('x (cm)');
ylabel('z (cm)');
zlabel('y (cm)');
hold on;

y_2 = linspace(Y1, Y1 + Z1 * tan(theta), 6);
y_2 = repmat(y_2, 6, 1);
surf(x_1, z_1, y_2);
    
% calculate surface normal
a = [X1, 0, 0];
b = [0, Z1 * tan(theta), Z1];
normal = cross(a, b);
mag = sqrt(sum(normal.^2));
normal = normal / mag * 20;
quiver3(X1/2, Z1/2, Y1 + (Z1 * tan(theta))/2, normal(1), normal(3), normal(2));

% DS lengths
delta = [0.1, 0.01, 0.001];

% evaluate with different DS lengths
for change = 1:2 % determines how many different DS values are calculated
    deltax = (0:(X1/delta(change)))*delta(change) + delta(change)/2; % midpoints
    deltaz = (0:(Z1/delta(change)))*delta(change) + delta(change)/2; % ^^^
    deltal = (0:((Z1 * sqrt(1 + tan(theta)^2))/delta(change)))*delta(change) + delta(change)/2;
    
    deltax = deltax(1:end-1); % remove out-of-bounds values
    deltaz = deltaz(1:end-1); % ^^^
    deltal = deltal(1:end-1); % ^^^
    
    S1_d = S1 / (length(deltax) * length(deltaz)); % calculate surface area, = DS^2
    S2_d = S2 / (length(deltax) * length(deltal)); % ^^^

    E_1_x = 0;
    E_1_y = 0;
    E_1_z = 0;
    for dz = deltaz
        for dx = deltax
            xxx = int32(x / (delta(change)/100)) - int32(dx / (delta(change)/100)); % necessary to avoid floating point errors, only way to correct it
            zzz = int32(z / (delta(change)/100)) - int32(dz / (delta(change)/100)); % ^^^ essentially equals "z - dz"
            
            E_1_x = E_1_x + double(sign(xxx)) * (rho_S1 * S1_d) / (4 * pi * epsilon * (double(xxx)/(10^(change+4)))^2);
            E_1_y = E_1_y + sign(y) * (rho_S1 * S1_d) / (4 * pi * epsilon * (y/100)^2);
            E_1_z = E_1_z + double(sign(zzz)) * (rho_S1 * S1_d) / (4 * pi * epsilon * (double(zzz)/(10^(change+4)))^2);
        end
    end
       
    E_2_x = 0;
    E_2_y = 0;
    E_2_z = 0;
    for dx = deltax
        for dl = deltal
            dz = dl * cos(theta);
            yy = Y1 + dl * sin(theta);
            
            xxx = int32(x / (delta(change)/100)) - int32(dx / (delta(change)/100));
            yyy = int32(y / (delta(change)/100)) - int32(yy / (delta(change)/100));
            zzz = int32(z / (delta(change)/100)) - int32(dz / (delta(change)/100));
            
            E_2_x = E_2_x + double(sign(xxx)) * (rho_S2 * S2_d) / (4 * pi * epsilon * (double(xxx)/(10^(change+2)))^2);
            E_2_y = E_2_y + double(sign(yyy)) * (rho_S2 * S2_d) / (4 * pi * epsilon * (double(yyy)/(10^(change+4)))^2);
            E_2_z = E_2_z + double(sign(zzz)) * (rho_S2 * S2_d) / (4 * pi * epsilon * (double(zzz)/(10^(change+4)))^2);
        end
    end
   
    E_x(change) = E_1_x + E_2_x;
    E_y(change) = E_1_y + E_2_y;
    E_z(change) = E_1_z + E_2_z;
end

% plot the E vector
R = sqrt(E_x.^2 + E_y.^2 + E_z.^2); % magnitude
u = E_x ./ R .* 5; v = E_y ./ R .* 5; w = E_z ./ R .* 5; % unit vectors
for plotty = 1:2
    quiver3(x, z, y, u(plotty), w(plotty), v(plotty));
end

% stop graphing on figure 1
hold off;

% print the values
for values = 1:2
   fprintf('E_x (%.3f x %.3f cm) = %.5f\n', delta(values), delta(values), E_x(values));
   fprintf('E_y (%.3f x %.3f cm) = %.5f\n', delta(values), delta(values), E_y(values));
   fprintf('E_z (%.3f x %.3f cm) = %.5f\n\n', delta(values), delta(values), E_z(values));
end
