function k = Quad2D8N_Stiffness(E, NU, h, X, Y, ID)
%该函数计算单元的刚度矩阵
%输入弹性模量 E，泊松比 NU，厚度 h
%输入 8个节点的坐标 X(8X1), Y(8X1)
%输入平面问题性质指示参数 ID(1 为平面应力，2 为平面应变)
%输出单元刚度矩阵 k(8X8)
%---------------------------------------------------------------
syms s t

N5 = (1-s^2)*(1-t)/2;
N6 = (1-t^2)*(1+s)/2;
N7 = (1-s^2)*(1+t)/2;
N8 = (1-t^2)*(1-s)/2;
N1 = (1-s)*(1-t)/4-N5/2-N8/2;
N2 = (1+s)*(1-t)/4-N5/2-N6/2;
N3 = (1+s)*(1+t)/4-N6/2-N7/2;
N4 = (1-s)*(1+t)/4-N7/2-N8/2;

N1s = diff(N1, s);
N1t = diff(N1, t);
N2s = diff(N2, s);
N2t = diff(N2, t);
N3s = diff(N3, s);
N3t = diff(N3, t);
N4s = diff(N4, s);
N4t = diff(N4, t);
N5s = diff(N5, s);
N5t = diff(N5, t);
N6s = diff(N6, s);
N6t = diff(N6, t);
N7s = diff(N7, s);
N7t = diff(N7, t);
N8s = diff(N8, s);
N8t = diff(N8, t);

Nst = [N1s N2s N3s N4s N5s N6s N7s N8s;N1t N2t N3t N4t N5t N6t N7t N8t];
% Nst,shape function对s,t偏导


% Nst = load("Nst.mat", "Nst");  % Nst,shape function对s,t偏导

a = Nst(2,:)*Y;
b = Nst(1,:)*Y;
c = Nst(1,:)*X;
d = Nst(2,:)*X;


J = [c,b;d,a];
% [N1x N2x N3x N4x N5x N6x N7x N8x;N1y N2y N3y N4y N5y N6y N7y N8y]
Nxy = J\Nst;

B1 = [Nxy(1,1), 0; 0 Nxy(2,1); Nxy(2,1) Nxy(1,1)];
B2 = [Nxy(1,2), 0; 0 Nxy(2,2); Nxy(2,2) Nxy(1,2)];
B3 = [Nxy(1,3), 0; 0 Nxy(2,3); Nxy(2,3) Nxy(1,3)];
B4 = [Nxy(1,4), 0; 0 Nxy(2,4); Nxy(2,4) Nxy(1,4)];
B5 = [Nxy(1,5), 0; 0 Nxy(2,5); Nxy(2,5) Nxy(1,5)];
B6 = [Nxy(1,6), 0; 0 Nxy(2,6); Nxy(2,6) Nxy(1,6)];
B7 = [Nxy(1,7), 0; 0 Nxy(2,7); Nxy(2,7) Nxy(1,7)];
B8 = [Nxy(1,8), 0; 0 Nxy(2,8); Nxy(2,8) Nxy(1,8)];

B = [B1 B2 B3 B4 B5 B6 B7 B8];
% B = load("B.mat", "B");





if ID == 1
    D = (E/(1-NU*NU))*[1 NU 0 ; NU 1 0 ; 0 0 (1-NU)/2];
   elseif ID == 2
    D = (E/(1+NU)/(1-2*NU))*[1-NU NU 0 ; NU 1-NU 0 ; 0 0 (1-2*NU)/2];
end

BD = transpose(B)*D*B;
% r = int(int(BD, t, -1, 1), s, -1, 1);
r = double(subs(BD,[s,t],[1/1.7321,1/1.7321]) + subs(BD,[s,t],[1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,1/1.7321]));
z = h*r;
k = double(z);

end