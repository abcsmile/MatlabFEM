function J = jocabi(x, y, s, t)
    J11 = diff(x, s);
    J12 = diff(y, s);
    J21 = diff(x, t);
    J22 = diff(y, t);
    J = det([J11 J12; J21 J22]);


end