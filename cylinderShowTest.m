% Solution of the flow problem
clc;
clear;

% Tutorial 16: Passive Scalar Transport in a Microfluidic Device
% 
% QuickerSim CFD Toolbox for MATLAB(R) Tutorial
%
% <http://www.quickersim.com/cfd-toolbox-for-matlab/index>.
%
% This tutorial is intended for the free and full version of the toolbox.

% Read mesh
[p,e,t] = importMeshGmsh('cylinder.msh');
p = p/1000; % p array stores mesh coordinates - rescale to [mm]
displayMesh2D(p,t);

% Convert mesh to second order
[p,e,t,nVnodes,nPnodes,indices] = convertMeshToSecondOrder(p,e,t);

% Define fluid kinematic viscosity of water
%viscosity of gfp in cytoplasm
nu = 1e-6; % water viscosity [m^2/s]
%nu = 3e-11;

% Init solution and convergence criteria
[u, convergence] = initSolution(p,t,[0.05 0],0);
maxres = 1e-9;
%maxres = 1e-12;
maxiter = 25;

% Define inlet velocity profile
vel = [0.05 0]; % x-velocity of 50 mm/s = 0.05 m/s

%%%%%%%%%%%%%%%find velocity of gfp in cytoplasm

% Iterate nonlinear terms
for iter = 1:maxiter
    % Assemble matrix and right hand side
    [NS, F] = assembleNavierStokesMatrix2D(p,e,t,nu,u(indices.indu),u(indices.indv),'nosupg');
    
    % Apply boundary conditions
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,10,'inlet',vel);
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,12,'slipAlongX',vel);
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,13,'wall',vel);

    
    % Compute and plot residuals
    [stop, convergence] = computeResiduals(NS,F,u,size(p),convergence,maxres);
    plotResiduals(convergence,2);
    
    % Break if solution converged
    if(stop)
        break;
    end
    
    % Solve equations
    u = NS\F;
end

% Plot velocity field
figure(3);
vmag = sqrt(u(indices.indu).^2+u(indices.indv).^2);
displaySolution2D(p,t,vmag,'Velocity magnitude');

% Solution of the Scalar Transport Problem

% Define scalar diffusivity
k = 1e-7;
%k = 4e-11;

%%%%%%find scalar diffusivity

% Assemble problem matrix
[D,F] = assembleDiffusionMatrix2D(p,t,k);
D = D + assembleScalarConvectionMatrix2D(p,t,k,u(indices.indu),u(indices.indv),'supgDoublyAsymptotic');

% Apply boundary conditions
[D,F] = imposeScalarBoundaryCondition2D(p,e,D,F,10,'value',0);
[D,F] = imposeScalarBoundaryCondition2D(p,e,D,F,13,'value',1);

% Solve system of equations
phi = D\F;

% Simple Postprocessing

figure(4);
displaySolution2D(p,t,phi,'Concentration');

figure(5);
pressure = generatePressureData(u,p,t);
rho = 1000;
displaySolution2D(p,t,rho*pressure,'Pressure [Pa]');

% We can also monitor average pressure at each of the inlets with the
% following code
[~,p_in_10] = boundaryIntegral2D(p,e,rho*pressure,10);
[~,p_in_13] = boundaryIntegral2D(p,e,rho*pressure,13);

disp(p_in_10)
disp(p_in_13)
