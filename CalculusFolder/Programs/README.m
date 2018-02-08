[X,Y] = meshgrid(-20:20,-20:20);
Z = X.^2+Y.^2;
%Z = 4*X.^3+4*Y.^3;
%Z = X.^6+Y.^6;
surf(X,Y,Z)