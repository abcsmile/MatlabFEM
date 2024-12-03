% 节点应力
function stress = Triangle2D3Node_Stress(E, NU, xi, yi, xj, yj, xm, ym, u, ID)


    A = (xi*(yj-ym)+xj*(ym-yi)+xm*(yi-yj))/2;
    beta1 = yj-ym;
    beta2 = ym-yi;
    beta3 = yi-yj;
    gama1 = xm-xj;
    gama2 = xi-xm;
    gama3 = xj-xi;
    B = [beta1 0 beta2 0 beta3 0;
        0 gama1 0 gama2 0 gama3;
        gama1 beta1 gama2 beta2 gama3 beta3]/(2*A);
    if ID == 1
        D = (E/(1-NU*NU))*[1 NU 0; NU 1 0; 0 0 (1-NU)/2];
    elseif ID == 2
        D = (E/(1+NU)*(1-2*NU))*[1-NU NU 0; NU 1-NU 0; 0 0 (1-2*NU)/2];
    end
    stress = D*B*u;
    stress = stress';

end