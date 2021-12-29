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

p = [ph kp kn kc th];

COLOR1 = [203 24 29]/256; % red
COLOR2 = [33 113 181]/256; % blue



hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 10 3.5 1.5])

subplot(1,2,1)
x = linspace(ph*km/kc,1/kc + ph*km/kc,500);
plot(x,Ztot(x,p),'Color',COLOR2,'LineWidth',2),hold on

x = linspace(0,ph*km/kc,500);
plot(x,x*0,'Color',COLOR2,'LineWidth',2),hold on

x = linspace(0,1/kc + ph*km/kc,500);
plot(x,x*0,"--",'Color',COLOR1,'LineWidth',2),hold off

ylim([0 1])
xlim([0 1/kc + ph*km/kc])