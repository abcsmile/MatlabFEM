%定义有限元模型
%全局变量
% gNode--节点坐标
% gElememt--单元
% gMaterial--材料性质
% gBC--约束
% gDF--节点力

a = 2; % 边长
t = 0.01; % 厚度
m = 5; % 每条边上的节点数
F = -2000; % 集中荷载
q = -1000; % 均布荷载

gMaterial = [200 0.3];
[gNode,gElement,gBC,gDF] = mesh_triangle(a,m,F,q,t);


%求解有限元模型
% 刚度矩阵
KK = zeros(2*m*m,2*m*m);
for i = 1:size(gElement,1)
    k = Triangle2D3Node_Stiffness(gMaterial(1), gMaterial(2), t, gNode(gElement(i,1),1), gNode(gElement(i,1),2), gNode(gElement(i,2),1), gNode(gElement(i,2),2), gNode(gElement(i,3),1), gNode(gElement(i,3),2), 1);
    KK = Triangle2D3Node_Assembly(KK, k, gElement(i,1), gElement(i,2), gElement(i,3));

end
K = KK; % 原始的总刚

% 处理边界条件
% 使用乘大数法
bignum = abs(max(KK(:)))*1e4;
for i = 1:size(gBC,1)
    KK(gBC(i,2),gBC(i,2)) = bignum*KK(gBC(i,2),gBC(i,2));
    gDF(gBC(i,2),1) = bignum*KK(gBC(i,2),gBC(i,2))*gBC(i,3);

end


% 求解位移
u = KK\gDF;
ux = u(1:2:49);
ux = reshape(ux,5,5);
ux = ux';
uy = u(2:2:50);
uy = reshape(uy,5,5);
uy = uy';


x = linspace(0,a,5);
y = linspace(0,a,5);


pcolor(x,y,uy);
shading interp


% 计算节点应力
% ElementStress  = zeros(size(gNode,1),1);
% for i = 1:size(gElement,1)
%     qe = [u(2*gElement(1)-1:2*gElement(1));u(2*gElement(2)-1:2*gElement(2));u(2*gElement(3)-1:2*gElement(3))];
%     for j = 1:3
%         stress = Triangle2D3Node_Stress(gMaterial(1), gMaterial(2), gNode(gElement(i,1),1), gNode(gElement(i,1),2), gNode(gElement(i,2),1), gNode(gElement(i,2),2), gNode(gElement(i,3),1), gNode(gElement(i,3),2), qe, 1);
%         ElementStress(gElement(i,j)) = sqrt(sum(stress.^2));
% 
%     end
% 
% end




% 绘制应力云图
% function DrawStress(ElementStress,a)
%     st = reshape(ElementStress,5,5);
%     st = st';
% 
%     x = linspace(0,a,5);
%     y = linspace(0,a,5);
%     x1 = linspace(0,a,100);
%     y1 = linspace(0,a,100);
% 
%     [X,Y,St] = griddata(x,y,st,x1,y1,'v4');
% 
%     pcolor(x,y,st);
%     shading interp
% 
% 
% end