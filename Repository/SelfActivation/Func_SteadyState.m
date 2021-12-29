function [y, out] = Func_SteadyState(x,p,op)
% Implementation of Antethic Control using Toehold switches
g = p(1);
ph = p(2);
km = p(3);
kc = p(4);
th = p(5);
b = p(6);
z1t = p(7);
m1 = p(8);
z2t = p(9);
m2 = p(10);

z1T = (m1-1)*z1t+(m2-1)*z2t;

k = kc*z1T; 

F = k.*x./(x+km);

if op==1 % input represor beta and output x
    y = (g*x+ph)./(g*x).*(th + F -ph*x);

elseif op==2 % input activator theta and output x
    y = g*x*b./(g*x+ph)+ph*x - F;
%     idx = find(y<0);
%     y(idx) = nan(1,size(idx,2));
end
% y = y/th;
% Output
% out = kc*z1t*x./(x+km);
% out = x./(x+km);
out = x;

