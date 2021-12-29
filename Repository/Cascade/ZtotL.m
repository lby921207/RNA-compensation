function y = ZtotL(x,p)
% Implementation of Antethic Control using Toehold switches
ph = p(1);
kp = p(2);
kn = p(3);
kc = p(4);
th = p(5);
zt = p(6);
km = (kn+kc)/kp;
    
y = kc*zt-(ph*km)./(1-x/zt);

end

