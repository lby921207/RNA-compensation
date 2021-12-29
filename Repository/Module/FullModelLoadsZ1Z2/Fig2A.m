% Solve RNA clock
%close all,clc, clear all
% Bistable parametrs
h = 3600;
uM = 10^(-6);
uMh = uM*h;

% Chemical rates Oscillate
g = 2.1*10^5*uMh*1;
ph = log(2)/10*60; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2; % 1/h Protein degradation
th = [.1/4 0.5]; % constant expression of activator/ Sequester
zt = [0.1 0]; % z1 - z2(loads z1) 
n = [0 0 ]; % output gain n1 - n2
m = [0 0 ]; % positive feedback m1 - m2


p = [g ph kp kn kc th zt n m ];

yl = [0 0.1];  % 0.5
xl = [0 1];

km = (kn+kc)/kp;


hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])


x = linspace(0,1,500);

N = 2;
vec = linspace(0,1,N)/2;

op = 2 ; % Activator
 

% ColM = ColorVector([198 197 224;113 111 178],N); % purple range
ColM1 = ColorVector([217 217 217;82 82 82],N); % purple range

subplot(1,2,1)
m = [0 0 ];
ztv = [0.1 0.5]; % different loads
p = [g ph kp kn kc th ztv n m ];
plot(NullClines(x,p,op),x,'Color',[203 24 29]/256,'LineWidth',2), hold on

m = [0 1 ];
ztv = [0.1 0.5]; % different loads
p = [g ph kp kn kc th ztv n m ];
plot(NullClines(x,p,op),x,'Color',[33 113 181]/256,'LineWidth',2), hold on

m = [0 0 ];
ztv = [0.1 0]; % different loads
p = [g ph kp kn kc th ztv n m ];
plot(NullClines(x,p,op),x,'--','Color',[160 160 160]/256,'LineWidth',2), hold on

hold off

xlim(xl),xticks(xl)
ylim(yl),yticks(yl)

x0 = zeros(1,6);
tf = 2;
tspan =[0 tf];
N0=2;

% th = [0.5*2 0.5];
th(1)= 1;
vec = linspace(0,1,N);

xi = 1;
options = odeset('AbsTol',10^-6);

subplot(1,2,2)

m = [0 0]; % positive feedback m1 - m2
ztv = [0.1 0.5]; % different loads
p = [g ph kp kn kc th ztv n m xi];
[t,s] = ode23s(@(t,x) ODE_ModuleLoadOutput(t,x,p),tspan,x0,options);
yn = s(:,1);
plot(t,yn,'LineWidth',2,'Color',[203 24 29]/256),hold on

m = [0 0]; % positive feedback m1 - m2
ztv = [0.1 0]; % different loads
p = [g ph kp kn kc th ztv n m xi];
[t,s] = ode23s(@(t,x) ODE_ModuleLoadOutput(t,x,p),tspan,x0,options);
yn = s(:,1);
plot(t,yn,'--','LineWidth',2,'Color',[160 160 160]/256),hold on

m = [0 1]; % positive feedback m1 - m2
ztv = [0.1 0.5]; % different loads
p = [g ph kp kn kc th ztv n m xi];
[t,s] = ode23s(@(t,x) ODE_ModuleLoadOutput(t,x,p),tspan,x0,options);
yn = s(:,1);
plot(t,yn,'LineWidth',2,'Color',[33 113 181]/256),hold on

hold off
SetLimits([0 tf],yl)
