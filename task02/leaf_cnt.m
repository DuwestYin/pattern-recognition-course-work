function leaf_labels = leaf_cnt(Tt) 
% ��������: �ҵ�����t��ÿ��Ҷ�ӽڵ������ǩ
% �����������:
% Tt: �Խڵ�tΪ���ڵ�ķ���������
% �������ֵ: ÿ��Ҷ�ӽڵ������ǩ������
persistent leaf_n;
if ~isempty(Tt.class) && (Tt.class ~= inf)   %�ж�ΪҶ�ӽڵ�
    k = length(leaf_n);
    k = k + 1;
    leaf_n{k} = Tt.labels;    %������ǩ��������
    return;
end
leaf_cnt(Tt.child_left);      %�ݹ����
leaf_cnt(Tt.child_right);
leaf_labels = leaf_n;
end
