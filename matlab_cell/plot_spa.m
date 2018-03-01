%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_spa(e_spa,e_typ,P,is)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot of spatial configuration (3d frame structures) %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf; set(gcf, 'renderer','zbuffer'); hold on; view(-20.0,20);

[nel,one]=size(P);
[P_col]=col_maps(P);
width = [6;12];

indx=[1;4];  x=e_spa(:,indx)';  xc=[x; x(1,:)];
indx=[2;5];  y=e_spa(:,indx)';  yc=[y; y(1,:)];
indx=[3;6];  z=e_spa(:,indx)';  zc=[z; z(1,:)]; 

for ie=1:nel
  if(e_typ(ie,2)==2||P(ie)>0)        % do not draw tensile ropes
     h=plot3(xc(:,ie),yc(:,ie),zc(:,ie),'LineWidth',width(e_typ(ie,2)),'Color',P_col(ie,:)); 
% else; disp(['*** pressure on rope ',num2str(ie),' not displayed ***']);
  end
end

axis off
axis image

print('-dtiff', '-r100', ...
     ['PLOTS/plot_', num2str(is,['%',num2str(4),'.',num2str(4),'d'])])				
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%