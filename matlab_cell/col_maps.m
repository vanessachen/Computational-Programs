%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [P_col]=col_maps(P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set color map for P field %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nel,one]=size(P);

if(max(P)>-min(P))
   for ie=1:nel
   if(P(ie)>=0)	 
     if(P(ie)>(max(P)/2))
        P_col(ie,:)=[0.0; (1-P(ie)/max(P))*2; 1.0];
	 else
		P_col(ie,:)=[0.0; 1.0; P(ie)/(max(P)/2)];
	 end	 
   else
     if(-P(ie)>(max(P)/2))
        P_col(ie,:)=[ 1.0; (1+P(ie)/max(P))*2;  0.0];
	 else
	    P_col(ie,:)=[-P(ie)/(max(P)/2); 1.0; 0.0];
	 end	 	 
   end
   end
else
   for ie=1:nel
   if(P(ie)>=0)
     if(P(ie)>(-min(P)/2))
       P_col(ie,:)=[0.0; (1+P(ie)/min(P))*2; 1.0];
	 else
	   P_col(ie,:)=[0.0; 1.0; -P(ie)/(min(P)/2)];
	 end	 
   else
     if(-P(ie)>(-min(P)/2))
     P_col(ie,:)=[1.0; (1-P(ie)/min(P))*2; 0.0];
	 else
	 P_col(ie,:)=[P(ie)/(min(P)/2); 1.0; 0.0];
	 end	 		 
   end
   end
end
%[P(:),P_col()]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%