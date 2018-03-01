%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dof] = solve_nr(K,R,dof,iter,bc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solve linearized system of equations by taking into account bc's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:  K     = [ ndof x ndof ]          ... global tangent   K
%         R     = [ ndof x 1    ]          ... global residual  R
%         dof   = [ ndof x 1 ]             ... updated of unknowns
%         iter  = [ 1 ]                    ... no of iteration
%         bc    = [ nbc  x 2 ]             ... dirichlet bc's
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output: dof   = [ ndof x 1 ]             ... updated of unknowns
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tol = 1e-10;

if nargin==4 ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solve system without dirichlet boundary conditions ???
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   dof  = dof-K\R ; 

elseif nargin==5;
   [nd,nd]=size(K);
   fdof=[1:nd]';
   
   pdof = bc(:,1);
   dp   = bc(:,2);
   fdof(pdof)=[];
      
   if(iter>1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% solve system for homogeneous dirichlet boundary conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     s=-K(fdof,fdof)\ R(fdof);
   else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impose non-homogeneous dirichlet boundary conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     s=-K(fdof,fdof)\(R(fdof)+K(fdof,pdof)*dp);
     dof(pdof)=dof(pdof) + dp;
   end
   
   dof(fdof)=dof(fdof) + s;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
