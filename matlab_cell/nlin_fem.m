%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nonlinear elastostatic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% input of individual discretization, geometry, material data
 [q0,edof,u_ext,F_ext,F_gra,F_pre,e_typ,nel,node,ndof] = inp_cell;
% [q0,edof,u_ext,F_ext,F_gra,F_pre,e_typ,nel,node,ndof] = inp_tens;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
dt     = 1;                       % init pseudo time
time   = dt;                      % init time
tol    = 1e-10;                   % tolerance of newton iteration
dof    = q0;                      % init spatial coordinates
e_mat  = extr_dof(edof,q0);       % init material coordinates
e_spa  = extr_dof(edof,dof);      % init spatial coordinates
nsteps = 0;                       % init no of time steps
F_upd  = F_gra;                   % init total external force vector
u_upd  = u_ext;                      % init total external force vector

plot_mat(e_mat,e_typ);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for im=1:1000 
 macro = input('macro:','s'); [ir,ic] = size(macro);
 if ic<4; disp('@ least 4 letters needed for input'); else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% apply load in instep increments of instep*F_pre through step,,instep 
  if (strcmp(macro(1:4),'step') == 1);
    [ir,ic] = size(macro);
    if ic==4; inpstep = 1; else; inpstep = str2num(macro(7:ic)); end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%% loop over all load steps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for is = (nsteps+1):(nsteps+abs(inpstep));
      iter = 0;  res = 1; disp(['step: ',num2str(is)]);	  
	  
	  u_upd(:,2) = sign(inpstep)*dt*u_ext(:,2);         % update pre displ
      F_upd      = F_upd      +sign(inpstep)*dt*F_ext;  % update pre force 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% global newton-raphson iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    while res > tol
      iter=iter+1; 
	  
      P = zeros(nel,1);
      F = zeros(ndof,1);           % initialization of global rhs
      K = zeros(ndof,ndof);        % initialization of global stema
      e_spa = extr_dof(edof,dof);  % extr_dof of global displacements

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%% loop over all elements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      for ie = 1:nel
       [Ke,Fe,Pe] = truss_03(e_mat(ie,:),e_spa(ie,:),F_pre(ie),e_typ(ie,:));
	   [K ,F, P ] = assm_sys(edof(ie,:),K,Ke,F,Fe,P,Pe);
      end
%%%%% loop over all elements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

      dofold = dof;	  
      F = F - F_upd;               % add external force to residual       
      [dof] = solve_nr(K,F,dof,iter,u_upd); % solution of linearized system&update
	  res   = res_norm((dof-dofold),u_upd); % norm of residual including bc's
      disp(['*** iter ',num2str(iter),' *** res ',num2str(res)]);  
      if(iter>20); disp('*** no convergence! ***'); return; else
    end 
    end
    
%%% global newton-raphson iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   	e_spa = extr_dof(edof,dof);
    plot_spa(e_spa,e_typ,P,is);
   end 
   nsteps = nsteps + inpstep;
   
  elseif (strcmp(macro(1:4),'pmat') == 1); plot_mat(e_mat,e_typ);
  elseif (strcmp(macro(1:4),'pspa') == 1); plot_spa(e_spa,e_typ,P,is);
  elseif (strcmp(macro(1:4),'pall') == 1); plot_all(e_spa,e_mat,P);
  elseif (strcmp(macro(1:4),'quit') == 1); return;

  else
   disp('step    ... apply one load step')
   disp('step,,n ... apply  n  load steps')  
   disp('pmat    ... plot material configuration')
   disp('pspa    ... plot spatial  configuration')
   disp('pall    ... plot material and spatial configuration')
   disp('quit    ... quit fe analyses')
  
  end
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







