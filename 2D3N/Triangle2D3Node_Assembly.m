% 组装刚度矩阵
function z = Triangle2D3Node_Assembly(KK, k, i, j, m)
    DOF(1) = 2*i - 1;
    DOF(2) = 2*i;
    DOF(3) = 2*j - 1;
    DOF(4) = 2*j;
    DOF(5) = 2*m - 1;
    DOF(6) = 2*m;
    for n1 = 1:6
        for n2 = 1:6
            KK(DOF(n1), DOF(n2)) = KK(DOF(n1), DOF(n2)) + k(n1, n2);
        end
    end
    z = KK;

end