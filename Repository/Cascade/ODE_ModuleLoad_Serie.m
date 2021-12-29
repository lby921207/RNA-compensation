function z = ODE_ModuleLoad_Serie(t,x,p,N)
% Implementation of Antethic Control using Toehold switches
g = p(1);
ph = p(2);
kp = p(3);
kn = p(4);
kc = p(5);
s = p(end);

th = p(6:s + 5)';
a = p(s + 6:2*s + 5)';
ZT = p(2*s + 6:3*s + 5)';
ZTL = p(3*s + 6:4*s + 5)';

M1 = p(4*s + 6:5*s + 5)';
M2 = p(5*s + 6:6*s + 5)';


x1 =x(1:s);        c1 =x(s+1:2*s);
c2 =x(2*s+1:3*s);  w1 =x(3*s+1:4*s);
% z = x*0;

z(1:s)       = th + kc*N*c1 - ph*x1 - g*x1.*w1 ...
             - kp*x1.*(ZT - c1)  + kn*c1  + kc*M1.*c1 ...
             - kp*x1.*(ZTL - c2) + kn*c2  + kc*M2.*c2;
         
z(s+1:2*s)   = kp*x1.*(ZT - c1)  - kn*c1 - kc*c1;
z(2*s+1:3*s) = kp*x1.*(ZTL - c2) - kn*c2 - kc*c2;
z(3*s+1:4*s) = a - ph*w1 - g*x1.*w1;


z=z(:);

end

