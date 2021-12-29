function [] = Plot_ScanParameter(p,par,Scale,N,tf,x0,COLOR,idx)
% range = logspace(-Scale,Scale,N)*p(par);
range = linspace(0,Scale,N)*p(par);

R_v = linspace(COLOR(1,1),COLOR(2,1),N)';
B_v = linspace(COLOR(1,2),COLOR(2,2),N)';
G_v = linspace(COLOR(1,3),COLOR(2,3),N)';
Col_M = [R_v B_v G_v];

tspan =[0 tf];
options = odeset('AbsTol',10^-6);
%x0 = [0 p(10) 0 0 p(11) 0 0 0];
for i=1:N
    p(par) = range(i);
    [t1,s1] = ode23s(@(t,x) ODE_ModuleLoad_u(t,x,p),tspan,x0,options);
    plot(t1,s1(:,idx),'Color',Col_M(i,:),'LineWidth',2)
    hold on
    
end
hold off
% ylim([0 1]*p(9))
% xlim([0 tf])
% xlabel('Time')
% ylabel('g_1')
