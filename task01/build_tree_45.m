function tree = build_tree_45(samples, labels, discrete_dim)
%samples: ѵ��������
%labels:  ������ǩ��
%discrete_dim: ����ÿ����������ɢֵά�ȣ�0������������
%�Ȳ����Ǽ�֦
%�����ķ����������ܻ���Ҫ����
if isempty(samples)
    return
end
[N, FN] = size(samples);           %��������������
unique_label = unique(labels);     %��������ǩ [A, B, C]
% tree.dim = [];          %������������Զ�Ӧ��λ��
% tree.split_val = [];    %������������Զ�Ӧ�ķָ�ֵ�����������
% tree.Nf = [];           %������������Զ�Ӧ�����ֵ
% tree.child = [];        %���ΪҶ�ӽڵ���childΪ����ǩֵ������Ϊ�ݹ麯��

 %����������ͬһ���,��������������Ϊ�գ�����һ����������ֻ��һ������ֵ��
if (length(unique_label) == 1)  
   labels_num = hist(labels, length(unique_label));   %ͳ��ÿ����������
   [~, ind] = max(labels_num); %�ҵ����ֵ�Ͷ�Ӧ���±�
   tree.Nf = [];          %Ҷ�ӽڵ�û���������
   tree.split_val = [];   %Ҷ�ӽڵ�û�����Էָ�ֵ
   tree.dim = [];         %Ҷ�ӽڵ�û��������������Զ�Ӧ��λ��
   tree.child = unique_label(ind);  %�������Ψһ���
   return
end

if FN == 1               %ֻ��һ�����������
    if discrete_dim == 0   %����������� 
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
                tree.child(j).Nf = [];          %Ҷ�ӽڵ�û���������
                tree.child(j).split_val = [];   %Ҷ�ӽڵ�û�����Էָ�ֵ
                tree.child(j).dim = [];         %Ҷ�ӽڵ�û��������������Զ�Ӧ��λ��
                tree.child(j).child = uq(max1);  %�������Ψһ���
        end
    else
        %û�п�����ɢ���
    end

end

labelsN = zeros(length(unique_label), 1);  %ÿ������ǩ��������
for i = 1:length(unique_label)
    labelsN(i) = length(find(labels == unique_label(i)));   
end
Ent = -sum((labelsN/N).*log2(labelsN/N));  %��ǰ�ڵ���Ϣ��

gain_ratios = zeros(FN ,1);   %ÿ��������������
split_val = ones(FN, 1)*inf;  %ÿ�������ķָ�㣬 ��ɢ����Ϊinf

for i = 1:FN
    data = samples(:,i);  %ȡһ��������,������
    unique_data = unique(data);     %����������ͬ����
    udata_N = length(unique_data);  %�����Ĳ�ͬ���Ը���
    if discrete_dim(i)              %��ɢ����
        P = zeros(length(unique_label), udata_N);  %ÿ������ֵ�������в�ͬ�ı�ǩ
        for j = 1:length(unique_label)  %����ÿһ������ǩ
            for k =1:udata_N          %����ÿһ����ͬ����
                indices = (labels == unique_label(j)) & (samples(:,i) == unique_data(k));
                P(j,k) = sum(indices);
            end
        end
        
        Pk = sum(P);   %ÿ������ֵ��������,������������Ϊudata_N
        Ents = zeros(udata_N,1); %ÿ������ֵ��Ӧ����Ϣ��
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
        NP = sum(Pk);   %������ N
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
    else  %��������ֵ���������
        [split_val(i), gain_ratios(i)] = split2new(data,labels);
    end
end

[~, dim] = max(gain_ratios); %�ҵ����������������Ӧ���±�
if length(dim) > 1
    dim = dim(1);
end
dims = 1:FN;
dims = find(dims ~= dim);    %ȥ���������
tree.dim = dim;
Nf = unique(samples(:,dim)); %���������������Ӧ�����ԣ�����ֵ��
Nf_n = length(Nf);           %���Եĸ���
tree.Nf = Nf;
tree.split_val = split_val(dim); 

if Nf_n == 1  %�������������������Ե�ֵһ��,������Ҷ�ӽڵ����
   labels_num = hist(labels, length(unique_label));   %ͳ��ÿ����������
   [~, ind] = max(labels_num);  %�ҵ����ֵ�Ͷ�Ӧ���±�
   tree.Nf = [];          %Ҷ�ӽڵ�û���������
   tree.split_val = [];   %Ҷ�ӽڵ�û�����Էָ�ֵ
   tree.dim = [];         %Ҷ�ӽڵ�û��������������Զ�Ӧ��λ��
   tree.child = unique_label(ind);  %�������Ψһ���
   return
end

if discrete_dim(dim)   %����Ϊ��ɢ����
    for i = 1:Nf_n     %����ÿ������ֵ
        indices = find(samples(:,dim) == Nf(i));   %�ҵ����ڸ�����ֵ������
        tree.child(i) = build_tree_45(samples(indices,dims), labels(indices), discrete_dim(dims));
    end
else   %����Ϊ����ֵ
      indices1 = find(samples(:,dim) <= split_val(dim));
      indices2 = find(samples(:,dim) > split_val(dim));
    if ~(isempty(indices1) || isempty(indices2))   %�ָ�������Ӽ�����Ϊ��
        tree.child(1) = build_tree_45(samples(indices1,dims), labels(indices1), discrete_dim(dims));
        tree.child(2) = build_tree_45(samples(indices2,dims), labels(indices2), discrete_dim(dims));
    else  %�������������������Ե�ֵһ��,������Ҷ�ӽڵ����
        labels_num = hist(labels, length(unique_label));   %ͳ��ÿ����������
        [~, ind] = max(labels_num);  %�ҵ����ֵ�Ͷ�Ӧ���±�
        tree.Nf = [];          %Ҷ�ӽڵ�û���������
        tree.split_val = [];   %Ҷ�ӽڵ�û�����Էָ�ֵ
        tree.dim = [];         %Ҷ�ӽڵ�û��������������Զ�Ӧ��λ��
        tree.child = unique_label(ind);  %�������Ψһ���
        return
    end
end

end