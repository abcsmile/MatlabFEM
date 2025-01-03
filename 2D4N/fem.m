tic
% gMaterial = [];  %杨氏模量，泊松比,厚度
% gNode = [];
% gElement = [];
% gBC = [];  % 边界
% gDF = [];  % 力

% load("hole_2d.mat");  % 板挖孔问题
% load("tiaojian.mat");
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
    n1 = gElement(i,1);
    n2 = gElement(i,2);
    n3 = gElement(i,3);
    n4 = gElement(i,4);
    
    % 节点坐标
    x1 = gNode(n1,2);
    y1 = gNode(n1,3);
    x2 = gNode(n2,2);
    y2 = gNode(n2,3);
    x3 = gNode(n3,2);
    y3 = gNode(n3,3);
    x4 = gNode(n4,2);
    y4 = gNode(n4,3);

    % testJ(x1,y1,x2,y2,x3,y3,x4,y4);

    % k = Quad2D4Node_Stiffness(E,Nu,h,x1,y1,x2,y2,x3,y3,x4,y4,1);
    k = ByMyself_Stiffness(E,Nu,h,x1,y1,x2,y2,x3,y3,x4,y4,1);
    KK = Quad2D4Node_Assembly(KK,k,n1,n2,n3,n4);

    

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

% % 求解单元应力
% StressElem = zeros(numelements,4,4);  % 单元节点应力
% for i = 1:numelements
%     % 单元节点编号
%     n1 = gElement(i,1);
%     n2 = gElement(i,2);
%     n3 = gElement(i,3);
%     n4 = gElement(i,4);
%     n = [n1 n2 n3 n4];
% 
%     % 节点坐标
%     x1 = gNode(n1,2);
%     y1 = gNode(n1,3);
%     x2 = gNode(n2,2);
%     y2 = gNode(n2,3);
%     x3 = gNode(n3,2);
%     y3 = gNode(n3,3);
%     x4 = gNode(n4,2);
%     y4 = gNode(n4,3);
% 
%     u0 = [u(2*n1-1) u(2*n1) u(2*n2-1) u(2*n2) u(2*n3-1) u(2*n3) u(2*n4-1) u(2*n4)]';
%     stress = Quad2D4Node_Stress(E,Nu,x1,y1,x2,y2,x3,y3,x4,y4,n,u0,1);
%     StressElem(i,1,:) = stress(1,:);
%     StressElem(i,2,:) = stress(2,:);
%     StressElem(i,3,:) = stress(3,:);
%     StressElem(i,4,:) = stress(4,:);
% 
% end
% 
% % 求解节点应力-周边单元应力取平均
% StresNode = zeros(numNode,3);
% numRepeedNode = zeros(numNode,1);
% for i = 1:numelements
%     % 计数周边单元数
%     n1 = gElement(i,1);
%     n2 = gElement(i,2);
%     n3 = gElement(i,3);
%     n4 = gElement(i,4);
%     numRepeedNode(n1) = numRepeedNode(n1) + 1;
%     numRepeedNode(n2) = numRepeedNode(n2) + 1;
%     numRepeedNode(n3) = numRepeedNode(n3) + 1;
%     numRepeedNode(n4) = numRepeedNode(n4) + 1;
% 
%     % 求和周边单元应力
%     for j = 1:4
%         n = StressElem(i,j,1);
%         str = zeros(1,3);
%         str(1) = StressElem(i,j,2);
%         str(2) = StressElem(i,j,3);
%         str(3) = StressElem(i,j,4);
%         StresNode(n,:) = StresNode(n,:) + str;
% 
%     end
% 
% 
% end
% StresNode = StresNode./numRepeedNode;


% %求解单元应力
% StressElem=zeros(numelements,3);
% for i=1:numelements
%      % 单元节点编号
%     n1 = gElement(i,1);
%     n2 = gElement(i,2);
%     n3 = gElement(i,3);
%     n4 = gElement(i,4);
%     n = [n1 n2 n3 n4];
% 
%     % 节点坐标
%     x1 = gNode(n1,2);
%     y1 = gNode(n1,3);
%     x2 = gNode(n2,2);
%     y2 = gNode(n2,3);
%     x3 = gNode(n3,2);
%     y3 = gNode(n3,3);
%     x4 = gNode(n4,2);
%     y4 = gNode(n4,3);
%  % 求单元应力
% 	stresstemp = Quad2D4Node_Stress(E,Nu,x1,y1,x2,y2,x3,y3,x4,y4,n,u0,1);
%  	StressElem(i,1)=stresstemp(1);
%  	StressElem(i,2)=stresstemp(2);
%  	StressElem(i,3)=stresstemp(3);
% end
% % 求节点应力－计算节点周边所有单元应力的平均值
% StressNode=zeros(numNode,3);
% for i=1:numNode
%  	numElem=0;
%  	for j=1:numelements
%  		if (gElement(j,1)==i)
%  			StressNode(i,1)=StressNode(i,1)+StressElem(j,1);
%  			StressNode(i,2)=StressNode(i,2)+StressElem(j,2);
%  			StressNode(i,3)=StressNode(i,3)+StressElem(j,3);
%  			numElem=numElem+1;
%  		elseif (gElement(j,2)==i)
%  			StressNode(i,1)=StressNode(i,1)+StressElem(j,1);
%  			StressNode(i,2)=StressNode(i,2)+StressElem(j,2);
% 			StressNode(i,3)=StressNode(i,3)+StressElem(j,3);
% 			numElem=numElem+1;
%  		elseif (gElement(j,3)==i)
% 			 StressNode(i,1)=StressNode(i,1)+StressElem(j,1);
%  			StressNode(i,2)=StressNode(i,2)+StressElem(j,2);
%  			StressNode(i,3)=StressNode(i,3)+StressElem(j,3);
%  			numElem=numElem+1;
%         elseif (gElement(j,4)==i)
% 			 StressNode(i,1)=StressNode(i,1)+StressElem(j,1);
%  			StressNode(i,2)=StressNode(i,2)+StressElem(j,2);
%  			StressNode(i,3)=StressNode(i,3)+StressElem(j,3);
%  			numElem=numElem+1;
%  		end
%  	end
%  	StressNode(i,1)=StressNode(i,1)/numElem;
%  	StressNode(i,2)=StressNode(i,2)/numElem;
%  	StressNode(i,3)=StressNode(i,3)/numElem;
% end

% datax = [gNode(:,2:3) StresNode(:,1)];
% datay = [gNode(:,2:3) StresNode(:,2)];
% s = sqrt(3.*(StresNode(:,3)).^2+StresNode(:,1).^2+StresNode(:,2).^2-StresNode(:,1).*StresNode(:,2));

draw1(gNode(:,2:3),u(2:2:2*numNode),gElement);
draw1(gNode(:,2:3),u(1:2:2*numNode-1),gElement);
% draw1(gNode(:,2:3),s,gElement);


u = -100*x^2*y/(2*E*I)-Nu*100*y^3/(6*E*I)+100*y^3/(6*G*I)-(100*0.8^2/(8*G*I)-100*6^2/(2*E*I))*y;
v = Nu*100*x*y^2/(2*E*I)+100*x^3/(6*E*I)-100*6^2*x/(2*E*I)+100*6^3/(3*E*I);

toc