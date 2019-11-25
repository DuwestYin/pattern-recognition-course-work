function best_trees = cut_ntimes(T)
% ��������: ��һ�÷��������м�֦������һϵ������
% �����������:
% T: ѵ���õ�δ��֦�ķ�����
% �������ֵ: һϵ�ж��ڲ�ͬalpha����������
k = 0;
while true
    if ~isempty(T.child_left.class) && ~isempty(T.child_right.class)  %һ�����ڵ�����Ҷ�ӽڵ�
       break;
    end
    clear get_alhpas;
    [T, alphas] = get_alhpas(T);   %�õ��������нڵ��alphaֵ
    alpha_min = min(alphas);       
    T2 = cut_once(T, alpha_min);   %ѡ��alphaֵ��С���Ǹ��ڵ����
    k = k + 1;
    fprintf('��%d������\n',k);
    best_trees{k} = T2;            %�������洢��Ԫ��������
    T = T2;                        %��������
end

end