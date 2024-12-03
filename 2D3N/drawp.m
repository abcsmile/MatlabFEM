function drawp(A)
    m=sqrt(size(A,1));

    x = A(:, 1);  % 矩阵每行的第1列（x坐标）
    y = A(:, 2); 
    z = A(:, 3); 
    
    %创建一个规则网格
    x_grid = linspace(min(x), max(x), m);  % 网格的x坐标
    y_grid = linspace(min(y),max(y), m);  % 网格的y坐标
    [X, Y] = meshgrid(x_grid, y_grid);  % 生成网格坐标

    % 对原始散点数据进行插值，将其映射到网格上
    Z = griddata(x, y, z, X, Y, 'cubic');  % 'cubic'为插值方法

    figure;
    pcolor(X, Y, Z);  % 使用网格数据绘制伪彩色图
    shading interp;  % 平滑颜色过渡
    colorbar;  % 显示颜色条
    colormap jet;  % 设置颜色映射
end