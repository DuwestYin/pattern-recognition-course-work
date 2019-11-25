function T = cut_once(T, alpha_min)   
% 函数功能：剪掉alpha最小的那个节点
% 函数输入参数: 
% T: 需要剪枝的树
% alpha_min: 最小的alpha值
% 函数输出值: 剪掉一个节点的树

if ~isempty(T.class)    %叶子节点
    return;
end
if T.alpha == alpha_min   %找到最小的alpha值节点，进行剪枝
    T.child_left = [];
    T.child_right = [];
    T.split_left = [];
    T.split_right = [];
    T.attribute = [];
    T.alpha = inf;
    
    uq_labels = unique(T.labels);
    for i = 1:length(uq_labels)             %找到每个标签的样本数
        uq_labels_n(i) = sum(T.labels == uq_labels(i));
    end
     [~, index] = max(uq_labels_n);         %样本最多的那个标签的下标
     T.class = uq_labels(index);            %标签为最多的那个
     return;
else
     T.child_left = cut_once(T.child_left, alpha_min);  %递归进行
     T.child_right = cut_once(T.child_right, alpha_min);
   
end


end