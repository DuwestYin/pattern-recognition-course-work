function leaf_labels = leaf_cnt(Tt) %计算子树t的叶子节点的个数，即叶子节点的基尼指数
persistent leaf_n;
if ~isempty(Tt.class)
    k = length(leaf_n);
    k = k + 1;
    leaf_n{k} = Tt.labels;
    return;
end
leaf_cnt(Tt.child_left);
leaf_cnt(Tt.child_right);
leaf_labels = leaf_n;
end
