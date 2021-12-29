function [ S, h, endSim ] = Model_Bistable(Omega,p)
% Parameters
g = p(1)/Omega;
ph = p(2);
km = p(3)*Omega;
kc = p(4);
th = p(5)*Omega;
b = p(6)*Omega;
z1t = p(7)*Omega;
m1 = p(8);
z2t = p(9)*Omega;
m2 = p(10)

% Rate constants 
% c = [1 d 1 d 1 d 1 d 1 d 1 d]';
c = ones(8,1);
% Mass convervation conditions
% cf = @(x) (ct - x(4,:)  - (gTt-x(3,:)));
% Stoichiometry matrix

S = [ 1 -1 0  0 -1 (m1-1) (m2-1) 0 ;
      0  0 1 -1 -1   0     0    0 ;
      0  0 0  0  0   1     0   -1 ];

% Rates
              
h = @(x)(repmat(c,[1 size(x,2)])...
                 .*[ th*ones(1,size(x,2))
                     ph*x(1,:)
                     b*ones(1,size(x,2))
                     ph*x(2,:)
                     g.*x(1,:).*x(2,:)
                     kc*z1t.*x(1,:)./(x(1,:) + km)
                     kc*z2t.*x(1,:)./(x(1,:) + km)
                     ph*x(3,:)
                 ]);

% Never end the simulation
endSim = @(x)(false(1,size(x,2)));


end