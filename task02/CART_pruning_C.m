function best_tree = CART_pruning_C(tree, cv_samples, cv_labels)
% 函数功能：分类树剪枝
% 函数输入参数: 
% tree: 训练好的未剪枝的分类树
% cv_samples: 验证集样本
% cv_labels: 验证集标签
% 函数输出值: 剪枝好的最优子树

Ts = cut_ntimes(tree);      %生成一系列对不同alpha的最优子树
N = length(Ts);
n = length(cv_labels);
for i = 1:N                 %计算每棵子树的验证集正确率
    for j = 1:n
        result1(j) = CART_predict_C(Ts{i}, cv_samples(j, :));
    end
    correct_ratios(i) = sum(result1' == cv_labels) / n;
end
[~, k] = max(correct_ratios);    %选择正确率最高的那颗子树作为整体最优的树
best_tree = Ts{k};
end



