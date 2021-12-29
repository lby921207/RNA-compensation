function [M1,M2]=Func_plot_SteadyState(p0,op,Ux,Nx,Nz,ColM1,ColM2)

x = logspace(-6,0,Nx)*Ux;

p = p0;
z2t = linspace(0,1,Nz)*p0(9);
M1 = zeros(Nx,Nz+1);
M2 = zeros(Nx,Nz+1);
for i=1:Nz
    p([9 13]) = [z2t(i) 0]; % m=0 & z2t = 0
    [X,Y] = Func_SteadyState(x,p,op);
    plot(X,Y,'Color',ColM1(i,:),'LineWidth',2), hold on
    M1(:,i+1) = X;
end
M1(:,1) = Y;
for i=1:Nz
    p([9 13]) = [z2t(i) p0(end) ]; % m=0 & z2t = 0
    [X,Y] = Func_SteadyState(x,p,op);
    plot(X,Y,'Color',ColM2(i,:),'LineWidth',2), hold on
    M2(:,i+1) = X;
end
M2(:,1) = Y;
hold off
