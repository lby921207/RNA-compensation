function [ S, h, endSim ] = Model_Module(Omega,p)
% Parameters
g = p(1)/Omega;
ph = p(2);
kp = p(3)/Omega;
kn = p(4);
kc = p(5);
th = p(6:7)*Omega;
zt = p(8:9)*Omega;
m = p(10:11);

% Rate constants 
% c = [1 d 1 d 1 d 1 d 1 d 1 d]';
c = ones(11,1);
% Mass convervation conditions
% cf = @(x) (ct - x(4,:)  - (gTt-x(3,:)));
% Stoichiometry matrix

S = [  1 -1 -1  1 m(1) -1 1 m(2)  0   0  -1    
       0  0  1 -1  -1  0  0   0   0   0   0     
       0  0  0  0   0  1 -1  -1   0   0   0   
       0  0  0  0   0  0  0   0   1  -1  -1 
     ];

% Rates
              
h = @(x)(repmat(c,[1 size(x,2)])...
                 .*[ th(1)*ones(1,size(x,2))
                     ph*x(1,:)
                     kp*x(1,:).*(zt(1)-x(2,:))
                     kn*x(2,:)
                     kc*x(2,:)
                     kp*x(1,:).*(zt(2)-x(3,:))
                     kn*x(3,:)
                     kc*x(3,:)
                     th(2)*ones(1,size(x,2))
                     ph*x(4,:)
                     g.*x(1,:).*x(4,:)
                 ]);

% Never end the simulation
endSim = @(x)(false(1,size(x,2)));


end