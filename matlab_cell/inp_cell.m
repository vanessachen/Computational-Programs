%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q0,edof,bc,F_ext,F_gra,F_pre,e_typ,nel,node,ndof] = inp_cell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% number of elements, nodes, dofs
nel  = 42;
node = 13;
ndof = 3*node;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% coordinates of cell membrane
rad = 1.0;

K=[1/16*(10+2*sqrt(5)), 0, 0, 0;
    0, 1/3, 1, 0;
   -1, 1/3, 4, 0;
    1/3, 0, 0, 1];

F=[rad, rad, 0, rad]';

dof = K\F;

a=sqrt(dof(1)); 
b=sqrt(dof(2)); 
g=sqrt(dof(3)); 
h=sqrt(dof(4));

fac1=sqrt(3)/3;
fac2=sqrt(3)/6;
	   
q0=[   0; +fac1*a; -h; 
    -a/2; -fac2*a; -h; 
    +a/2; -fac2*a; -h; 
	   0; -fac1*b; -g; 
    +b/2; +fac2*b; -g; 
    -b/2; +fac2*b; -g; 
       0; +fac1*b; +g; 
    -b/2; -fac2*b; +g; 
    +b/2; -fac2*b; +g;
	   0; -fac1*a; +h; 
	+a/2; +fac2*a; +h; 
    -a/2; +fac2*a; +h; 
	   0;       0;  0];	   	  	  

% element connectivity

% microtubules
el( 1,:) = [  1  9 ];
el( 2,:) = [  2  7 ];
el( 3,:) = [  3  8 ];
el( 4,:) = [  4 11 ];
el( 5,:) = [  5 12 ];
el( 6,:) = [  6 10 ];

%  nucleus filaments
el( 7,:) = [  1 13 ];
el( 8,:) = [  2 13 ];
el( 9,:) = [  3 13 ];
el(10,:) = [  4 13 ];
el(11,:) = [  5 13 ];
el(12,:) = [  6 13 ];
el(13,:) = [  7 13 ];
el(14,:) = [  8 13 ];
el(15,:) = [  9 13 ];
el(16,:) = [ 10 13 ];
el(17,:) = [ 11 13 ];
el(18,:) = [ 12 13 ];

% intremediate filaments 
el(19,:) = [  1  2 ];
el(20,:) = [  2  3 ];
el(21,:) = [  3  1 ];
el(22,:) = [ 10 11 ];
el(23,:) = [ 11 12 ];
el(24,:) = [ 12 10 ];

el(25,:) = [  1  5 ];
el(26,:) = [  2  6 ];
el(27,:) = [  3  4 ];
el(28,:) = [ 10  8 ];
el(29,:) = [ 11  9 ];
el(30,:) = [ 12  7 ];

el(31,:) = [  1  7 ];
el(32,:) = [  2  8 ];
el(33,:) = [  3  9 ];
el(34,:) = [ 10  4 ];
el(35,:) = [ 11  5 ];
el(36,:) = [ 12  6 ];

el(37,:) = [  4  9 ];
el(38,:) = [  9  5 ];
el(39,:) = [  5  7 ];
el(40,:) = [  7  6 ];
el(41,:) = [  6  8 ];
el(42,:) = [  8  4 ];

% edof ... global incidence matrix spatial motion problem
for i=1:nel
 edof(i,1)=i;
 for j=1:2
  ic1=3*j-1; ic2=3*j; ic3=3*j+1;
  edof(i,ic1)=el(i,j)*3-2;
  edof(i,ic2)=el(i,j)*3-1;
  edof(i,ic3)=el(i,j)*3;
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% material data
 
% microtubules
type =    2;
emod = 1000;
area =    1;
dens =    0;
e_typ( 1: 6,1) = [ 1: 6]; 
e_typ( 1: 6,2) = [ type]; 
e_typ( 1: 6,3) = [ emod];
e_typ( 1: 6,4) = [ area];
e_typ( 1: 6,5) = [ dens];

% nucleus filaments
type =    1;
emod = 1000;
area =    1;
dens =    0;
e_typ( 7:18,1) = [ 7:18]; 
e_typ( 7:18,2) = [ type]; 
e_typ( 7:18,3) = [ emod];
e_typ( 7:18,4) = [ area];
e_typ( 7:18,5) = [ dens];

% intremediate filaments 
type =    1;
emod = 1000;
area =    1;
dens =    0;
e_typ(19:42,1) = [19:42]; 
e_typ(19:42,2) = [ type]; 
e_typ(19:42,3) = [ emod];
e_typ(19:42,4) = [ area];
e_typ(19:42,5) = [ dens];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gravity load
F_gra = zeros(ndof,1);
for ie=1:nel
    nod1 = [ q0(edof(ie,2)); q0(edof(ie,3)); q0(edof(ie,4)) ];
    nod2 = [ q0(edof(ie,5)); q0(edof(ie,6)); q0(edof(ie,7)) ];
    len  = norm( nod2-nod1 );
    lod  = len * e_typ(ie,4) *  e_typ(ie,5) /2;
    F_gra(edof(ie,4)) = F_gra(edof(ie,4)) - lod; 
    F_gra(edof(ie,7)) = F_gra(edof(ie,7)) - lod; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% boundary conditions 
bc = [1 0; 3 0; 5 0; 6 0; 8 0; 9 0];
% bc = [1 0; 2 0.01; 3 0; 4 0.01; 5 0; 6 0; 7 0.01; 8 0; 9 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% external loading 
load      = 20;
F_ext     = zeros(ndof,1);
F_ext(30) = load;
F_ext(33) = load;
F_ext(36) = load;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prestrain
F_pre(1:nel,1) = 1.0;
%stretch   = 1.02;   F_pre(19:42,1) = stretch; % tension on ropes
stretch   = 0.95;   F_pre(  1:6,1) = stretch; % compression on trusses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

