function [split_val, gain_ratio] = split2new(attrVal, labels)

n = length(attrVal);    %特征数组长度
for i = 1:n-1           %对特征值冒泡排序，类别标签也应改变
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

cut_vals = zeros(n-1,1);   %存储分割的值
for i = 1:n-1
    cut_vals(i) = (attrVal(i)+attrVal(i+1))/2;
end

unique_label = unique(labels);      %不同类别
ulabel_n = length(unique_label);    %不同类别数
p_num = hist(labels ,ulabel_n)/length(labels);

original_Ent = -sum(p_num.*log2(p_num));  %原始信息熵
temp_gain_ratios = zeros(length(cut_vals), 1);
for i = 1:n-1
    indices1 = find(attrVal <= cut_vals(i));
    indices2 = find(attrVal > cut_vals(i));
    n1 = length(indices1);
    n2 = length(indices2);
    P = zeros(ulabel_n, 2);  %每个属性值的样本有不同的标签
    for j = 1:length(unique_label)  %遍历每一个类别标签
        indices = labels(indices1) == unique_label(j);
        P(j,1) = sum(indices);
    end
    for j = 1:length(unique_label)  %遍历每一个类别标签
        indices = (labels(indices2) == unique_label(j));
        P(j,2) = sum(indices);
    end
    temp = 0;
    for j = 1:length(unique_label)
        if(P(j,1)) == 0
            temp(j) = 0;
        else
            temp(j) = -(P(j,1)/n1)*log2(P(j,1)/n1);
        end
    end
    temp1 = sum(temp);
    for j = 1:length(unique_label)
        if(P(j,2)) == 0
            temp(j) = 0;
        else
            temp(j) = -(P(j,2)/n2)*log2(P(j,2)/n2);
        end
    end
    temp2 = sum(temp);
    Ent_temp = (n1/n)*temp1 + (n2/n)*temp2;
    gain = original_Ent - Ent_temp;
    IV = -(n1/n)*log2(n1/n) - (n2/n)*log2(n2/n);
    temp_gain_ratios(i) = gain/IV;
end

[gain_ratio, idx] = max(temp_gain_ratios);   
split_val = cut_vals(idx);

end