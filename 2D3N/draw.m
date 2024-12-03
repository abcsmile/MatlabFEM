function draw(A)
    x = A(:, 1);  % 矩阵每行的第1列（x坐标）
    y = A(:, 2); 
    z = A(:, 3); 
    scatter3(x,y,z);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    axis equal;
    
    % 使得3D图形更美观
    title('3D坐标点');


end