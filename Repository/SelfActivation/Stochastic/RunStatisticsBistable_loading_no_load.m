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

Omega = 600;
scaleFactor = 1/Omega;

p = [g ph kp kn kc th b z1t z2t m1 m2];

%///////////////////////////////

Col = [0 0 0
    203 24 29
    33 113 181]/256;
% Get reactions
[ S, h, endSim ] = Model_Module( Omega,p );

% Initial condition
x0 = round(Omega*[ 0.025 0. 0. 0.]');

% Simulation time
Tmax = 50;
%///////////////////////////////


%% Set up simulation (multiple trajectories)

reset(RandStream.getGlobalStream);

% Number of trajectories to simulate
numReals = 500;

% Initial state and time
t = repmat(0,[1 numReals]);
x = repmat(x0,[1 numReals]);

% Number of steps done
idx = 0;

% Set up arrays to record trajectories
tsampleIdx = ones(1,numReals);
deltaSample = 0.1;
X = nan(size(x,1),ceil(Tmax/deltaSample+1),size(x,2));
Treg = (0:size(X,2)-1)*deltaSample;
T = nan(1,size(X,2),size(x,2));
X(:,1,:) = x;
T(1,1,:) = t;

%% Actual simulation
while any(t<Tmax)
    updateThese = t<Tmax;
%     pause
    
    if mod(idx,100)==0
        disp([num2str(sum(updateThese)) ' to update, median(t) = ' num2str(median(t(updateThese)))]);
    end
    idx = idx + 1;

    [deltaT, deltaX] = stepGillespie(x(:,updateThese),h,S);

    lastx = x;
    lastt = t;

    % Update state and time
    x(:,updateThese) = x(:,updateThese) + deltaX;
    t(updateThese) = t(updateThese) + deltaT;
    
    
    while(true)
        saveThese = t>(1+eps)*tsampleIdx*deltaSample & tsampleIdx+1<=size(X,2);
        if(~any(saveThese))
            break;
        end
        tsampleIdx(saveThese) = tsampleIdx(saveThese)+1;
        for saveThis = find(saveThese)
            X(:,tsampleIdx(saveThis),saveThis) = lastx(:,saveThis);
            T(1,tsampleIdx(saveThis),saveThis) = lastt(saveThis);
        end
    end
    
    % End some simulations
    endThese = endSim(x);
    x(:,endThese) = nan;
    t(endThese)=nan;
    
end

%figure;

% Molecule Numbers
%plot(Treg,squeeze(X(1,:,:)));

% Concentrations
%plot(Treg,squeeze(X(1,:,:))/Omega);


%% Plot statistics


set(0,'DefaultAxesFontName', 'Arial')
set(0,'DefaultAxesFontSize', 12)
tst = {'x_1','y_1','w_1','x_2','y_2','w_2','u'};

% x(1,:) - STAR
% x(2,:) - Sequester
% x(3,:) - output

i1 = 1;
i2 = 4;
data1 = [];data2 = [];data3 = [];
for j=1:size(X,3)
    data1 = [data1;X(i1,:,j)];
    data2 = [data2;X(i2,:,j)];
    data3 = [data3;X(i1,:,j)-X(i2,:,j)];
end
data1 = data1'*scaleFactor;
data2 = data2'*scaleFactor;
data3 = data3'*scaleFactor;
%%
N = 100/3;
ym = 0.6;

vv = linspace(-5,5,40*N);

hFig=figure(1);
set(hFig,'Units','inches', 'Position', [0 9 3.5 1.5])

subplot(1,2,1)
plot(data3,'Color',[0.5 0.5 0.5 0.3]) %line color and transparency
xlim([0 1.1]*Tmax)
ylim([-0.25 1]*ym)

subplot(1,2,2)
histogram(data3(end,:),vv,'orientation','horizontal','DisplayStyle','bar',...
    'Normalization','probability','FaceColor',Col(1,:),'EdgeColor','none','LineWidth',1)
ylim([-0.25 1]*ym)
xlim([0 .25])
