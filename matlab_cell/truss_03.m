%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Ke,Fe,Pe] = truss_02(e_mat,e_spa,F_pre,e_typ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% geometrically nonlinear isoparametric truss element
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:  e_mat = [ X_1 Y_1 Z_1 X_2 Y_2 Z_2]  ... material coord
%         e_spa = [ x_1 y_1 z_1 x_2 y_2 z_2]  ... spatial  coord   
%         emod  = 2 * mue                     ... young's modulus
%         area                                ... cross section area 
%         ie                                  ... element number
%         e_typ = [ ie, type, emod, area ]    ... element type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output: Ke = [ 6 x 6 ]                      ... element stiffness matrix
%         Fe = [ Fx_1 fy_1 fz1 fx_2 fy_2 fz2] ... element load vector
%         Pe = [ Pe ]                         ... element stress
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tol= 1e-1;
Fe = zeros(6,1);                       % init element residual
Ke = zeros(6,6);                       % init element stiffness
unit = [ 1, 0, 0; 0, 1, 0; 0, 0, 1];

ie = e_typ(1);  type = e_typ(2);  emod = e_typ(3);  area = e_typ(4);

x_mat = [ e_mat(4)-e_mat(1); e_mat(5)-e_mat(2); e_mat(6)-e_mat(3)];      
x_spa = [ e_spa(4)-e_spa(1); e_spa(5)-e_spa(2); e_spa(6)-e_spa(3)];    

l_mat = norm(x_mat);
l_spa = norm(x_spa);

dNx_ref = [ -1;   +1  ];               % referential gradient of N1/N2
n_spa   = x_spa / l_spa;               % spatial unit normal

F_mat  = l_spa / l_mat ;               % deformation gradient
 
P    = emod/2 * ( F_mat - 1/F_mat );   % 1st pk stress = cauchy stress
dPdF = emod/2 * ( 1 + 1/F_mat/F_mat ); % linearization of 1st pk 

P0   = emod/2 * ( F_pre - 1/F_pre );   % add prestress
P    = P + P0;

fac1 = dPdF / l_mat - P / l_spa;
fac2 =                P / l_spa;

if((type==1)&&(P<tol)&&(l_mat~=l_spa))   % remove ropes in compression
  fac1 = 0;  fac2 = 0;  P = 0; 
% disp(['*** pressure on rope ',num2str(ie),' ***']);  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pe = P;
for i=1:2 indx=[3*i-2; 3*i-1; 3*i];
    Fe(indx)     =              P    * n_spa        * dNx_ref(i)*area;
for j=1:2 jndx=[3*j-2; 3*j-1; 3*j];
    Ke(indx,jndx)= dNx_ref(i) * fac1 * n_spa*n_spa' * dNx_ref(j)*area ...
                 + dNx_ref(i) * fac2 *      unit    * dNx_ref(j)*area;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


