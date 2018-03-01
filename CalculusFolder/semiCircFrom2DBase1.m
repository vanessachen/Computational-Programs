function z = semiCircFrom2DBase1(c1,c2)
%c1 is bottom funx, c2 is top funx

x = c1(:,1);%first column of c1
y = [c1(:,2);c2(:,2)];%concatenates the second columns of c1 and c2
Nx = numel(x);%number of elements in x
Ny = numel(y);%number of elements in y
z = nan(Ny,Nx); %initializes a matrix z as not a number (wont graph anything)
%sets it as size Ny rows, Nx cols
for i = 1:Nx, %for every col
    dy = c2(i,2)-c1(i,2); %find dy (distance from top curve to bottom curve
    radius = dy/2;
    center = c1(i,2)+radius; %start from the c1 (bottom) y-value and add radius
    for j = 1:Ny,%for every row
        if (y(j)-center)^2<=radius^2, %if that y value is inside the bounds of the curve
            z(j,i) = sqrt(radius^2-(y(j)-center)^2); %set z (for every interval) as the result of function of a circle
        else end
    end
end

figure(1);
clf;
surf(x,y,z);
shading interp;
colormap hsv;
grid on;

    %use syms to solve the two functions (find the intersection point)
    %get that num value, but it would be a string 
    %convert str to num 
    

