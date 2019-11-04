function tree_C = CART_build_tree_C(samples, labels, attr_state, discrete_dim, samples_T, gini_T)
%构建CART分类树
%sammples    不带标签的训练样本
%labels      样本的标签
%attr_state  特征的有效标志
%samples_T   样本的阈值数量
%gini_T      基尼系数阈值
[N, M] = size(samples);           %样本数量 特征数量

if (N == 0)                 %样本为空返回
    tree_C = [];
    return;
end

uq_labels = unique(labels);
for i = 1:length(uq_labels)         %找到每个标签的样本数
    uq_labels_n(i) = sum(labels == uq_labels(i));
end

Gini = Gini_fun(labels);   %计算基尼系数

%样本太少了或者基尼系数太小了或者没有特征了返回
if (N <= samples_T) || (Gini <= gini_T) || (sum(attr_state) == 0)    
    [~, index] = max(uq_labels_n);         %样本最多的那个标签的下标
    tree_C.child = [];
    tree_C.class = uq_labels(index);       %标签为最多的那个
    tree_C.attribute = [];
    tree_C.split_left = [];
    tree_C.split_rignt = [];
    return;
end

%计算每个标签的基尼系数,注意只构建二叉树，离散的情况
Gini_M = zeros(M,1); 
cut_point_index = 0;
op_split_point = zeros(M,1);
for i = 1:M
    if attr_state(i) == 0
        Gini_M(i) = 1;
        continue;
    end
    %特征值连续的情况
    if discrete_dim(i) == 0
        [Gini_M(i), op_split_point(i)] = CART_split_2(samples(:,i),labels);
    else
        uq_attribute = unique(samples(:, i));  %标签的取值
        for j = 1:length(uq_attribute)   %每一个取值的基尼系数
            a = samples(:, i) == uq_attribute(j);  %分成两部分
            b = samples(:, i) ~= uq_attribute(j);
            labels_a = labels(a);
            labels_b = labels(b);
            tempa = Gini_fun(labels_a);   %每部分的基尼系数
            tempb = Gini_fun(labels_b);
            %以该点划分的基尼系数
            Gini_a(j) = (length(labels_a)/N)*tempa + (length(labels_b)/N)*tempb;
        end
         [Gini_M(i), cut_point_index(i)] = min(Gini_a);  %最小值最为整个特征的基尼系数
    end
end

[~, Gini_min_index] = min(Gini_M);  
op_attribute = Gini_min_index;           %最优的特征

%特征值离散的情况
if discrete_dim(op_attribute) ~= 0
    uq_attribute = unique(samples(:, op_attribute));
    op_attribute_v = uq_attribute(cut_point_index(op_attribute));  %最优特征的分割值
    sub_a_idx = samples(:, op_attribute) == op_attribute_v;  %左子树的下表索引
    sub_b_idx = samples(:, op_attribute) ~= op_attribute_v;
    sub_a = samples(sub_a_idx,:);       %左子树的样本
    sub_a_labels = labels(sub_a_idx);   %左子树标签
    sub_b = samples(sub_b_idx,:);
    sub_b_labels = labels(sub_b_idx);

    attr_state_a = attr_state;
    attr_state_b = attr_state;
    attr_state_a(op_attribute) = 0;  %左子树不需要再考虑这个特征

    if length(uq_attribute) == 2     %如果本来只有两个特征，在右子树中也没必要考虑这个特征了
        attr_state_b(op_attribute) = 0;
    end

    tree_C.attribute = op_attribute;        %最分割优特征
    tree_C.split_left = op_attribute_v;     %左子树的值
    tree_C.split_right = uq_attribute(uq_attribute ~= op_attribute_v);  %右子树的值
else
    %如果特征值连续
    sub_a_idx = samples(:, op_attribute) <= op_split_point(op_attribute);  %左子树的下表索引
    sub_b_idx = samples(:, op_attribute) > op_split_point(op_attribute);
    sub_a = samples(sub_a_idx,:);       %左子树的样本
    sub_a_labels = labels(sub_a_idx);   %左子树标签
    sub_b = samples(sub_b_idx,:);
    sub_b_labels = labels(sub_b_idx);
    attr_state_a = attr_state;
    attr_state_b = attr_state;
    attr_state_a(op_attribute) = 0;  %左右子树都不需要再考虑这个特征
    attr_state_b(op_attribute) = 0;
    
    tree_C.attribute = op_attribute;        %最分割优特征
    tree_C.split_left = op_split_point(op_attribute);     %左右都是分割值
    tree_C.split_right = tree_C.split_left;                
end
tree_C.class = [];
tree_C.child_left = CART_build_tree_C(sub_a, sub_a_labels, attr_state_a, discrete_dim, samples_T, gini_T); %递归构建
tree_C.child_right = CART_build_tree_C(sub_b, sub_b_labels, attr_state_b, discrete_dim, samples_T, gini_T);















    
end
