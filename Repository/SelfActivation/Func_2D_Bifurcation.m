function [] = Func_2D_Bifurcation(idx1,idx2,tf,p,n,ex,color,sz)

g = p(1);
ph = p(2);
kp = p(3);
kn = p(4);
kc = p(5);
km = (kn+kc)/kp;
th = p(6);
z1t = p(7);
z2t = p(8);
m1 = p(9);
m2 = p(10);
b = p(11);

v1 = logspace(-ex,ex,n)*p(idx1);
v2 = logspace(-ex,ex,n)*p(idx2);
nv1=p(idx1);
nv2=p(idx2);

DodgerBlue=[ 0.1172    0.5625    1.0000];
Orange=[1.0000    0.6445         0];
% GRE = [204 204 204]/255;
GRE = [153 153 153]/255;
PUR = [113 111 178]/255;

M = 2;
x = logspace(-8,2,1000)*M;

for i=1:n
    p(idx1) = v1(i); 
    for j=1:n
        p(idx2) = v2(j);
        th = p(6);
        b = p(11);
        F1 = b./(g*x+ph); % sequester
        F2 = (th+kc*x./(x+km)*((m1-1)*z1t+(m2-1)*z2t)-ph*x)./(g*x); % activator
        [x0,y0]=intersections(x,F1,x,F2);
        
        if ~isempty(x0)
            s = length(x0);
            if s==3 % check positive values
                scatter(v2(j)/nv2,v1(i)/nv1,sz,'s','MarkerEdgeColor',color,'MarkerFaceColor',color,'MarkerFaceAlpha',1,'MarkerEdgeAlpha',1),hold on
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