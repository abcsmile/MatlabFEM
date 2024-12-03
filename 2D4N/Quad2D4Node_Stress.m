function stress= Quad2D4Node_Stress(E,NU,xi,yi,xj,yj,xm,ym,xp,yp,n,u,ID)
%该函数计算单元的应力
%输入弹性模量 E，泊松比 NU，厚度 h，
%输入 4 个节点 i、j、m、p 的坐标 xi,yi,xj,yj,xm,ym,xp,yp,
%输入平面问题性质指示参数 ID(1 为平面应力，2 为平面应变)
%输入单元的位移列阵 u(8X1)
%输出单元的应力 stress(3X1)
%---------------------------------------------------------------
syms s t;
a = (yi*(s-1)+yj*(-1-s)+ym*(1+s)+yp*(1-s))/4;
b = (yi*(t-1)+yj*(1-t)+ym*(1+t)+yp*(-1-t))/4;
c = (xi*(t-1)+xj*(1-t)+xm*(1+t)+xp*(-1-t))/4;
d = (xi*(s-1)+xj*(-1-s)+xm*(1+s)+xp*(1-s))/4;
B1 = [a*(t-1)/4-b*(s-1)/4 0 ; 0 c*(s-1)/4-d*(t-1)/4 ;
 c*(s-1)/4-d*(t-1)/4 a*(t-1)/4-b*(s-1)/4];
B2 = [a*(1-t)/4-b*(-1-s)/4 0 ; 0 c*(-1-s)/4-d*(1-t)/4 ;
 c*(-1-s)/4-d*(1-t)/4 a*(1-t)/4-b*(-1-s)/4];
B3 = [a*(t+1)/4-b*(s+1)/4 0 ; 0 c*(s+1)/4-d*(t+1)/4 ;
 c*(s+1)/4-d*(t+1)/4 a*(t+1)/4-b*(s+1)/4];
B4 = [a*(-1-t)/4-b*(1-s)/4 0 ; 0 c*(1-s)/4-d*(-1-t)/4 ;
 c*(1-s)/4-d*(-1-t)/4 a*(-1-t)/4-b*(1-s)/4];
Bfirst = [B1 B2 B3 B4];
Jfirst = [0 1-t t-s s-1 ; t-1 0 s+1 -s-t ;
 s-t -s-1 0 t+1 ; 1-s s+t -t-1 0];
J = [xi xj xm xp]*Jfirst*[yi ; yj ; ym ; yp]/8;
B = Bfirst/J;
if ID == 1
 D = (E/(1-NU*NU))*[1 NU 0 ; NU 1 0 ; 0 0 (1-NU)/2];
elseif ID == 2
 D = (E/(1+NU)/(1-2*NU))*[1-NU NU 0 ; NU 1-NU 0 ; 0 0 (1-2*NU)/2];
end
str1 = D*B*u;
str1 = transpose(str1);
str2 = [n(1) subs(str1, {s,t}, {1,1});
    n(2) subs(str1, {s,t}, {-1,1});
    n(3) subs(str1, {s,t}, {-1,-1});
    n(4) subs(str1, {s,t}, {1,-1});]; % 节点号+三个应力
% str2 = subs(str1, {s,t}, {0,0});
stress = double(str2);
