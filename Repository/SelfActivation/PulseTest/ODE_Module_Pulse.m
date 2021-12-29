function z = ODE_Module_Pulse(t,x,p)
% Implementation of Antethic Control using Toehold switches
g = p(1);
ph = p(2);
kp = p(3);
kn = p(4);
kc = p(5);
th1 = p(6);
z1t = p(7);
z2t = p(8);
m1 = p(9);
m2 = p(10);

A = p(11); % amplitude of pulse
T = p(12); % Width of the pulse
t0 = p(13); % Time of pulse

b1 = p(14);

if (t>=t0 && t<=t0+T) 
    th1 = th1 + A;
end

x1 = x(1); c1 = x(2); c2 = x(3);
y = x(4); w1 = x(5);

z(1) = th1 - ph*x1  -kp*x1*(z1t-c1) + kn*c1 + m1*kc*c1  -kp*x1*(z2t-c2) + kn*c2 + m2*kc*c2 - g*x1*w1;
z(2) = kp*x1*(z1t-c1) - kn*c1 - kc*c1;
z(3) = kp*x1*(z2t-c2) - kn*c2 - kc*c2;
z(4) = kc*c1 - ph*y;
z(5) = b1 - ph*w1 - g*x1*w1;

z=z(:);

end

