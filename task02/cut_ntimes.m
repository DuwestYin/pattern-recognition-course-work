function best_trees = cut_ntimes(T)
% 函数功能: 对一棵分类树进行剪枝，生成一系列子树
% 函数输入参数:
% T: 训练好的未剪枝的分类树
% 函数输出值: 一系列对于不同alpha的最优子树
k = 0;
while true
    if ~isempty(T.child_left.class) && ~isempty(T.child_right.class)  %一个根节点两个叶子节点
       break;
    end
    clear get_alhpas;
    [T, alphas] = get_alhpas(T);   %得到树的所有节点的alpha值
    alpha_min = min(alphas);       
    T2 = cut_once(T, alpha_min);   %选择alpha值最小的那个节点剪掉
    k = k + 1;
    fprintf('第%d棵子树\n',k);
    best_trees{k} = T2;            %将子树存储到元胞数组中
    T = T2;                        %迭代进行
end

end