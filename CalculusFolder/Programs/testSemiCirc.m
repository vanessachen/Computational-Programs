
%input function 1 and function 2

syms x;
%function1 = (1/((2*pi).^(.5))*exp(1)).^(-.5*x.^2);%normal distribution function
function1 = (1/sqrt(2*pi))*exp(-.5*x.^2);
function2 = 0*x;

%solve the system of equations to find where the functions intersect
%use this value to find the interval to define x 
eqns = [function1 == function2];
answer = solve(eqns, x);
answer

%take the value outputed from the command window to define x boundaries

x = [-4:0.01:4]';
%c1 = [x (1/((2*pi).^(.5))*exp(1)).^(-.5*x.^2)];
c1 = [x (1/sqrt(2*pi))*exp(-.5*x.^2)];
c2 = [x 0*x];
z = semiCircFrom2DBase2(c1,c2);
