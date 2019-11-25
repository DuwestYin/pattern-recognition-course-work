function Gini = Gini_fun(labels)
% 函数功能: 计算基尼指数
% 函数输入参数: 
% labels: 数据数组
% 函数输出值: 数据的基尼指数

N = length(labels);   %如果数据为空，将基尼指数设置为1
if N == 0
    Gini = 1;
    return;
end
uq_labels = unique(labels);            %不同的标签类别

for i = 1:length(uq_labels)           %找到每个标签的样本数
    uq_labels_n(i) = sum(labels == uq_labels(i));
end

%计算样本的基尼系数
temp = 0;
for i = 1:length(uq_labels)
    temp = temp + (uq_labels_n(i)/N)^2; 
end

Gini = 1- temp;

end