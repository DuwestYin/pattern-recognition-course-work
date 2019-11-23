clear;clc;close all;
% a = [1,2,2,1,3,1,2,2,2,1,3,3,1,3,2,3,1];
% b = [1,1,1,1,1,2,2,2,2,3,3,1,2,2,2,1,1];
% c = [1,2,1,2,1,1,1,1,2,3,3,1,1,2,1,1,2];
% d = [1,1,1,1,1,1,2,1,2,1,3,3,2,2,1,3,2];
% e = [1,1,1,1,1,2,2,2,2,3,3,3,1,1,2,3,2];
% f = [1,1,1,1,1,2,2,1,1,2,1,2,1,1,2,1,1];
% train_samples = [a', b', c', d', e', f'];
% labels = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0];
% train_labels = labels';
% % attr_state = ones(1,6);

fprintf('正在读取样本数据……\n');
data1 = textread('data2.txt');
data2 = xlsread('data1.xlsx');
samples = data2(:, 2:end);
[N, M] = size(samples);
labels = data2(:, 1); 
n1 = 295;
n2 = 393;
n3 = 492;
%把样本分为训练集和测试集
rand_n = randperm(N); 
train_samples = samples(rand_n(1:n1),:);
train_labels = labels(rand_n(1:n1));
test_samples = samples(rand_n(n1:n2),:);
test_labels = labels(rand_n(n1:n2));
cv_samples = samples(rand_n(n2:n3),:);
cv_labels = labels(rand_n(n2:n3));
%初始化各个参数
samples_T = 1;
gini_T = 0;
attr_state = ones(1,M);
discrete_dim = CART_is_continue(train_samples,10);
fprintf('正在训练模型……\n');
tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
fprintf('正在剪枝……\n');
b_tree = CART_pruning_C(tree_C, cv_samples, cv_labels);
fprintf('正在验证正确率……\n');
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('未剪枝预测正确率：%2.2f%%\n',correct_ratio);
for i =1:length(test_labels)
     result(i) = CART_predict_C(b_tree, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('剪枝后预测正确率：%2.2f%%\n',correct_ratio);