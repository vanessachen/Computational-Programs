
figure
a=rand(1,20);%Vector of random data
     b=a+2*rand(1,20);%2nd vector of data points;
     x=1:20;%horizontal vector
     [fillhandle,msg]=jbfill(x,a,b,rand(1,3),rand(1,3),0,rand(1,1))
     %grid on
`    %legend('Datr')