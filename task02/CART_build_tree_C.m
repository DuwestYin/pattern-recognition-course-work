function tree_C = CART_build_tree_C(samples, labels, attr_state, samples_T, gini_T)
%����CART������
%sammples  ������ǩ��ѵ������
%labels    �����ı�ǩ
%samples_T ��������ֵ����
%gini_T    ����ϵ����ֵ
[N, M] = size(samples);                %�������� ��������

if (N == 0) 
    tree_C = [];
    return;
end

uq_labels = unique(labels);
for i = 1:length(uq_labels)         %�ҵ�ÿ����ǩ��������
    uq_labels_n(i) = sum(labels == uq_labels(i));
end

Gini = Gini_fun(labels);   %�������ϵ��

%����̫���˻��߻���ϵ��̫С�˷���
if (N <= samples_T) || (Gini <= gini_T) || (sum(attr_state) == 0)    
    [~, index] = max(uq_labels_n);         %���������Ǹ���ǩ���±�
    tree_C.child = [];
    tree_C.class = uq_labels(index);
    tree_C.attribute = [];
    tree_C.split_left = [];
    tree_C.split_rignt = [];
    return;
end

%����ÿ����ǩ�Ļ���ϵ��,ע��ֻ��������������ɢ�����
Gini_M = 0; cut_point_index = 0;
for i = 1:M
    if attr_state(i) == 0
        Gini_M(i) = 1;
        continue;
    end
    uq_attribute = unique(samples(:, i));  %��ǩ��ȡֵ
    for j = 1:length(uq_attribute)   %ÿһ��ȡֵ�Ļ���ϵ��
        a = samples(:, i) == uq_attribute(j);  %�ֳ�������
        b = samples(:, i) ~= uq_attribute(j);
        labels_a = labels(a);
        labels_b = labels(b);
        tempa = Gini_fun(labels_a);   %ÿ���ֵĻ���ϵ��
        tempb = Gini_fun(labels_b);
        %�Ըõ㻮�ֵĻ���ϵ��
        Gini_a(j) = (length(labels_a)/N)*tempa + (length(labels_b)/N)*tempb;
    end
   [Gini_M(i), cut_point_index(i)] = min(Gini_a);  %��Сֵ��Ϊ���������Ļ���ϵ��
end

[~, Gini_min_index] = min(Gini_M);  
op_attribute = Gini_min_index;           %���ŵ�����
uq_attribute = unique(samples(:, op_attribute));
op_attribute_v = uq_attribute(cut_point_index(op_attribute));  %���������ķָ�ֵ
sub_a_idx = samples(:, op_attribute) == op_attribute_v;  %���������±�����
sub_b_idx = samples(:, op_attribute) ~= op_attribute_v;
sub_a = samples(sub_a_idx,:);       %������������
sub_a_labels = labels(sub_a_idx);   %��������ǩ
sub_b = samples(sub_b_idx,:);
sub_b_labels = labels(sub_b_idx);

attr_state_a = attr_state;
attr_state_b = attr_state;
attr_state_a(op_attribute) = 0;

if length(uq_attribute) == 2  %�������ֻ����������������������Ҳû��Ҫ�������������
    attr_state_b(op_attribute) = 0;
end



tree_C.attribute = op_attribute;
tree_C.split_left = op_attribute_v;
tree_C.split_right = uq_attribute(uq_attribute ~= op_attribute_v);
tree_C.class = [];
tree_C.child_left = CART_build_tree_C(sub_a, sub_a_labels, attr_state_a, samples_T, gini_T); %�ݹ鹹��
tree_C.child_right = CART_build_tree_C(sub_b, sub_b_labels, attr_state_b, samples_T, gini_T);















    
end
