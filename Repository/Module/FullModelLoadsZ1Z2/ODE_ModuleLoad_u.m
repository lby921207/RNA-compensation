function z = ODE_ModuleLoad_u(t,x,p)
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
A = p(14);
T = p(15);

th(1) = A*(sin(2*pi/T*t+pi/2)+1)/2;

x1 =x(1);c1 =x(2);c2 =x(3); w1 =x(4);

z(1) = th(1) - ph*x1 - g*x1*w1 -kp*x1*(zt(1)-c1) + kn*c1  + m(1)*kc*c1 -kp*x1*(zt(2)-c2) + kn*c2  + m(2)*kc*c2;
z(2) = kp*x1*(zt(1)-c1) - kn*c1 - kc*c1;
z(3) = kp*x1*(zt(2)-c2) - kn*c2 - kc*c2;
z(4) = th(2) - ph*w1 - g*x1*w1;




z=z(:);

end

