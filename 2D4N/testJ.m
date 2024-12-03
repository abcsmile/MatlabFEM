function testJ(xi,yi,xj,yj,xm,ym,xp,yp)
%TESTB 此处显示有关此函数的摘要
%   此处显示详细说明
s = rand()*10; t = rand()*10;
% Jfirst = [0 1-t t-s s-1 ; t-1 0 s+1 -s-t ;
%  s-t -s-1 0 t+1 ; 1-s s+t -t-1 0];
% J1 = [xi xj xm xp]*Jfirst*[yi ; yj ; ym ; yp]/8;
% 
% 
% load("Nst.mat","Nst");
%     % load("B.mat","B");
% a = Nst(2,:)*[yi ; yj ; ym ; yp];
% b = Nst(1,:)*[yi ; yj ; ym ; yp];
% c = Nst(1,:)*[xi ; xj ; xm ; xp];
% d = Nst(2,:)*[xi ; xj ; xm ; xp];

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
J = round(J);
Bs = Bfirst/J;



 load("Nst.mat","Nst");
% load("B.mat","B");
a = Nst(2,:)*[yi ; yj ; ym ; yp];
b = Nst(1,:)*[yi ; yj ; ym ; yp];
c = Nst(1,:)*[xi ; xj ; xm ; xp];
d = Nst(2,:)*[xi ; xj ; xm ; xp];

B1 = [a*(t-1)/4-b*(s-1)/4 0 ; 0 c*(s-1)/4-d*(t-1)/4 ;
 c*(s-1)/4-d*(t-1)/4 a*(t-1)/4-b*(s-1)/4];
B2 = [a*(1-t)/4-b*(-1-s)/4 0 ; 0 c*(-1-s)/4-d*(1-t)/4 ;
 c*(-1-s)/4-d*(1-t)/4 a*(1-t)/4-b*(-1-s)/4];
B3 = [a*(t+1)/4-b*(s+1)/4 0 ; 0 c*(s+1)/4-d*(t+1)/4 ;
 c*(s+1)/4-d*(t+1)/4 a*(t+1)/4-b*(s+1)/4];
B4 = [a*(-1-t)/4-b*(1-s)/4 0 ; 0 c*(1-s)/4-d*(-1-t)/4 ;
 c*(1-s)/4-d*(-1-t)/4 a*(-1-t)/4-b*(1-s)/4];
JJ = double(a*c-b*d);
Bm = double([B1 B2 B3 B4]/JJ);


Bs == Bm




end

