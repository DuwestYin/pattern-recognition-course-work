function [T, alphas] = get_alhpas(T)   %计算一棵树每个节点的alpha
persistent alpha;
if ~isempty(T.class)
    T.alpha = inf;    %叶子节点
    return;
end
k = length(alpha);
k = k + 1;
aaa = get_gt(T);
alpha(k) = aaa;
T.alpha = aaa;
if ~isempty(T.child_left)
   [T.child_left] = get_alhpas(T.child_left); 
end
if ~isempty(T.child_right)
   [T.child_right] = get_alhpas(T.child_right); 
end

alphas = alpha;
end