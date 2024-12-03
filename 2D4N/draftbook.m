E = 1;
NU = 0.3;
D = (E/(1-NU*NU))*[1 NU 0 ; NU 1 0 ; 0 0 (1-NU)/2];

syms x y a b

N1 = (1+x/a)*(1+y/b)/4;
N2 = (1-x/a)*(1+y/b)/4;
N3 = (1-x/a)*(1-y/b)/4;
N4 = (1+x/a)*(1-y/b)/4;

N = [N1 0 N2 0 N3 0 N4 0;
    0 N1 0 N2 0 N3 0 N4];
B = piandao_2d(N);

syms x1 x2 x3 x4
A = [1 1 1 1;
    1 -1 1 -1;
    1 -1 -1 1;
    1 1 -1 -1];
A = inv(A);
A = 0.25*[1 1 1 1;
    1 -1 -1 1;
    1 1 -1 -1;
    1 -1 1 -1];

coe = A*[x1;x2;x3;x4];
coe = transpose(coe);
x = coe*[1;s;t;s*t];
subs(subs(x,s,1),t,1)
subs(x,[s,t],[1,1])

syms x1 x2 x3 x4 y1 y2 y3 y4 u1 u2 u3 u4 u x y
A = [1 x1 y1 x1*y1;
    1 x2 y2 x2*y2;
    1 x3 y3 x3*y3;
    1 x4 y4 x4*y4];
coe = A\[u1;u2;u3;u4];
coe = transpose(coe);
u = coe*[1;x;y;x*y];
subs(u,[x,y],[x1,y1])

down = x1*x2*y1*y3 - x1*x3*y1*y2 - x1*x2*y1*y4 - x1*x2*y2*y3 + x1*x4*y1*y2 + x2*x3*y1*y2 + x1*x2*y2*y4 + x1*x3*y1*y4 + x1*x3*y2*y3 - x1*x4*y1*y3 - x2*x3*y1*y3 - x2*x4*y1*y2 - x1*x3*y3*y4 - x1*x4*y2*y4 - x2*x3*y2*y4 + x2*x4*y1*y4 + x2*x4*y2*y3 + x3*x4*y1*y3 + x1*x4*y3*y4 + x2*x3*y3*y4 - x3*x4*y1*y4 - x3*x4*y2*y3 - x2*x4*y3*y4 + x3*x4*y2*y4;


