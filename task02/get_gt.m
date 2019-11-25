function gt = get_gt(Tt)  
% 函数功能: 计算树的节点t的损失函数
% 函数输入参数: 
% Tt: 以节点t为根节点的子树
% 函数输出值: 节点t的损失函数

Ct = Gini_fun(Tt.labels);      %该节点t的基尼指数
clear leaf_cnt;
leaf_labels = leaf_cnt(Tt);    %求子树t的叶子节点的类别标签
CTt = 0;
for i = 1:length(leaf_labels)  %计算所有叶子节点的基尼指数
    Ni = length(leaf_labels{i});
    Gi = Gini_fun(leaf_labels{i});
    CTt = CTt + Ni*Gi/length(Tt.labels);
end
gt = (Ct - CTt)/(length(leaf_labels) - 1); %计算损失函数

end


function leaf_labels = leaf_cnt(Tt) 
%计算子树t的叶子节点的类别标签
persistent leaf_n;
if ~isempty(Tt.class) && (Tt.class ~= inf)
    k = length(leaf_n);
    k = k + 1;
    leaf_n{k} = Tt.labels;
    return;
end
leaf_cnt(Tt.child_left);
leaf_cnt(Tt.child_right);
leaf_labels = leaf_n;
end
