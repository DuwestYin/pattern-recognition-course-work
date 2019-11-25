function T = cut_once(T, alpha_min)   
% �������ܣ�����alpha��С���Ǹ��ڵ�
% �����������: 
% T: ��Ҫ��֦����
% alpha_min: ��С��alphaֵ
% �������ֵ: ����һ���ڵ����

if ~isempty(T.class)    %Ҷ�ӽڵ�
    return;
end
if T.alpha == alpha_min   %�ҵ���С��alphaֵ�ڵ㣬���м�֦
    T.child_left = [];
    T.child_right = [];
    T.split_left = [];
    T.split_right = [];
    T.attribute = [];
    T.alpha = inf;
    
    uq_labels = unique(T.labels);
    for i = 1:length(uq_labels)             %�ҵ�ÿ����ǩ��������
        uq_labels_n(i) = sum(T.labels == uq_labels(i));
    end
     [~, index] = max(uq_labels_n);         %���������Ǹ���ǩ���±�
     T.class = uq_labels(index);            %��ǩΪ�����Ǹ�
     return;
else
     T.child_left = cut_once(T.child_left, alpha_min);  %�ݹ����
     T.child_right = cut_once(T.child_right, alpha_min);
   
end


end