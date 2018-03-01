[p,e,t] = importMeshGmsh('cylinder.msh');


[p,e,t, nVnodes, nPnodes, indices] = convertMeshToSecondOrder(p,e,t);

nu = 0.01;

u = initSolution(p,t,[1 0],0);

for i = 1:5
    [NS, F] = assembleNavierStokesMatrix2D(p,e,t,nu,u(indices.indu),u(indices.indv),'nosupg');
    
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,10,'inlet',[1 0]);
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,12,'slipAlongX',[1 0]);
    [NS, F] = imposeCfdBoundaryCondition2D(p,e,t,NS,F,13,'wall',[1 0]);

    u = NS\F;
end

displaySolution2D(p,t,u,'x-velocity');