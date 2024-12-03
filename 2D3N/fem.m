% gMaterial = [];  %杨氏模量，泊松比,厚度
% gNode = [];
% gElement = [];
% gBC = [];
% gDF = [];


% 建立总体刚度矩阵
E = gMaterial(1);
Nu = gMaterial(2);
h = gMaterial(3);
numNode = size(gNode,1);
numelements = size(gElement,1);
KK = zeros(2*numNode, 2*numNode);
for i = 1:numelements
    % 单元节点编号
    n1 = gElement(i,1);
    n2 = gElement(i,2);
    n3 = gElement(i,3);
    
    % 节点坐标
    x1 = gNode(n1,1);
    y1 = gNode(n1,2);
    x2 = gNode(n2,1);
    y2 = gNode(n2,2);
    x3 = gNode(n3,1);
    y3 = gNode(n3,2);

    k = Triangle2D3Node_Stiffness(E,Nu,h,x1,y1,x2,y2,x3,y3,1);
    KK = Triangle2D3Node_Assembly(KK,k,n1,n2,n3);

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

% 求解单元应力
% 常应力单元
StressElem = zeros(numelements,3);  % 单元节点应力
for i = 1:numelements
    % 单元节点编号
    n1 = gElement(i,1);
    n2 = gElement(i,2);
    n3 = gElement(i,3);
    
    % 节点坐标
    x1 = gNode(n1,1);
    y1 = gNode(n1,2);
    x2 = gNode(n2,1);
    y2 = gNode(n2,2);
    x3 = gNode(n3,1);
    y3 = gNode(n3,2);

    u0 = [u(2*n1-1) u(2*n1) u(2*n2-1) u(2*n2) u(2*n3-1) u(2*n3)]';
    stress = Triangle2D3Node_Stress(E,Nu,x1,y1,x2,y2,x3,y3,u0,1);
    StressElem(i,:) = stress;

end

% 求解节点应力-周边单元应力取平均
StresNode = zeros(numNode,3);
numRepeedNode = zeros(numNode,1);
for i = 1:numelements
    % 计数周边单元数
    n1 = gElement(i,1);
    n2 = gElement(i,2);
    n3 = gElement(i,3);
    numRepeedNode(n1) = numRepeedNode(n1) + 1;
    numRepeedNode(n2) = numRepeedNode(n2) + 1;
    numRepeedNode(n3) = numRepeedNode(n3) + 1;

    % 求和周边单元应力
    StresNode(n1,:) = StresNode(n1,:) + StressElem(i,:);
    StresNode(n2,:) = StresNode(n2,:) + StressElem(i,:);
    StresNode(n3,:) = StresNode(n3,:) + StressElem(i,:);




end
StresNode = StresNode./numRepeedNode;

datax = [gNode StresNode(:,1)];
datay = [gNode StresNode(:,2)];
draw(datax);




