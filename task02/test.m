clear;clc;close all;
fprintf('正在读取样本数据……\n');
images = load_images('train-images.idx3-ubyte');
labels = load_labels('train-labels.idx1-ubyte');
%把样本分为训练集和测试集
train_samples = images(1:400,:);
train_labels = labels(1:400);
test_samples = images(401:500,:);
test_labels = labels(401:500);
%初始化各个参数
samples_T = 1;
gini_T = 0;
attr_state = ones(1,784);
discrete_dim = CART_is_continue(train_samples,10);
fprintf('正在训练模型……\n');
tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
fprintf('正在k验证结果……\n');
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('预测正确率：%2.2f%%\n',correct_ratio);

gt = get_gt(tree_C.child_left.child_right)
T = cut_ntimes(tree_C);
b_tree = CART_pruning_C(tree_C, test_samples, test_labels);
T = tree_C;
