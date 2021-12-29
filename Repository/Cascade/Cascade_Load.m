function y = Cascade(x,p,op)
ph = p(1);
kp = p(2);
kn = p(3);
kc = p(4);
th = p(5);
zt = p(6);
ztl = p(7);
km = (kn+kc)/kp;
    
if op==1 % cascade with load but no feedback
    y = (ph*km+kc*ztl+x-((ph*km+kc*ztl+x)^2-4*kc*x*ztl)^0.5)/(2*ztl/zt);
elseif op==2 % cascade with load and feedback
    y = kc*(x*zt)/(x+ph*km);
end

