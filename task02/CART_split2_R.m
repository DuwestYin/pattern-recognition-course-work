function [var_min, op_cut_val] = CART_split2_R(x,y)
% 函数功能:回归树选择属性的最佳分割点
% 函数输入参数:
% x: 样本的某个属性的全体值
% y: 属性值对应的取值
% 函数输出值:
% var_min: 最佳分割点对应的最小方差
% op_cut_val: 最佳分割点的下标
%回归问题特征连续情况的分割点

n = length(x);
cut_points = zeros(n-1,1);       %存储一系列分割点的值
for i = 1:n-1
    cut_points(i) = (x(i) + x(i+1))/2;
end
op_val = zeros(n-1, 1);
for i = 1:n-1
    idx1 = (x <= cut_points(i));   %划分为两半
    idx2 = (x > cut_points(i));
    sub1 = y(idx1);
    sub2 = y(idx2);
    op_val(i) =  var(sub1) + var(sub2);  %求方差
end
[var_min, var_min_idx] = min(op_val);    %选择方差最小的分割点
op_cut_val = cut_points(var_min_idx);

end