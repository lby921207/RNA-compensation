% Solve RNA clock
clear
% Bistable parametrs
h = 3600;
uM = 10^(-6);
uMh = uM*h;

% Chemical rates Oscillate
g = 2.1*10^5*uMh*1; % sequestration rate
ph = log(2)/10*60/1; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2*.1*10; % production rate k_cat
km = (kn+kc)/kp; % unbinding/binding between RNA
th = 0.01; % rate activator
b = 0.1; % rate sequester
z1t = 0.1; % gene concentration 1
z2t = 0; % gene concentration 2
m1 = 5; % positive feedback 1
m2 = 0; % positive feedback 2

N = 5; % number of loads
vec = linspace(0,0.2,N); % range of loads

set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 12)

idx1 = 6; % theta
idx2 = 11; % beta
n = 100; % resolution
ex = 1; % scan range
sz = 2; % square size
Lwidth = 2; % dimond

ColM1 = ColorVector([252 187 161;203 24 29],N); % red range
ColM2 = ColorVector([198 219 239;33 113 181],N); % blue range

hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

subplot(1,2,1)
m2 = 0; % positive feedback 2
for i=1:N
    z2t = vec(i); % gene concentration 2
    p = [g ph kp kn kc th z1t z2t m1 m2 b];
    color = ColM1(i,:);
    Func_2D_Bifurcation(idx1,idx2,tf,p,n,ex,color,sz)
    hold on
end
plot(1,1,'kd','Markersize',3*sz,'LineWidth',Lwidth)
hold off

hFig=figure(2);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

subplot(1,2,1)
m2 = 1; % positive feedback 2
for i=1:N
    z2t = vec(i); % gene concentration 2
    p = [g ph kp kn kc th z1t z2t m1 m2 b];
    color = ColM2(i,:);
    Func_2D_Bifurcation(idx1,idx2,tf,p,n,ex,color,sz)
    hold on
end
plot(1,1,'kd','Markersize',3*sz,'LineWidth',Lwidth)
hold off