% 分网
function [Node,Element,Constrain,Force] = mesh_triangle(a,m,F,q,t)
    % 划分网格
    % INTPUT
    % a--正方形边长
    % m--边上节点数,应该为奇数
    % F--集中荷载
    % p--均布荷载

    % OUTPUT
    % Node--节点
    % Element--单元


    xx = linspace(0,1,m);
    yy = linspace(0,1,m);

    x_shape = zeros(m,m);
    y_shape = zeros(m,m);
    
    for n = 1:m
        x_shape(:,n) = xx(n)*a;
        y_shape(n,:) = yy(n)*a;

    end
    
    x_shape = x_shape';
    y_shape = y_shape';
    Node = [x_shape(:),y_shape(:)];

    % 定义单元
    element = zeros(2*(m-1)^2,3);
    for j = 1:m-1
        k = 5*(j-1);
        for i = 1:m-1 
            k = k+1;
            lk = k-(j-1);

            element(lk,1) = k;
            element(lk,2) = k+1;
            element(lk,3) = k+6;

            near = (m-1)^2;
            element(lk+near,1) = k;
            element(lk+near,2) = k+5;
            element(lk+near,3) = k+6;

        end

    end
    Element = element;

    % 定义边界条件
    Constrain = zeros(m, 3); 
    Constrain(:,1) = m*(m-1)+1:m*m; % 第几个节点
    Constrain(:,2) = 2*Constrain(:,1); % 节点第几个坐标，这里是y为零
    Constrain(:,3) = 0; % 位移约束

    % 定义外力荷载
    Force = zeros(2*m*m,1);

    % 集中力
    Force(m+1) = F;

    % 等效均布力
    Force(2:2:2*m) = 0.5*q*t*a/m;



end