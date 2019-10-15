clear;clc;
%  attrV_1 = [0.697, 0.774, 0.634, 0.608, 0.556, 0.403, 0.481, 0.437, 0.666, 0.243, 0.245, 0.343, 0.639, 0.657, 0.360, 0.593, 0.719];
%  attrV_2 = [0.460, 0.376, 0.264, 0.318, 0.215, 0.237, 0.149, 0.211, 0.091, 0.267, 0.057, 0.099, 0.161, 0.198, 0.370, 0.042, 0.103];
% labels_1 = [ones(1,8),zeros(1,9)];
% labels_2 = labels_1;
% [split_v,gian_v] = split2(attrV_2,labels_1);  
data = textread('data.txt');
samples = data(:, 2:end);
labels = data(:, 1); 
N = length(labels);
n = 130;
rand_n = randperm(N); 
train_samples = samples(rand_n(1:n),:);
train_labels = labels(rand_n(1:n));
test_samples = samples(rand_n(n+1:end),:);
test_labels = labels(rand_n(n+1:end));
discrete_dim = discrete_continue(train_samples,10);
tree= build_tree_45(train_samples, train_labels, discrete_dim); 
 results = zeros(length(test_labels), 1);
 n = length(test_labels);
 for i = 1:n
     results(i) = predict_45(tree,test_samples(i,:));
 end
 correct_ratio = sum(results == test_labels)/n;




