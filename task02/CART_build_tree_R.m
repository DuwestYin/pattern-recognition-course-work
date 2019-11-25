function tree_R = CART_build_tree_R(samples, y, attr_state, discrete_dim, samples_T)
%�������ܣ�����CART�ع���

%�������������
% sammples      ������ǩ��ѵ������
% labels        �����ı�ǩ
% attr_state    ��������Ч��־
% discrete_dim  ����������ɢά��
% samples_T     ������������ֵ
% gini_T        ����ϵ����ֵ

%�������ֵ��
%�����õ�CART�ع���

[N, M] = size(samples);           %�������� ��������

if (N == 0)                    %����Ϊ�շ���
    tree_R = [];
    return;
end

%����̫���˻���û�������˷���
if (N <= samples_T) || (sum(attr_state) == 0)    
    tree_R.child = [];
    tree_R.value = mean(y);      %��ǩΪ�����Ǹ�
    tree_R.attribute = [];
    tree_R.split_left = [];
    tree_R.split_rignt = [];
    return;
end

%����ÿ����ǩ�Ļ���ϵ��,ע��ֻ��������������ɢ�����
var_M = zeros(M,1); 
cut_point_index = zeros(M,1);     %�����ɢ����
op_split_point = zeros(M,1);      %ֻ������������Ч
for i = 1:M
    if attr_state(i) == 0
        var_M(i) = inf;
        continue;
    end
    %����ֵ���������
    if discrete_dim(i) == 0
        [var_M(i), op_split_point(i)] = CART_split2_R(samples(:,i), y);
    else
        %��ɢ�����
        uq_attribute = unique(samples(:, i));  %��ǩ��ȡֵ
        for j = 1:length(uq_attribute)   %ÿһ��ȡֵ�����
            a = samples(:, i) == uq_attribute(j);  %�ֳ�������
            b = samples(:, i) ~= uq_attribute(j);
            y_a = y(a);
            y_b = y(b);
            var_a(j) = var(y_a) + var(y_b);
        end
         [var_M(i), cut_point_index(i)] = min(var_a);  %��Сֵ��Ϊ���������ķ����
    end
end

[~, var_min_index] = min(var_M);  
op_attribute = var_min_index;           %���ŵ�����

%����ֵ��ɢ�����
if discrete_dim(op_attribute) ~= 0
    uq_attribute = unique(samples(:, op_attribute));
    op_attribute_v = uq_attribute(cut_point_index(op_attribute));  %���������ķָ�ֵ
    sub_a_idx = samples(:, op_attribute) == op_attribute_v;  %���������±�����
    sub_b_idx = samples(:, op_attribute) ~= op_attribute_v;
    sub_a = samples(sub_a_idx,:);       %������������
    sub_a_y = y(sub_a_idx);   %��������ǩ
    sub_b = samples(sub_b_idx,:);
    sub_b_y = y(sub_b_idx);

    attr_state_a = attr_state;
    attr_state_b = attr_state;
    attr_state_a(op_attribute) = 0;  %����������Ҫ�ٿ����������

    if length(uq_attribute) == 2     %�������ֻ����������������������Ҳû��Ҫ�������������
        attr_state_b(op_attribute) = 0;
    end

    tree_R.attribute = op_attribute;        %��ָ�������
    tree_R.split_left = op_attribute_v;     %��������ֵ
    tree_R.split_right = uq_attribute(uq_attribute ~= op_attribute_v);  %��������ֵ
else
    %�������ֵ����
    sub_a_idx = samples(:, op_attribute) <= op_split_point(op_attribute);  %���������±�����
    sub_b_idx = samples(:, op_attribute) > op_split_point(op_attribute);
    sub_a = samples(sub_a_idx,:);       %������������
    sub_a_y = y(sub_a_idx);   %��������ǩ
    sub_b = samples(sub_b_idx,:);
    sub_b_y = y(sub_b_idx);
    attr_state_a = attr_state;   %��������һֱ���Կ���
    attr_state_b = attr_state;
   
    tree_R.attribute = op_attribute;        %��ָ�������
    tree_R.split_left = op_split_point(op_attribute);     %���Ҷ��Ƿָ�ֵ
    tree_R.split_right = tree_R.split_left;                
end
tree_R.value = [];
tree_R.child_left = CART_build_tree_R(sub_a, sub_a_y, attr_state_a, discrete_dim, samples_T); %�ݹ鹹��
tree_R.child_right = CART_build_tree_R(sub_b, sub_b_y, attr_state_b, discrete_dim, samples_T);





end
