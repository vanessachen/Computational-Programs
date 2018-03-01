%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [K,F,P]=assm_sys(edof,K,Ke,F,Fe,P,Pe)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% assemble local element contributions to global stiffness and force
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input:  edof  = [ elem X1 Y1 X2 Y2 ]   	... incidence matrix
%         Ke    = [ 6 x 6 ]        			... element stiffness matrix 
%         Fe    = [ f_1 fy1 fz1 fx2 fy2 ]   ... element load vector
%         Pe    = [ Pe ]                    ... element stress
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output: K     = [ ndof x ndof ]           ... global stiffness matrix
%         F     = [ ndof x 1] 			    ... global load vector
%         P     = [ nel  x 1] 			    ... global stress vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nie,n]=size(edof);
t=edof(:,2:n);

P(edof(:,1)) = Pe;
for i = 1:nie
   K(t(i,:),t(i,:)) = K(t(i,:),t(i,:))+Ke;
   F(t(i,:))=F(t(i,:))+Fe;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
