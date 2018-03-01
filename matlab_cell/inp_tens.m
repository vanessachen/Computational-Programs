%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [q0,edof,bc,F_ext,F_gra,F_pre,e_typ,nel,node,ndof] = inp_tens
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% number of elements, nodes, dofs
nel  = 30;
node = 12;
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

% intremediate filaments 
el( 7,:) = [  1  2 ];
el( 8,:) = [  2  3 ];
el( 9,:) = [  3  1 ];
el(10,:) = [ 10 11 ];
el(11,:) = [ 11 12 ];
el(12,:) = [ 12 10 ];

el(13,:) = [  1  5 ];
el(14,:) = [  2  6 ];
el(15,:) = [  3  4 ];
el(16,:) = [ 10  8 ];
el(17,:) = [ 11  9 ];
el(18,:) = [ 12  7 ];

el(19,:) = [  1  7 ];
el(20,:) = [  2  8 ];
el(21,:) = [  3  9 ];
el(22,:) = [ 10  4 ];
el(23,:) = [ 11  5 ];
el(24,:) = [ 12  6 ];

el(25,:) = [  4  9 ];
el(26,:) = [  9  5 ];
el(27,:) = [  5  7 ];
el(28,:) = [  7  6 ];
el(29,:) = [  6  8 ];
el(30,:) = [  8  4 ];

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

% intremediate filaments 
type =    1;
emod = 1000;
area =    1;
dens =    0;
e_typ( 7:30,1) = [ 7:30]; 
e_typ( 7:30,2) = [ type]; 
e_typ( 7:30,3) = [ emod];
e_typ( 7:30,4) = [ area];
e_typ( 7:30,5) = [ dens];

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
% bc = [1 0; 2 0; 3 0; 4 0; 5 0,; 6 0; 7 0; 8 0; 9 0; 28 0; 29 0; 31 0; 32 0; 34 0; 35 0];
bc = [1 0; 3 0; 5 0,; 6 0; 8 0; 9 0];

% external loading 
load      = 20;
F_ext     = zeros(ndof,1);
F_ext(30) = load;
F_ext(33) = load;
F_ext(36) = load;

% prestrain
F_pre(1:nel,1) = 1.0;
 stretch   = 1.10;   F_pre(7:30,1) = stretch; % tension on ropes
%stretch   = 0.95;   F_pre( 1:6,1) = stretch; % compression on trusses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

