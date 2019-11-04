% clear;clc;close all;
% a = [1,2,2,1,3,1,2,2,2,1,3,3,1,3,2,3,1];
% b = [1,1,1,1,1,2,2,2,2,3,3,1,2,2,2,1,1];
% c = [1,2,1,2,1,1,1,1,2,3,3,1,1,2,1,1,2];
% d = [1,1,1,1,1,1,2,1,2,1,3,3,2,2,1,3,2];
% e = [1,1,1,1,1,2,2,2,2,3,3,3,1,1,2,3,2];
% f = [1,1,1,1,1,2,2,1,1,2,1,2,1,1,2,1,1];
% samples = [a', b', c', d', e', f'];
% labels = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0];
% labels = labels';
% attr_state = ones(1,6);

fprintf('���ڶ�ȡ�������ݡ���\n');
data = textread('data2.txt');
samples = data(:, 2:end);
[N, M] = size(samples);
labels = data(:, 1); 
n = 130;
%��������Ϊѵ�����Ͳ��Լ�
rand_n = randperm(N); 
train_samples = samples(rand_n(1:n),:);
train_labels = labels(rand_n(1:n));
test_samples = samples(rand_n(n+1:end),:);
test_labels = labels(rand_n(n+1:end));
%��ʼ����������
samples_T = 1;
gini_T = 0;
attr_state = ones(1,M);
discrete_dim = CART_is_continue(train_samples,10);
fprintf('����ѵ��ģ�͡���\n');
tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
fprintf('������֤�������\n');
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);