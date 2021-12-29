function [y, out] = Func_SteadyState(x,p,op)
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
    F1 = ((m(1)-1)*zt(1)+(m(2)-1)*zt(2))*kc*x./(x+km);
    b2 = (g*x+ph)./(g*x).*(th(1) - ph*x + F1);
    y = b2;
elseif op==2 % input x_2 and output x_1
    F2 = ((m(1)-1)*zt(1)+(m(2)-1)*zt(2))*kc*x./(x+km);  
    b1 = g*th(2)*x./(g*x+ph) + ph*x - F2;
    y = b1;
end
% out = x;
out = x./(x+km);