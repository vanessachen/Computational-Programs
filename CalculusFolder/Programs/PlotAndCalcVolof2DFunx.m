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
dx = 0.1;                   % x-resolution
x = 0:dx:10;
[xs, ys] = meshgrid(x,y);   
y = abs(-x.^2);
Y = (-x.^2);
plot(x,Y);               
V = dx*sum(y(:));        % take the volume
V