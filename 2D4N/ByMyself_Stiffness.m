function k = ByMyself_Stiffness(E,NU,h,x1,y1,x2,y2,x3,y3,x4,y4,ID)
    syms s t
   
    load("Nst.mat","Nst");
    % load("B.mat","B");
    a = Nst(2,:)*[y1;y2;y3;y4];
    b = Nst(1,:)*[y1;y2;y3;y4];
    c = Nst(1,:)*[x1;x2;x3;x4];
    d = Nst(2,:)*[x1;x2;x3;x4];

    B1 = [a*(t-1)/4-b*(s-1)/4 0 ; 0 c*(s-1)/4-d*(t-1)/4 ;
     c*(s-1)/4-d*(t-1)/4 a*(t-1)/4-b*(s-1)/4];
    B2 = [a*(1-t)/4-b*(-1-s)/4 0 ; 0 c*(-1-s)/4-d*(1-t)/4 ;
     c*(-1-s)/4-d*(1-t)/4 a*(1-t)/4-b*(-1-s)/4];
    B3 = [a*(t+1)/4-b*(s+1)/4 0 ; 0 c*(s+1)/4-d*(t+1)/4 ;
     c*(s+1)/4-d*(t+1)/4 a*(t+1)/4-b*(s+1)/4];
    B4 = [a*(-1-t)/4-b*(1-s)/4 0 ; 0 c*(1-s)/4-d*(-1-t)/4 ;
     c*(1-s)/4-d*(-1-t)/4 a*(-1-t)/4-b*(1-s)/4];
    detJ = a*c-b*d;
    B = [B1 B2 B3 B4]/detJ;

    if ID == 1
        D = (E/(1-NU*NU))*[1 NU 0 ; NU 1 0 ; 0 0 (1-NU)/2];
    elseif ID == 2
        D = (E/(1+NU)/(1-2*NU))*[1-NU NU 0 ; NU 1-NU 0 ; 0 0 (1-2*NU)/2];
    end
    
    BD = detJ*transpose(B)*D*B;

    r = int(int(BD, t, -1, 1), s, -1, 1);
    % r = double(subs(BD,[s,t],[1/1.7321,1/1.7321]) + subs(BD,[s,t],[1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,-1/1.7321]) + subs(BD,[s,t],[-1/1.7321,1/1.7321]));
    k = double(r*h);

end