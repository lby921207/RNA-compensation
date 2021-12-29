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

yl = [0 0.2];  % 0.5
xl = [0 1];

km = (kn+kc)/kp;


hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])


x = linspace(0,1,500);

N = 5;
vec = linspace(0,1,N)/2;

op = 2 ; % Activator
 

% ColM = ColorVector([198 197 224;113 111 178],N); % purple range
ColM1 = ColorVector([217 217 217;82 82 82],N); % purple range

subplot(1,2,1)
for i=1:N
    thv = [.1/4 vec(i)]; % constant expression of activator
    p = [g ph kp kn kc thv zt n m ];
    plot(NullClines(x,p,op),x./(x+km),'Color',ColM1(i,:),'LineWidth',2), hold on
%     plot(NullClines(x,p,op),x,'Color',ColM(i,:),'LineWidth',2), hold on

end
hold off

xlim(xl),xticks(xl)
ylim(yl),yticks(yl)

vec = [1:5];
%  op = 1 ; % Sequester
subplot(1,2,2)
for i=1:N
    nv = [vec(i) 0]; % constant expression of activator
    p = [g ph kp kn kc th zt nv m ];
    plot(NullClines(x,p,op),vec(i)*x./(x+km),'Color',ColM1(i,:),'LineWidth',2), hold on
    
end
hold off

xlim(xl),xticks(xl)
ylim(yl),yticks(yl)


%% Varying the load

hFig=figure(2);
set(hFig,'Units','inches', 'Position', [0 7 3.5 1.5])



vec = linspace(0,1,N);

 op = 2 ; % Activator
 
ColM2 = ColorVector([252 187 161;203 24 29],N); % red range

subplot(1,2,1)
for i=1:N
    ztv = [0.1 vec(i)]; % different loads
    p = [g ph kp kn kc th ztv n m ];
    plot(NullClines(x,p,op),x./(x+km),'Color',ColM2(i,:),'LineWidth',2), hold on
%     plot(NullClines(x,p,op),x,'Color',ColM(i,:),'LineWidth',2), hold on
end
hold off

xlim(xl),xticks(xl)
ylim(yl),yticks(yl)




%% Varying the load

m = [0 1]; % positive feedback m1 - m2

hFig=figure(3);
set(hFig,'Units','inches', 'Position', [0 4 3.5 1.5])



vec = linspace(0,1,N);

 op = 2 ; % Activator
 
ColM3 = ColorVector([198 219 239;33 113 181],N); % blue range

subplot(1,2,1)
for i=1:N
    ztv = [0.1 vec(i)]; % different loads
    p = [g ph kp kn kc th ztv n m ];
    plot(NullClines(x,p,op),x./(x+km),'Color',ColM3(i,:),'LineWidth',2), hold on
%     plot(NullClines(x,p,op),x,'Color',ColM(i,:),'LineWidth',2), hold on
end
hold off

xlim(xl),xticks(xl)
ylim(yl),yticks(yl)



%% Retroactivity
x0 = zeros(1,6);
tf = 2;
tspan =[0 tf];
N0=5;


% th = [0.5*2 0.5];
th(1)= 1;
vec = linspace(0,1,N);



xi = 1;
options = odeset('AbsTol',10^-6);
for i=1:N0
    m = [0 0]; % positive feedback m1 - m2
    p = [g ph kp kn kc th zt(1) vec(i) n m xi];

    [t,s] = ode23s(@(t,x) ODE_ModuleLoadOutput(t,x,p),tspan,x0,options);
    yn = s(:,1)./(s(:,1)+km);
%     yn = s(:,1);
    figure(2),subplot(1,2,2)
    plot(t,yn,'LineWidth',2,'Color',ColM2(i,:)),hold on
    
    m = [0 1]; % positive feedback m1 - m2
    p = [g ph kp kn kc th zt(1) vec(i) n m xi];

    [t,s] = ode23s(@(t,x) ODE_ModuleLoadOutput(t,x,p),tspan,x0,options);
    yn = s(:,1)./(s(:,1)+km);
%     yn = s(:,1);
    figure(3),subplot(1,2,2)
    plot(t,yn,'LineWidth',2,'Color',ColM3(i,:)),hold on
end

figure(2),subplot(1,2,2)
hold off
SetLimits([0 tf],yl)


figure(3),subplot(1,2,2)
hold off
SetLimits([0 tf],yl)

