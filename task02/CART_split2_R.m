function [var_min, op_cut_val] = CART_split2_R(x,y)
% ��������:�ع���ѡ�����Ե���ѷָ��
% �����������:
% x: ������ĳ�����Ե�ȫ��ֵ
% y: ����ֵ��Ӧ��ȡֵ
% �������ֵ:
% var_min: ��ѷָ���Ӧ����С����
% op_cut_val: ��ѷָ����±�
%�ع�����������������ķָ��

n = length(x);
cut_points = zeros(n-1,1);       %�洢һϵ�зָ���ֵ
for i = 1:n-1
    cut_points(i) = (x(i) + x(i+1))/2;
end
op_val = zeros(n-1, 1);
for i = 1:n-1
    idx1 = (x <= cut_points(i));   %����Ϊ����
    idx2 = (x > cut_points(i));
    sub1 = y(idx1);
    sub2 = y(idx2);
    op_val(i) =  var(sub1) + var(sub2);  %�󷽲�
end
[var_min, var_min_idx] = min(op_val);    %ѡ�񷽲���С�ķָ��
op_cut_val = cut_points(var_min_idx);

end