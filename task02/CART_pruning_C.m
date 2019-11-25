function best_tree = CART_pruning_C(tree, cv_samples, cv_labels)
% �������ܣ���������֦
% �����������: 
% tree: ѵ���õ�δ��֦�ķ�����
% cv_samples: ��֤������
% cv_labels: ��֤����ǩ
% �������ֵ: ��֦�õ���������

Ts = cut_ntimes(tree);      %����һϵ�жԲ�ͬalpha����������
N = length(Ts);
n = length(cv_labels);
for i = 1:N                 %����ÿ����������֤����ȷ��
    for j = 1:n
        result1(j) = CART_predict_C(Ts{i}, cv_samples(j, :));
    end
    correct_ratios(i) = sum(result1' == cv_labels) / n;
end
[~, k] = max(correct_ratios);    %ѡ����ȷ����ߵ��ǿ�������Ϊ�������ŵ���
best_tree = Ts{k};
end



