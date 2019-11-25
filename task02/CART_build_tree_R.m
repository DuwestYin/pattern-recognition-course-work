function tree_R = CART_build_tree_R(samples, y, attr_state, discrete_dim, samples_T)
%函数功能：构建CART回归树

%函数输入参数：
% sammples      不带标签的训练样本
% labels        样本的标签
% attr_state    特征的有效标志
% discrete_dim  样本特征离散维度
% samples_T     样本的数量阈值
% gini_T        基尼系数阈值

%函数输出值：
%构建好的CART回归树

[N, M] = size(samples);           %样本数量 特征数量

if (N == 0)                    %样本为空返回
    tree_R = [];
    return;
end

%样本太少了或者没有特征了返回
if (N <= samples_T) || (sum(attr_state) == 0)    
    tree_R.child = [];
    tree_R.value = mean(y);      %标签为最多的那个
    tree_R.attribute = [];
    tree_R.split_left = [];
    tree_R.split_rignt = [];
    return;
end

%计算每个标签的基尼系数,注意只构建二叉树，离散的情况
var_M = zeros(M,1); 
cut_point_index = zeros(M,1);     %针对离散特征
op_split_point = zeros(M,1);      %只对连续特征有效
for i = 1:M
    if attr_state(i) == 0
        var_M(i) = inf;
        continue;
    end
    %特征值连续的情况
    if discrete_dim(i) == 0
        [var_M(i), op_split_point(i)] = CART_split2_R(samples(:,i), y);
    else
        %离散的情况
        uq_attribute = unique(samples(:, i));  %标签的取值
        for j = 1:length(uq_attribute)   %每一个取值方差和
            a = samples(:, i) == uq_attribute(j);  %分成两部分
            b = samples(:, i) ~= uq_attribute(j);
            y_a = y(a);
            y_b = y(b);
            var_a(j) = var(y_a) + var(y_b);
        end
         [var_M(i), cut_point_index(i)] = min(var_a);  %最小值最为整个特征的方差和
    end
end

[~, var_min_index] = min(var_M);  
op_attribute = var_min_index;           %最优的特征

%特征值离散的情况
if discrete_dim(op_attribute) ~= 0
    uq_attribute = unique(samples(:, op_attribute));
    op_attribute_v = uq_attribute(cut_point_index(op_attribute));  %最优特征的分割值
    sub_a_idx = samples(:, op_attribute) == op_attribute_v;  %左子树的下表索引
    sub_b_idx = samples(:, op_attribute) ~= op_attribute_v;
    sub_a = samples(sub_a_idx,:);       %左子树的样本
    sub_a_y = y(sub_a_idx);   %左子树标签
    sub_b = samples(sub_b_idx,:);
    sub_b_y = y(sub_b_idx);

    attr_state_a = attr_state;
    attr_state_b = attr_state;
    attr_state_a(op_attribute) = 0;  %左子树不需要再考虑这个特征

    if length(uq_attribute) == 2     %如果本来只有两个特征，在右子树中也没必要考虑这个特征了
        attr_state_b(op_attribute) = 0;
    end

    tree_R.attribute = op_attribute;        %最分割优特征
    tree_R.split_left = op_attribute_v;     %左子树的值
    tree_R.split_right = uq_attribute(uq_attribute ~= op_attribute_v);  %右子树的值
else
    %如果特征值连续
    sub_a_idx = samples(:, op_attribute) <= op_split_point(op_attribute);  %左子树的下表索引
    sub_b_idx = samples(:, op_attribute) > op_split_point(op_attribute);
    sub_a = samples(sub_a_idx,:);       %左子树的样本
    sub_a_y = y(sub_a_idx);   %左子树标签
    sub_b = samples(sub_b_idx,:);
    sub_b_y = y(sub_b_idx);
    attr_state_a = attr_state;   %连续特征一直可以考虑
    attr_state_b = attr_state;
   
    tree_R.attribute = op_attribute;        %最分割优特征
    tree_R.split_left = op_split_point(op_attribute);     %左右都是分割值
    tree_R.split_right = tree_R.split_left;                
end
tree_R.value = [];
tree_R.child_left = CART_build_tree_R(sub_a, sub_a_y, attr_state_a, discrete_dim, samples_T); %递归构建
tree_R.child_right = CART_build_tree_R(sub_b, sub_b_y, attr_state_b, discrete_dim, samples_T);





end
