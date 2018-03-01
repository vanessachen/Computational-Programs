%[X,Y] = meshgrid(-20:20,-20:20);
%Z = X.^2+Y.^2;
%Z = 4*X.^3+4*Y.^3;
%Z = X.^6+Y.^6;
%surf(X,Y,Z)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CREATE SURFACE PLOT OF 3D SHAPE
t = 0:pi/10:6*pi;

figure
%find inverse of funx
syms x;
f(x)=sin(x)+2
g = finverse(f);
g
%create surface plot
%[X,Y,Z] = cylinder(t.^.5);
%[X,Y,Z] = mycylinder({2*cos(t)+cos(2*t),10});
%[X,Y,Z] = mycylinder({(4.^(2/3)*t.^(1/3))/4,10});
[X,Y,Z] = mycylinder({cos(t)+2,6*pi});
%[X,Y,Z] = cylinder2P({sin(t),20,1,10});
%Z(2,:) = t.^.5;
%X = (2*cos(t)+cos(2*t));
%Y = (2*sin(t)-sin(2*t));
surf(X,Y,Z)
surf2stl('cosXPlus2From0to6Pi.stl',X,Y,Z);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCULATE VOLUME OF 3D SHAPE
r = @(h) (h.^.5); % Radius Function (¼ Circle)
cylarea = @(h) pi*h.*r(h).^2./h;                % Area Of Cylinder Segment
h = [0, 2];                                    % Height (Length) Of Cylinder
V = integral(cylarea, h(1), h(2)); % Volume Of Cylinder
%Vsph = [4*pi/3  V]                              % Compare Results
V
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%testing

%figure
%[x,y,z] = cylinder(10);
%z(2, :) = 5;
%surf(x,y,z, 'FaceColor', [1,0,0]);



                    
%[X,Y] = meshgrid(1:0.5:10,1:20);
%Z = g(t);
%Z = Y.^2
%surf(X,Y,Z)
%plot3(X.^2,Y.^2,3);

 %t = 0:pi/50:10*pi;
        %plot3(sin(t),cos(t),t);