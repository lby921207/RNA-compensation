function []= Func_ParamSen(p,x,op,e,N,param,COLOR)

R_v = linspace(COLOR(1,1),COLOR(2,1),N)';
B_v = linspace(COLOR(1,2),COLOR(2,2),N)';
G_v = linspace(COLOR(1,3),COLOR(2,3),N)';
ColM = [R_v B_v G_v];

if length(e)==1
    vec = logspace(-e,e,N);
else
    vec = e;
end
p0=p;

for i=1:N
    p0(param) = p(param)*vec(i);
    [X,Y] = Func_SteadyState(x,p0,op);

    plot(X,Y,'Color',ColM(i,:),'LineWidth',2), hold on
    set(gca, 'YScale', 'log')
    set(gca, 'XScale', 'log')
end
hold off