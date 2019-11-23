function best_tree = CART_pruning_C(tree, cv_samples, cv_labels)
%∑÷¿‡ ˜ºÙ÷¶
Ts = cut_ntimes(tree);
N = length(Ts);
n = length(cv_labels);
for i = 1:N
    for j = 1:n
        result1(j) = CART_predict_C(Ts{i}, cv_samples(j, :));
    end
    correct_ratios(i) = sum(result1' == cv_labels) / n;
end
[~, k] = max(correct_ratios);
best_tree = Ts{k};
end



