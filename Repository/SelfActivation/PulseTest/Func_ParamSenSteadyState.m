function [] = Func_ParamSenSteadyState(p,tf,e,N,param)

if length(e)==1
    vec = logspace(-e,e,N);
else
    vec = e;
end
p0=p;

idx = 4;
tspan = [0 tf];
x0 = [0.0308    0.0036    0.0179    0.0345    1.2331];
options = odeset('AbsTol',10^-6);

for i=1:N
    p0(param) = p(param)*vec(i);
    [t,s] = ode23s(@(t,x) ODE_Module_Pulse(t,x,p0),tspan,x0,options);
    y(i) = s(end,idx);
    T(i) = p0(param);
scatter(T,y)
hold on
plot(T,y,'k','LineWidth',2)

end
hold off