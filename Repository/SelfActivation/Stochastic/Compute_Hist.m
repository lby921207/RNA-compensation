function [t1,y1,t2,y2]=Compute_Hist(p,Omega,T)

% Initial condition

x0 = round(Omega*[ 1 0. 0. ]');
[t1,y1] = Compute_SS(p,Omega,x0,T);

x0 = round(Omega*[ 0 1 0. ]');
[t2,y2] = Compute_SS(p,Omega,x0,T);

end

function [T,out]= Compute_SS(p,Omega,x0,Tmax)
x = x0;
t = 0;

[ S, h, ~ ] = Model_Bistable( Omega,p );

% Simulation time
% Tmax = 5*4;

X = nan(size(x,1),100000);
T = nan(1,100000);
u =nan(1,100000);
% Write the initial state to the first "record"
X(:,1) = x;
T(1) = t;
u(1) = 0;

step = 1;
while t<Tmax
    hs = h(x);
    hscs = cumsum(hs);
    rateall = sum(hs);
    tau = -log(rand)/rateall;
    r = rand*sum(hs);
    j = find(r<=hscs,1,'first');
    x = x + S(:,j);
    t = t+tau;
    step = step + 1;
    X(:,step) = x;
    T(step) = t;
end
out = X/Omega; 
end