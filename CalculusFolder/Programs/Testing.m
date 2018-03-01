%dx = 0.1;                   % x-resolution
%dy = 0.1;                   % y-resolution
x% = 0:dx:1;
%y = 0:dy:1;
%[xs, ys] = meshgrid(x,y);   % let there by 2D!
%z = abs(sin(pi*(xs-ys)));   % the surface (computed over the meshgrid)...
%surf(x,y,z);                % ...and what a nice surface it is!
%V = dx*dy*sum(z(:));        % take the volume
%V

figure
dx = 0.1;
dy = 0.1;    
x = 0:dx:1;
y = 0:dy:1;
[xs, ys] = meshgrid(x,y);   
z = abs((-(xs-ys).^2).^2*pi)+y;
surf(x,y,z);
%plot(x,y,z);               
V = dx*dy*sum(z(:));        % take the volume
V
%2piR

figure
[X,Y]=meshgrid(-3:0.1:3);
R = (X.^2 + Y.^2);
J=besselj(1,R); 
Z=(J./R);
Z(isnan(Z)) = 0.5; %Fix the divide by zero problem
surf(X,Y,R);
shading flat;
camlight;


figure
[X,Y]=meshgrid(-1:0.1:1);
x = -1:dx:1;
y = -1:dy:1;
r = @(h) sqrt(1 - h.^2); % Radius Function (¼ Circle)
R = sqrt(1 - h.^2);
cylarea = @(h) pi*h.*r(h).^2./h;                % Area Of Cylinder Segment
h = [-1, 1];                                    % Height (Length) Of Cylinder
V = integral(cylarea, h(1), h(2)); % Volume Of Cylinder
surf(x,y,R);
Vsph = [4*pi/3  V]                              % Compare Results
Vsph
