%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_mat(e_mat,e_typ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot of material configuration (3d frame structures) %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf; set(gcf, 'renderer','zbuffer'); hold on; view(-20.0,20);

indx=[1;4];  X=e_mat(:,indx)';  Xc=[X; X(1,:)];
indx=[2;5];  Y=e_mat(:,indx)';  Yc=[Y; Y(1,:)];
indx=[3;6];  Z=e_mat(:,indx)';  Zc=[Z; Z(1,:)]; 

max_a = max(e_typ(:,4));
min_a = min(e_typ(:,4));

[nel,four]=size(e_typ);
for ie=1:nel
  type = e_typ(ie,2);  
  area = e_typ(ie,4);
  if(type==1)  color=[ 0.0; 0.0; 1.0 ]; width= 6; end; 
  if(type==2)  color=[ 1.0; 0.0; 0.0 ]; width=12; end; 
  h=plot3(Xc(:,ie),Yc(:,ie),Zc(:,ie),'LineWidth',width,'Color',color);  
end
plot3(Xc,Yc,Zc,'ko');

axis off
axis image

print('-dtiff', '-r200', ['PLOTS/plot_0000'])				
%print('-depsc', '-r200',  ['PLOTS/plot_0000']);	
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
