function y = ColorVector(COLOR,N)


R_v = linspace(COLOR(1,1),COLOR(2,1),N)';
B_v = linspace(COLOR(1,2),COLOR(2,2),N)';
G_v = linspace(COLOR(1,3),COLOR(2,3),N)';
y = [R_v B_v G_v]/255;