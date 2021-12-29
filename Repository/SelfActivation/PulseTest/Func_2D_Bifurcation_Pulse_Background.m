function [] = Func_2D_Bifurcation_Pulse_Background(idx1,idx2,tf,par,n,ex,color,sz)

v1 = logspace(-ex,ex,n)*par(idx1);
v2 = logspace(-ex,ex,n)*par(idx2);
nv1=par(idx1);
nv2=par(idx2);


Blue=[ 0.0872    0.3625    0.6000];
White=[1 1 1];
Orange=[1.0000    0.6445         0];
% GRE = [204 204 204]/255;
GRE = [153 153 153]/255;
PUR = [113 111 178]/255;

% x = logspace(-8,2,3000);
tspan = [0 tf];
x0 = [0.0308    0.0036    0.0179    0.0345    1.2331];
options = odeset('AbsTol',10^-6);
idx = 4; % y

for i=1:n
    par(idx1) = v1(i); 
    for j=1:n
        par(idx2) = v2(j);
%         par = UpdateParam(par);
        
          [t,s] = ode23s(@(t,x) ODE_Module_Pulse(t,x,par),tspan,x0,options);
          y = s(end,idx);
        
        if ~isempty(y)
            if y<0.2 % OFF
                scatter(v2(j)/nv2,v1(i)/nv1,sz,'s','MarkerEdgeColor',White,'MarkerFaceColor',White),hold on
            elseif y>=0.2 % ON
                scatter(v2(j)/nv2,v1(i)/nv1,sz,'s','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerFaceAlpha',1,'MarkerEdgeAlpha',1),hold on
            else
                
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SOME COLOR DEFINITIONS
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