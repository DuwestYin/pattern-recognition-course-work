clear;clc;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     CART回归树曲线拟合测试           
% 1. 生成一个曲线函数
% 2. 在曲线函数上采样得到训练样本 
% 2. 训练回归模型
% 4. 用新的自变量验证模型是否能拟合数据
% 5. 作图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('正在生成训练数据……\n')
x = -50:1:50;        %曲线自变量区间
x = x';
y = (x).^3 -5;       %构造曲线 
x2 = -20:0.1:20;     %用于测试的自变量
x3 = -20:1:20;
y2 = (x2).^3 -5;     %测试的参考曲线
y4 = (x3).^3 -5; 
fprintf('正在初始化训练参数……\n')
attr_state = 1;   %初始化训练参数
discrete_dim = 0;
samples_T = 2;
fprintf('正在训练回归树……\n')
tree = CART_build_tree_R(x, y, attr_state, discrete_dim, samples_T);  %训练CART回归树
fprintf('回归树训练完成！\n')
fprintf('正在验证结果……\n')
for i = 1:length(x2);
    y3(i) = CART_predict_R(tree,x2(i));   %测试预测结果值
end

%作图
% plot(x2,y2,'k--')
hold on;  
plot(x2,y3,'r')
plot(x3,y4,'.')
xlabel('x');
ylabel('y');
title('CART回归树曲线拟合');
legend('CART算法拟合的曲线','真实曲线');