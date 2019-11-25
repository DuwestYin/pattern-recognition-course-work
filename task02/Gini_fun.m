function Gini = Gini_fun(labels)
% ��������: �������ָ��
% �����������: 
% labels: ��������
% �������ֵ: ���ݵĻ���ָ��

N = length(labels);   %�������Ϊ�գ�������ָ������Ϊ1
if N == 0
    Gini = 1;
    return;
end
uq_labels = unique(labels);            %��ͬ�ı�ǩ���

for i = 1:length(uq_labels)           %�ҵ�ÿ����ǩ��������
    uq_labels_n(i) = sum(labels == uq_labels(i));
end

%���������Ļ���ϵ��
temp = 0;
for i = 1:length(uq_labels)
    temp = temp + (uq_labels_n(i)/N)^2; 
end

Gini = 1- temp;

end