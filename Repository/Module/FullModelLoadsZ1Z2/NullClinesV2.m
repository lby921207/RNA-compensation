function y = NullClinesV2(x,p,op)
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
    
if op==1 % input x_1 and output x_2
    F = ((m(1)-1)*zt(1)+(m(2)-1)*zt(2))*kc*x./(x+km);
    y=(th(1) - ph*x + F)./(g*x); 
elseif op==2 % input x_2 and output x_1    
    y = th(2)./(g*x+ph);
end

