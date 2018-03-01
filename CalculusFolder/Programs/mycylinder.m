function [xx,yy,zz] = mycylinder(varargin)

narginchk(0,3);                                                                                                                          
[cax,args,nargs] = axescheck(varargin{:});                                                                                               
                                                                                                                                         
n = 20;                                                                                                                                  
r = [1 1]';                                                                                                                              
if nargs > 0, r = args{1}{1}; end                                                                                                           
if nargs > 1, n = args{2}; end                                                                                                           
r = r(:); % Make sure r is a vector.                                                                                                     
m = length(r); if m==1, r = [r;r]; m = 2; end                                                                                            
theta = (0:n)/n*2*pi;                                                                                                                    
sintheta = sin(theta); sintheta(n+1) = 0;                                                                                                
                                                                                                                                         
x = r * cos(theta);                                                                                                                      
y = r * sintheta;                                                                                                                        
z = args{1}{2} * (0:m-1)'/(m-1) * ones(1,n+1);                                                                                                        
                                                                                                                                         
if nargout == 0                                                                                                                          
    cax = newplot(cax);                                                                                                                  
    surf(x,y,z,'parent',cax)                                                                                                             
else                                                                                                                                     
    xx = x; yy = y; zz = z;                                                                                                              
end