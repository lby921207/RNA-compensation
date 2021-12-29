function [] = Func_2D_Bifurcation_Pulse(idx1,idx2,tf,par,n,ex,color,sz)

v1 = logspace(-ex,ex,n)*par(idx1);
v2 = logspace(-ex,ex,n)*par(idx2);
nv1=par(idx1);
nv2=par(idx2);

tspan = [0 tf];
x0 = [0.09    0    0    0    0];

options = odeset('AbsTol',10^-6);
idx = 1; % z(1) is x

for i=1:n
    par(idx1) = v1(i); 
    for j=1:n
        par(idx2) = v2(j);
%         par = UpdateParam(par);
        
          [t,s] = ode23s(@(t,x) ODE_Module_Pulse(t,x,par),tspan,x0,options);
          y = s(end,idx);
        
        if ~isempty(y)
            if y>=0.05 % ON
            scatter(v2(j)/nv2,v1(i)/nv1,sz,'s','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerFaceAlpha',1,'MarkerEdgeAlpha',1),hold on      
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 vy = log10([min(v1) max(v1)]/nv1);
 vy = [floor(vy(1)) ceil(vy(2))];
 vy = 10.^vy;
 vx = log10([min(v2) max(v2)]/nv2);
 vx = [floor(vx(1)) ceil(vx(2))];
 vx = 10.^vx;
 xlim(vx);
 ylim(vy);
 
set(gca,'XScale','log')
set(gca,'YScale','log')
 set(gca,'XTick',vx);
set(gca,'XTickLabel',log10(vx));
 set(gca,'YTick',vy);
set(gca,'YTickLabel',log10(vy));
 hold on
end

function y = UpdateParam(p)
    y = [p(1) p(2) p(1) p(2) p(5) p(6) p(5) p(6) p(9:11)];
end