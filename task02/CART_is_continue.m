function discrete_dim = CART_is_continue(samples, T)
% 函数功能：判断特征的取值的离散维度
% 函数输入参数：
% samples: 样本集
% T: 离散特征数量阈值，小于该值则判定为离散

FN = size(samples, 2); %特征数
for i = 1:FN
    unique_f = unique(samples(:,i)); %特征的不同值
    ufn = length(unique_f);  %特征的不同值个数
    if ufn <= T
        discrete_dim(i) = ufn;
    else
        discrete_dim(i) = 0;
    end
end

end