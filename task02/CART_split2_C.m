function [Gini_min, op_point] = CART_split2_C(attr, labels)
% 函数功能:分类树选择属性的最佳分割点
% 函数输入参数:
% attr: 样本的某个属性的全体值
% labels: 属性值对应的类别标签
% 函数输出值:
% Gini_min: 最佳分割点对应的基尼指数
% op_point: 最佳分割点的下标

n = length(attr);    %特征数组长度
for i = 1:n-1              %对特征值冒泡排序，类别标签也应改变
    for j = 1:(n-i)
        if attr(j) > attr(j+1)
            exchange = attr(j);
            attr(j) = attr(j+1);
            attr(j+1) = exchange;
            exchange = labels(j);
            labels(j) = labels(j+1);
            labels(j+1) = exchange;
        end
    end
end

cut_vals = zeros(n-1,1);   %存储一系列分割点的值
for i = 1:n-1
    cut_vals(i) = (attr(i)+attr(i+1))/2;
end

for i = 1:n-1
    attr_idx_a = (attr <= cut_vals(i));  %划分为两半
    attr_idx_b = (attr > cut_vals(i));
    labels_a = labels(attr_idx_a);
    labels_b = labels(attr_idx_b);
    Gini_a = Gini_fun(labels_a);         %求基尼指数
    Gini_b = Gini_fun(labels_b);
    Gini_N(i) = (length(labels_a)/n)*Gini_a + (length(labels_b)/n)*Gini_b;
end
[Gini_min, op_point_idx] = min(Gini_N);  %选择基尼指数最小的分割点
op_point = cut_vals(op_point_idx);

end