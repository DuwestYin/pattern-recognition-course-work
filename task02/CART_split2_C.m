function [Gini_min, op_point] = CART_split2_C(attr, labels)
% ��������:������ѡ�����Ե���ѷָ��
% �����������:
% attr: ������ĳ�����Ե�ȫ��ֵ
% labels: ����ֵ��Ӧ������ǩ
% �������ֵ:
% Gini_min: ��ѷָ���Ӧ�Ļ���ָ��
% op_point: ��ѷָ����±�

n = length(attr);    %�������鳤��
for i = 1:n-1              %������ֵð����������ǩҲӦ�ı�
    for j = 1:(n-i)
        if attr(j) > attr(j+1)
            exchange = attr(j);
            attr(j) = attr(j+1);
            attr(j+1) = exchange;
            exchange = labels(j);
            labels(j) = labels(j+1);
            labels(j+1) = exchange;
        end
    end
end

cut_vals = zeros(n-1,1);   %�洢һϵ�зָ���ֵ
for i = 1:n-1
    cut_vals(i) = (attr(i)+attr(i+1))/2;
end

for i = 1:n-1
    attr_idx_a = (attr <= cut_vals(i));  %����Ϊ����
    attr_idx_b = (attr > cut_vals(i));
    labels_a = labels(attr_idx_a);
    labels_b = labels(attr_idx_b);
    Gini_a = Gini_fun(labels_a);         %�����ָ��
    Gini_b = Gini_fun(labels_b);
    Gini_N(i) = (length(labels_a)/n)*Gini_a + (length(labels_b)/n)*Gini_b;
end
[Gini_min, op_point_idx] = min(Gini_N);  %ѡ�����ָ����С�ķָ��
op_point = cut_vals(op_point_idx);

end