function discrete_dim = discrete_continue(samples, min)
%samples: 样本集
%min: 离散特征的最大个数，小于该值则判定为离散

FN = size(samples, 2); %特征数
for i = 1:FN
    unique_f = unique(samples(:,i)); %特征的不同值
    ufn = length(unique_f);  %特征的不同值个数
    if ufn <= min
        discrete_dim(i) = ufn;
    else
        discrete_dim(i) = 0;
    end
end
