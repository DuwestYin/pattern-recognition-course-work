function tree = build_tree_45(samples, labels, discrete_dim)
%samples: 训练样本集
%labels:  样本标签集
%discrete_dim: 样本每个特征的离散值维度，0代表连续特征
%先不考虑剪枝
%函数的返回条件可能还需要完善
if isempty(samples)
    return
end
[N, FN] = size(samples);           %样本数和特征数
unique_label = unique(labels);     %样本类别标签 [A, B, C]
% tree.dim = [];          %最大增益率属性对应的位置
% tree.split_val = [];    %最大增益率属性对应的分割值（如果连续）
% tree.Nf = [];           %最大增益率属性对应的类别值
% tree.child = [];        %如果为叶子节点则child为类别标签值，否者为递归函数

 %样本都属于同一类别,所有样本特征集为空（还差一种样本特征只有一个属性值）
if (length(unique_label) == 1)  
   labels_num = hist(labels, length(unique_label));   %统计每个类别的数量
   [~, ind] = max(labels_num); %找到最大值和对应的下标
   tree.Nf = [];          %叶子节点没有属性类别
   tree.split_val = [];   %叶子节点没有属性分割值
   tree.dim = [];         %叶子节点没有最大增益率属性对应的位置
   tree.child = unique_label(ind);  %就是这个唯一类别
   return
end

if FN == 1               %只有一列特征的情况
    if discrete_dim == 0   %特征连续情况 
        [~, split_v] = split2new(samples,labels);
        for j = 1:2
            if j == 1
                n = find(samples <= split_v);
            else
                n = find(samples > split_v);
            end
                label1 = labels(n);
                uq = unique(label1);
                Ln = hist(label1, length(uq));
                [~,max1] = max1(Ln);
                tree.child(j).Nf = [];          %叶子节点没有属性类别
                tree.child(j).split_val = [];   %叶子节点没有属性分割值
                tree.child(j).dim = [];         %叶子节点没有最大增益率属性对应的位置
                tree.child(j).child = uq(max1);  %就是这个唯一类别
        end
    else
        %没有考虑离散情况
    end

end

labelsN = zeros(length(unique_label), 1);  %每个类别标签样本数量
for i = 1:length(unique_label)
    labelsN(i) = length(find(labels == unique_label(i)));   
end
Ent = -sum((labelsN/N).*log2(labelsN/N));  %当前节点信息熵

gain_ratios = zeros(FN ,1);   %每个特征的增益率
split_val = ones(FN, 1)*inf;  %每个特征的分割点， 离散特征为inf

for i = 1:FN
    data = samples(:,i);  %取一个特征列,列向量
    unique_data = unique(data);     %保留特征不同属性
    udata_N = length(unique_data);  %特征的不同属性个数
    if discrete_dim(i)              %离散属性
        P = zeros(length(unique_label), udata_N);  %每个属性值的样本有不同的标签
        for j = 1:length(unique_label)  %遍历每一个类别标签
            for k =1:udata_N          %遍历每一个不同特征
                indices = (labels == unique_label(j)) & (samples(:,i) == unique_data(k));
                P(j,k) = sum(indices);
            end
        end
        
        Pk = sum(P);   %每个特征值的样本数,行向量，长度为udata_N
        Ents = zeros(udata_N,1); %每个特征值对应的信息熵
        for  j = 1:length(Pk)
            if Pk(j) == 0
                Ents(j) = 0;
            else
                temp1 = zeros(length(unique_label), 1);
                for u = 1:length(temp1)
                    if P(u,j) == 0
                        temp1(u) = 0;
                    else
                        temp1(u) = -(P(u,j)/Pk(j))*log2(P(u,j)/Pk(j));
                    end
                end
                Ents(j) = sum(temp1);
            end
        end
        NP = sum(Pk);   %样本数 N
        gain =  Ent - sum((Pk/NP).*(Ents'));
        IV = zeros(FN,1); 
        for j = 1:FN
            if Pk(j) == 0;
                IV(j) = 0;
            else
                IV(j) = -(Pk(j)/NP)*log2(Pk(j)/NP);
            end
        end
        IV = sum(IV);
        gain_ratios(i) = gain/IV;
    else  %考虑特征值连续的情况
        [split_val(i), gain_ratios(i)] = split2new(data,labels);
    end
end

[~, dim] = max(gain_ratios); %找到最大增益率特征对应的下标
if length(dim) > 1
    dim = dim(1);
end
dims = 1:FN;
dims = find(dims ~= dim);    %去掉这个特征
tree.dim = dim;
Nf = unique(samples(:,dim)); %最大增益率特征对应的属性（特征值）
Nf_n = length(Nf);           %属性的个数
tree.Nf = Nf;
tree.split_val = split_val(dim); 

if Nf_n == 1  %如果所有样本在这个属性的值一样,第三种叶子节点情况
   labels_num = hist(labels, length(unique_label));   %统计每个类别的数量
   [~, ind] = max(labels_num);  %找到最大值和对应的下标
   tree.Nf = [];          %叶子节点没有属性类别
   tree.split_val = [];   %叶子节点没有属性分割值
   tree.dim = [];         %叶子节点没有最大增益率属性对应的位置
   tree.child = unique_label(ind);  %就是这个唯一类别
   return
end

if discrete_dim(dim)   %特征为离散特征
    for i = 1:Nf_n     %遍历每个特征值
        indices = find(samples(:,dim) == Nf(i));   %找到属于该特征值的样本
        tree.child(i) = build_tree_45(samples(indices,dims), labels(indices), discrete_dim(dims));
    end
else   %特征为连续值
      indices1 = find(samples(:,dim) <= split_val(dim));
      indices2 = find(samples(:,dim) > split_val(dim));
    if ~(isempty(indices1) || isempty(indices2))   %分割点两边子集都不为空
        tree.child(1) = build_tree_45(samples(indices1,dims), labels(indices1), discrete_dim(dims));
        tree.child(2) = build_tree_45(samples(indices2,dims), labels(indices2), discrete_dim(dims));
    else  %如果所有样本在这个属性的值一样,第三种叶子节点情况
        labels_num = hist(labels, length(unique_label));   %统计每个类别的数量
        [~, ind] = max(labels_num);  %找到最大值和对应的下标
        tree.Nf = [];          %叶子节点没有属性类别
        tree.split_val = [];   %叶子节点没有属性分割值
        tree.dim = [];         %叶子节点没有最大增益率属性对应的位置
        tree.child = unique_label(ind);  %就是这个唯一类别
        return
    end
end

end