function discrete_dim = discrete_continue(samples, min)
%samples: ������
%min: ��ɢ��������������С�ڸ�ֵ���ж�Ϊ��ɢ

FN = size(samples, 2); %������
for i = 1:FN
    unique_f = unique(samples(:,i)); %�����Ĳ�ֵͬ
    ufn = length(unique_f);  %�����Ĳ�ֵͬ����
    if ufn <= min
        discrete_dim(i) = ufn;
    else
        discrete_dim(i) = 0;
    end
end
