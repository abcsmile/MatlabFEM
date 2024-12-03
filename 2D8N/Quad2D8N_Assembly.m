function z = Quad2D8N_Assembly(KK,k,NodeIndex)

    DOF = zeros(16,1);
    DOF(1:2:15) = 2*NodeIndex-1;
    DOF(2:2:16) = 2*NodeIndex;

    for i = 1:16
        for j = 1:16
            KK(DOF(i), DOF(j)) = KK(DOF(i), DOF(j))+k(i, j);

        end

    end
    z = KK;