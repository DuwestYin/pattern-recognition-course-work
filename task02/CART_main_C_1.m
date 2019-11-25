clear;clc;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  CART分类树葡萄酒优劣检测            
% 1. 载入数据，分割为训练集（295）、测试集（98）和验证集（99）
% 2. 训练模型
% 3. 后剪枝
% 4. 验证预测正确率 
% 5. 单个样本测试
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('正在读取样本数据……\n');
% data1 = textread('data2.txt');
% data2 = xlsread('data1.xlsx');
% samples = data2(:, 2:end);
% [N, M] = size(samples);
% labels = data2(:, 1); 
% n1 = 295;
% n2 = 393;
% n3 = 492;
% %把样本分为训练集和测试集
% rand_n = randperm(N); 
% train_samples = samples(rand_n(1:n1),:);
% train_labels = labels(rand_n(1:n1));
% test_samples = samples(rand_n(n1:n2),:);
% test_labels = labels(rand_n(n1:n2));
% cv_samples = samples(rand_n(n2:n3),:);
% cv_labels = labels(rand_n(n2:n3));

fprintf('正在加载数据……\n');
load('samples_and_labels.mat');

%初始化各个参数
% M = size(train_samples, 2);
% samples_T = 10;
% gini_T = 0.1;
% % samples_T = 5;
% % gini_T = 0.05;
% attr_state = ones(1,M);
% discrete_dim = CART_is_continue(train_samples,10);
% fprintf('正在训练模型……\n');
% tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
% fprintf('正在剪枝……\n');
% b_tree = CART_pruning_C(tree_C, cv_samples, cv_labels);

fprintf('正在加载训练好的模型……\n');  %训练好的未剪枝模型
load('small_tree.mat')

fprintf('正在验证正确率……\n');
for i =1:length(train_labels)
     result(i) = CART_predict_C(tree_C, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('未剪枝模型对训练集预测正确率：%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('未剪枝模型对测试集预测正确率：%2.2f%%\n',correct_ratio);

result = [];
for i =1:length(train_labels)
     result(i) = CART_predict_C(b_tree, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('后剪枝模型对训练集预测正确率：%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(b_tree, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('后剪枝模型对测试集预测正确率：%2.2f%%\n',correct_ratio);

fprintf('选择随机样本进行预测……\n');
n = size(test_samples, 1);
k = randperm(n,1);
sample = test_samples(k,:);
label = test_labels(k);
label_2 = CART_predict_C(tree_C, sample);
fprintf('样本为：\n')
disp(sample');
fprintf('样本的真实类别为：%d，预测类别为：%d\n',label,label_2);