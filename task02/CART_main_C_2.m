clear;clc;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     CART分类树手写数字识别                         
% 1. 载入手写数字数据，分割为训练集（40000）、测试集（10000）和验证集（1000）
% 2. 对数据进行二值化 
% 3. 训练模型（预剪枝）
% 4. 验证预测正确率 
% 5. 单个样本测试
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('正在读取图像样本数据……\n');
% images = load_images('train-images.idx3-ubyte');
% labels = load_labels('train-labels.idx1-ubyte');
% [N, M] = size(images);
% n1 = 40000;
% n2 = 50000;
% n3 = 60000;
% rand_n = randperm(N); 
% train_samples = images(rand_n(1:n1),:);
% train_labels = labels(rand_n(1:n1));
% test_samples = images(rand_n(n1:n2),:);
% test_labels = labels(rand_n(n1:n2));
% cv_samples = images(rand_n(n2:n3),:);
% cv_labels = labels(rand_n(n2:n3));
% train_samples = one_or_zero(train_samples);
% test_samples = one_or_zero(test_samples);
% cv_samples = one_or_zero(cv_samples);

fprintf('正在加载数据……\n');     %分割好且二值化的数据
load('samples_and_labels_0_1.mat');

%初始化各个参数
% M = size(train_samples, 2);
% samples_T = 5;
% gini_T = 0.05;
% attr_state = ones(1,M);
% discrete_dim = CART_is_continue(train_samples,10);
% fprintf('正在训练模型……\n');
% tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
% fprintf('正在剪枝……\n');
% b_tree = CART_pruning_C(tree_C, cv_samples, cv_labels);

fprintf('正在加载训练好的模型……\n');  %训练好的未剪枝模型
load('big_tree_ucut.mat')

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

load('big_tree_yucut.mat')          %训练好的预剪枝模型

result = [];
for i =1:length(train_labels)
     result(i) = CART_predict_C(tree_C, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('预剪枝模型对训练集预测正确率：%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('预剪枝模型对测试集预测正确率：%2.2f%%\n',correct_ratio);

fprintf('选择随机样本进行预测……\n');
n = size(test_samples, 1);
sample = test_samples(randperm(n,1),:);
label = CART_predict_C(tree_C, sample);
img = reshape(sample,28,28);
img = imresize(img,10);
figure,imshow(img,[]);
fprintf('样本如图所示，识别数字为：%d\n',label);

