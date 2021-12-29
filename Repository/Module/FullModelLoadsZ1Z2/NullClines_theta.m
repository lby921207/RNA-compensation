function theta = NullClines_theta(x,p)
% Implementation of Antethic Control using Toehold switches
g = p(1);
ph = p(2);
kp = p(3);
kn = p(4);
kc = p(5);
th = p(6:7);
zt = p(8:9);
n = p(10:11);
m = p(12:13);
km = (kn+kc)/kp;
    
theta = ph*x + g*x*th(2)./(ph+g*x) + (kc*x./(x+km)).*((1-m(1))*zt(1)+(1-m(2))*zt(2));

end

