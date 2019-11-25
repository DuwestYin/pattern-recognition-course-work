function leaf_labels = leaf_cnt(Tt) 
% 函数功能: 找到子树t的每个叶子节点的类别标签
persistent leaf_n;
if ~isempty(Tt.class) && (Tt.class ~= inf)   %判断为叶子节点
    k = length(leaf_n);
    k = k + 1;
    leaf_n{k} = Tt.labels;    %将类别标签存入数组
    return;
end
leaf_cnt(Tt.child_left);      %递归进行
leaf_cnt(Tt.child_right);
leaf_labels = leaf_n;
end
