function B = piandao_2d(N)
    syms x y
    B(1,:) = diff(N(1,:),x);
    B(2,:) = diff(N(2,:),y);
    B(3,:) = diff(N(1,:),y) + diff(N(2,:),x);

end