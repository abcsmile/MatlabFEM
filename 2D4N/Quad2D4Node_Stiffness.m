function k = Quad2D4Node_Stiffness(E,NU,h,xi,yi,xj,yj,xm,ym,xp,yp,ID)
%该函数计算单元的刚度矩阵
%输入弹性模量 E，泊松比 NU，厚度 h
%输入 4 个节点 i、j、m、p 的坐标 xi,yi,xj,yj,xm,ym,xp,yp
%输入平面问题性质指示参数 ID(1 为平面应力，2 为平面应变)
%输出单元刚度矩阵 k(8X8)
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
BD = J*transpose(B)*D*B;
% r = int(int(BD, t, -1, 1), s, -1, 1);
 r = double(subs(BD,[s,t],[1/1.7321,1/1.7321]) + subs(BD,[s,t],[1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,1/1.7321]));
z = h*r;
k = double(z);