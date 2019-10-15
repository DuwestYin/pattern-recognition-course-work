function [split_val, gain_ratio] = split2(attrVal, labels)

n = length(attrVal);    %�������鳤��
for i = 1:n-1           %������ֵð����������ǩҲӦ�ı�
    for j = 1:(n-i)
        if attrVal(j) > attrVal(j+1)
            exchange = attrVal(j);
            attrVal(j) = attrVal(j+1);
            attrVal(j+1) = exchange;
            exchange = labels(j);
            labels(j) = labels(j+1);
            labels(j+1) = exchange;
        end
    end
end

cut_vals = zeros(n-1,1);   %�洢�ָ��ֵ
for i = 1:n-1
    cut_vals(i) = (attrVal(i)+attrVal(i+1))/2;
end

gain_ratio = 0; %��ʼ��������
P_num = sum(labels);
original_Ent = -(P_num/n)*log2(P_num/n) - ((n - P_num)/n)*log2((n - P_num)/n);  %ԭʼ��Ϣ��

for i = 1:n-1
    a_i=1; b_i=1;   %�洢���·ֽ��������±�����
    attrVal_a = []; attrVal_b = []; labels_a = []; labels_b = [];
    for j = 1:n
        if attrVal(j) < cut_vals(i)
            attrVal_a(a_i) = attrVal(j);
            labels_a(a_i) = labels(j);
            a_i = a_i + 1;
        else
            attrVal_b(b_i) = attrVal(j);
            labels_b(b_i) = labels(j);
            b_i = b_i + 1;
        end
    end
    
    n_a = length(attrVal_a);    %�·ֶ�������
    n_b = length(attrVal_b);    %�Ϸֶ�������
    p_num_a = sum(labels_a);    %�Ϸֶ�����������ǩ��
    p_num_b = sum(labels_b);    %�Ϸֶ�����������ǩ��
    if p_num_a == 0 ||p_num_a == n_a   %�ų�log2����Ϊ0
        Ent_a = 0;
    else
        Ent_a = -(p_num_a/n_a)*log2(p_num_a/n_a) - ((n_a - p_num_a)/n_a)*log2((n_a - p_num_a)/n_a);  %�·ֶ���Ϣ��
    end
   
    if p_num_b == 0 || p_num_b == n_b
        Ent_b = 0;
    else
        Ent_b = -(p_num_b/n_b)*log2(p_num_b/n_b) - ((n_b - p_num_b)/n_b)*log2((n_b - p_num_b)/n_b);  %�Ϸֶ���Ϣ��
    end
    
    temp_gain = original_Ent - (n_a/n)*Ent_a - (n_b/n)*Ent_b;  %��Ϣ������
    IV = -(n_a/n)*log2(n_a/n) - (n_b/n)*log2(n_b/n);           %����
    temp_gain_ratio = temp_gain/IV;                            %��Ϣ��������
    
    if temp_gain_ratio > gain_ratio      %�ҳ���������ʺͶ�Ӧ�ķָ��
        gain_ratio = temp_gain_ratio;
        split_val = cut_vals(i);
    end
end

end