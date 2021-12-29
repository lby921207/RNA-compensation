% Parameters
h = 3600;
uM = 10^(-6);
uMh = uM*h;
ph = log(2)/10*60; % 1/h RNA degradation
kp = 2.1*10^5*uMh*.1;
kn = .3*kp;
kc = 4*2;
km = (kn+kc)/kp;
th = 0.5; % constant expression of activator/ Sequester
zt = 0.5/kc + ph*km/kc; % gene concentration
ztl = zt-ph*km/kc; % load

p = [ph kp kn kc th zt ztl];

n = 14; % layer of cascade
COLOR1 = [252 187 161]/256; % red 
COLOR2 = [227 105 95]/256; % red
COLOR3 = [203 24 29]/256; % red
COLOR4 = [33 113 181]/256; % blue

% Calculate output of each layer without feedback
op = 1;
ztl = (zt-ph*km/kc)*0.5; % load
p = [ph kp kn kc th zt ztl];
X1 = NaN(1,n+1);
X1(1) = th;
for k = 2:n+1
  X1(k) = Cascade_Load(X1(k-1),p,op)
end
% Calculate output of each layer without feedback
op = 1;
ztl = zt-ph*km/kc; % load
p = [ph kp kn kc th zt ztl];
X2 = NaN(1,n+1);
X2(1) = th;
for k = 2:n+1
  X2(k) = Cascade_Load(X2(k-1),p,op)
end

% Calculate output of each layer without feedback
op = 1;
ztl = (zt-ph*km/kc)*2; % load
p = [ph kp kn kc th zt ztl];
X3 = NaN(1,n+1);
X3(1) = th;
for k = 2:n+1
  X3(k) = Cascade_Load(X3(k-1),p,op)
end

% Calculate output of each layer with feedback
op = 2;
ztl = zt-ph*km/kc; % load
p = [ph kp kn kc th zt ztl];
X4 = NaN(1,n+1);
X4(1) = th;
for k = 2:n+1
  X4(k) = Cascade_Load(X4(k-1),p,op)
end

hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])

subplot(1,2,1)

% z = [X1(:), X2(:)];
y = plot(X1,'o-','Color',COLOR1,'LineWidth',2,'MarkerSize',1.5),hold on
y = plot(X2,'o-','Color',COLOR2,'LineWidth',2,'MarkerSize',1.5),hold on
y = plot(X3,'o-','Color',COLOR3,'LineWidth',2,'MarkerSize',1.5),hold on
y = plot(X4,'o-','Color',COLOR4,'LineWidth',2,'MarkerSize',1.5),hold off

%ylim([0 0.6])
xlim([1 15])