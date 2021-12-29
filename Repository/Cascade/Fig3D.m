clear all
clc 
% Solve RNA clock
%close all,clc, clear all
% Parametrs
h = 3600;
uM = 10^(-6);
uMh = uM*h;

g = 2.1*10^5*uMh*.1;
ph = log(2)/10*60; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2;
km = (kn+kc)/kp;
zt = 0.5/kc + ph*km/kc; % gene concentration
ztl = zt-ph*km/kc; % load

th = [0.5 0 0 0 0]; % activator input
a = [0 0 0 0 0]; % sequestration input 
M1 = [0 0 0 0 0]; % positive feedback m1 (target)
M2 = [0 0 0 0 0]; % positive feedback m2 (load)
n = [0 1 1 1 1]; % output gain
ZT = [zt zt zt zt zt] % target concentration
ZTL = [0 0 0 0 0]; % load concentration

s = size(ZT,2); % time scale the smaller it is the faster the system is

N = zeros(s,s); % connection matrix 1->2->3..->n
for i=1:s-1
    N(i+1,i) = n(i+1);
end
% km = (kn+kc)/kp;

p = [g ph kp kn kc th a ZT ZTL M1 M2 s];

% p0 = [g ph km kc th1 th2 z1t z2t n1 n2 m1 m2];


tf = 4*1;
tspan =[0 tf];
options = odeset('AbsTol',10^-6);
% T1 A1 R1 T2 A2 R2 T5 T6 R5 R6
x0 = zeros(1,4*s);


[t1,s1] = ode23s(@(t,x) ODE_ModuleLoad_Serie(t,x,p,N),tspan,x0,options);

set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 12)

hFig=figure(1)
subplot(1,2,1)
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])
plot(t1,s1(:,1)*zt*kc./(s1(:,1)+km),'Color',[200 200 200]/255,'LineWidth',2),hold on
plot(t1,s1(:,2)*zt*kc./(s1(:,2)+km),'Color',[150 150 150]/255,'LineWidth',2)
plot(t1,s1(:,3)*zt*kc./(s1(:,3)+km),'Color',[100 100 100]/256,'LineWidth',2)
plot(t1,s1(:,4)*zt*kc./(s1(:,4)+km),'Color',[50 50 50]/255,'LineWidth',2)
plot(t1,s1(:,5)*zt*kc./(s1(:,5)+km),'Color',[0 0 0]/255,'LineWidth',2)
%legend('x_1','x_2','x_3','x_4','x_5')
xlabel('time (h)'),hold on
%ylabel('X (\muM)'), hold off
ylim([0 0.6])

h = 3600;
uM = 10^(-6);
uMh = uM*h;

g = 2.1*10^5*uMh*.1;
ph = log(2)/10*60; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2;
km = (kn+kc)/kp;
zt = 0.5/kc + ph*km/kc; % gene concentration
ztl = zt-ph*km/kc; % load

th = [0.5 0 0 0 0]; % activator input
a = [0 0 0 0 0]; % sequestration input 
M1 = [1 1 1 1 1]; % positive feedback m1 (target)
M2 = [0 0 0 0 0]; % positive feedback m2 (load)
n = [0 1 1 1 1]; % output gain
ZT = [zt zt zt zt zt] % target concentration
ZTL = [0 0 0 0 0]; % load concentration

s = size(ZT,2); % time scale the smaller it is the faster the system is

N = zeros(s,s); % connection matrix 1->2->3..->n
for i=1:s-1
    N(i+1,i) = n(i+1);
end
% km = (kn+kc)/kp;

p = [g ph kp kn kc th a ZT ZTL M1 M2 s];

% p0 = [g ph km kc th1 th2 z1t z2t n1 n2 m1 m2];


tf = 4*1;
tspan =[0 tf];
options = odeset('AbsTol',10^-6);
% T1 A1 R1 T2 A2 R2 T5 T6 R5 R6
x0 = zeros(1,4*s);


[t1,s1] = ode23s(@(t,x) ODE_ModuleLoad_Serie(t,x,p,N),tspan,x0,options);

set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 12)

hFig=figure(1)
subplot(1,2,1)
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])
plot(t1,s1(:,1)*zt*kc./(s1(:,1)+km),'Color',[198 219 239]/255,'LineWidth',2),hold on
plot(t1,s1(:,2)*zt*kc./(s1(:,2)+km),'Color',[156 192 225]/255,'LineWidth',2)
plot(t1,s1(:,3)*zt*kc./(s1(:,3)+km),'Color',[115 166 210]/255,'LineWidth',2)
plot(t1,s1(:,4)*zt*kc./(s1(:,4)+km),'Color',[73 140 195]/255,'LineWidth',2)
plot(t1,s1(:,5)*zt*kc./(s1(:,5)+km),'Color',[32 113 181]/255,'LineWidth',2)
%legend('x_1','x_2','x_3','x_4','x_5')
xlabel('time (h)'), hold off
%ylabel('\mu M'), hold off
ylim([0 0.6])



