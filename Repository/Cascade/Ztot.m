function y = Ztot(x,p)
% Implementation of Antethic Control using Toehold switches
ph = p(1);
kp = p(2);
kn = p(3);
kc = p(4);
th = p(5);
km = (kn+kc)/kp;

y = x*kc - ph*km;

end

