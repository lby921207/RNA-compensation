function y = Cascade(x,p,op)
% Implementation of Antethic Control using Toehold switches
ph = p(1);
kp = p(2);
kn = p(3);
kc = p(4);
th = p(5);
zt = p(6);
km = (kn+kc)/kp;
    
if op==1 % cascade with no feedback
    y = (ph*km+kc*zt+x-((ph*km+kc*zt+x)^2-4*kc*x*zt)^0.5)/2;
elseif op==2 % cascade with feedback
    y = kc*(x*zt)/(x+ph*km);
end

