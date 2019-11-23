function T = cut_once(T, alpha_min)   %剪掉alpha最下那个节点
if ~isempty(T.class)  %叶子节点
    return;
end
if T.alpha == alpha_min
    T.child_left = [];
    T.child_right = [];
    T.split_left = [];
    T.split_right = [];
    T.attribute = [];
    T.alpha = inf;
    
    uq_labels = unique(T.labels);
    for i = 1:length(uq_labels)         %找到每个标签的样本数
        uq_labels_n(i) = sum(T.labels == uq_labels(i));
    end
     [~, index] = max(uq_labels_n);         %样本最多的那个标签的下标
     T.class = uq_labels(index);            %标签为最多的那个
     return;
else
     T.child_left = cut_once(T.child_left, alpha_min);
     T.child_right = cut_once(T.child_right, alpha_min);
   
end


end