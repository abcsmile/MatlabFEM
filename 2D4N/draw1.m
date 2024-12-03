function draw1(nodes, displacements, elements)

% nodes = [x1, y1; x2, y2; ...]; % 二维示例
% displacements = [u1; u2; ...];
% elements = [n1, n2, n3; ...]; % 每行表示一个单元，由节点编号组成

% 绘制云图
figure;
hold on;

% 使用 patch 绘制有限元网格，并将位移值映射为颜色
patch('Faces', elements, 'Vertices', nodes, ...
      'FaceVertexCData', displacements, ... % 显示的位移数据
      'FaceColor', 'interp', ... % 插值颜色
      'EdgeColor', 'none'); % 边界不显示

% 添加颜色条
colorbar;
title('有限元结果云图');
xlabel('X 方向');
ylabel('Y 方向');
axis equal;
grid on;

% 完成
hold off;



end