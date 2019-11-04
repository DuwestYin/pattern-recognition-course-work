function discrete_dim = CART_is_continue(samples, T)
%samples: ������
%T: ��ɢ��������������С�ڸ�ֵ���ж�Ϊ��ɢ

FN = size(samples, 2); %������
for i = 1:FN
    unique_f = unique(samples(:,i)); %�����Ĳ�ֵͬ
    ufn = length(unique_f);  %�����Ĳ�ֵͬ����
    if ufn <= T
        discrete_dim(i) = ufn;
    else
        discrete_dim(i) = 0;
    end
end

end