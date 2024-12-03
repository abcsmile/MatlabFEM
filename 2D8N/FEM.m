gMaterial = [200e6, 0.3, 0.01];  %杨氏模量，泊松比,厚度
gNode = [];
gElement = [];
gBC = [];  % 边界
gDF = [];  % 力


% 建立总体刚度矩阵
E = gMaterial(1);
Nu = gMaterial(2);
h = gMaterial(3);
gNode = sortrows(gNode, 1);
numNode = size(gNode,1);
numelements = size(gElement,1);
KK = zeros(2*numNode, 2*numNode);
for i = 1:numelements
    % 单元节点编号
    NodeIndex = gElement(i,2:end);
    
    % 节点坐标
    X = gNode(NodeIndex,2);
    Y = gNode(NodeIndex,3);

    % testJ(x1,y1,x2,y2,x3,y3,x4,y4);

    k = Quad2D8N_Stiffness(E, NU, h, X, Y, 1);
    KK = Quad2D8N_Assembly(KK, k, NodeIndex);

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