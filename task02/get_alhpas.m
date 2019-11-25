function [T, alphas] = get_alhpas(T)   
% 函数功能: 计算一棵树每个节点的alpha值
% 函数输入参数: 
% T: 一棵分类树
% 函数输出值:
% T: 求得每个节点alpha值的树
% alphas: 树的每个节点的alpha值数组


persistent alpha;
if ~isempty(T.class) 
    T.alpha = inf;     %叶子节点的alpha设为无穷大
    return;
end
k = length(alpha);
k = k + 1;
aaa = get_gt(T);       %求该节点的alpha值
alpha(k) = aaa;        %保存到数组
T.alpha = aaa;
if ~isempty(T.child_left) 
   [T.child_left] = get_alhpas(T.child_left);   %递归进行
end
if ~isempty(T.child_right)
   [T.child_right] = get_alhpas(T.child_right); 
end

alphas = alpha;
end