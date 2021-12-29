clear
% Bistable parametrs
h = 3600;
uM = 10^(-6);
uMh = uM*h;

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

M = 2;

COLOR1 = [252 187 161;203 24 29]/256; % red range
COLOR2 = [198 219 239;33 113 181]/256; % blue range


p = [g ph km kc th b z1t m1 z2t m2];

%%
var = {'\gamma','\phi','\kappa_M','\kappa_c','\theta','\beta','z_1^{tot}',...
    'm_1','z_2^{tot}','m_2'};
x = logspace(-8,2,1000)*M;

figure(1)

subplot(1,2,1)
[X,Y] = Func_SteadyState(x,p,1);
plot(X,Y,'k','LineWidth',2)
xlim([0 12])
ylim([0 1])
xlabel('beta')
ylabel('output')
locmax = findpeaks(X)
locmin = -findpeaks(-X)
grey  = [127 127 127]./255;
hold on
%h = fill([locmin locmin locmax locmax],[0 1 1 0],grey)
%set(h,'facealpha',.2,'edgecolor',grey)
hold off

subplot(1,2,2)
[X,Y] = Func_SteadyState(x,p,2);
plot(X,Y,'k','LineWidth',2)
xlim([0 6])
ylim([0 1])
xlabel('theta')
ylabel('output')
locmax = findpeaks(X)
locmin = -findpeaks(-X)
grey  = [127 127 127]./255;
hold on
%h = fill([locmin locmin locmax locmax],[0 1 1 0],grey)
%set(h,'facealpha',.2,'edgecolor',grey)
hold off

%%
hFig=figure(2);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

N = 5;
exv = linspace(0,4,5);

% Scan z2t - loading effect
z2t = 0.05; m2 = 0;
p = [g ph km kc th b z1t m1 z2t m2];
param = 9; op=2;
subplot(1,2,1)
Func_ParamSen(p,x,op,exv,N,param,COLOR1)
ylim([0 1])
xlim([0 6])
hold on

% Add intersections
xline(2,'LineWidth',1)
hold on
z2t = exv(N)*z2t;
p = [g ph km kc th b z1t m1 z2t m2];
[X,Y] = Func_SteadyState(x,p,2);
y_temp = 0:0.001:1;
x_temp = 2*ones(length(y_temp),1);
[x0,y0]=intersections(X,Y,x_temp,y_temp);
plot(x0,y0,'ro','LineWidth',2)
hold off


% Scan z2t - loading effect with feedback
z2t = .05; m2 = 1;
p = [g ph km kc th b z1t m1 z2t m2];
param = 9; op=2;
subplot(1,2,2)
Func_ParamSen(p,x,op,exv,N,param,COLOR2)
ylim([0 1])
xlim([0 6])

% Add intersections
xline(2.5,'LineWidth',1)
hold on
z2t = exv(N)*z2t;
p = [g ph km kc th b z1t m1 z2t m2];
[X,Y] = Func_SteadyState(x,p,2);
y_temp = 0:0.001:1;
x_temp = 2.5*ones(length(y_temp),1);
[x0,y0]=intersections(X,Y,x_temp,y_temp);
plot(x0,y0,'bo','LineWidth',2)
hold off

%%
hFig=figure(3);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

N = 5;
exv = linspace(0,4,5);

% Scan z2t - loading effect
z2t = 0.05; m2 = 0;
p = [g ph km kc th b z1t m1 z2t m2];
param = 9; op=1;
subplot(1,2,1)
Func_ParamSen(p,x,op,exv,N,param,COLOR1)
ylim([0.0002 1])
xlim([0.005 1])

% Add intersections
xline(b,'LineWidth',1)
hold on
z2t = exv(N)*z2t;
p = [g ph km kc th b z1t m1 z2t m2];
[X,Y] = Func_SteadyState(x,p,1);
y_temp = 0:0.001:5;
x_temp = b*ones(length(y_temp),1);
[x0,y0]=intersections(X,Y,x_temp,y_temp);
plot(x0,y0,'ro','LineWidth',2)
hold off

% Scan z2t - loading effect with feedback
z2t = 0.05; m2 = 1;
p = [g ph km kc th b z1t m1 z2t m2];
param = 9; op=1;
subplot(1,2,2)
Func_ParamSen(p,x,op,exv,N,param,COLOR2)
ylim([0.0002 1])
xlim([0.005 1])

% Add intersections
xline(b,'LineWidth',1)
hold on
z2t = exv(N)*z2t;
p = [g ph km kc th b z1t m1 z2t m2];
[X,Y] = Func_SteadyState(x,p,1);
y_temp = 0:0.001:5;
x_temp = b*ones(length(y_temp),1);
[x0,y0]=intersections(X,Y,x_temp,y_temp);
plot(x0,y0,'bo','LineWidth',2)
hold off

