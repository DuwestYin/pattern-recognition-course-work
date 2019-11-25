clear;clc;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     CART��������д����ʶ��                         
% 1. ������д�������ݣ��ָ�Ϊѵ������40000�������Լ���10000������֤����1000��
% 2. �����ݽ��ж�ֵ�� 
% 3. ѵ��ģ�ͣ�Ԥ��֦��
% 4. ��֤Ԥ����ȷ�� 
% 5. ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('���ڶ�ȡͼ���������ݡ���\n');
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

fprintf('���ڼ������ݡ���\n');     %�ָ���Ҷ�ֵ��������
load('samples_and_labels_0_1.mat');

%��ʼ����������
% M = size(train_samples, 2);
% samples_T = 5;
% gini_T = 0.05;
% attr_state = ones(1,M);
% discrete_dim = CART_is_continue(train_samples,10);
% fprintf('����ѵ��ģ�͡���\n');
% tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
% fprintf('���ڼ�֦����\n');
% b_tree = CART_pruning_C(tree_C, cv_samples, cv_labels);

fprintf('���ڼ���ѵ���õ�ģ�͡���\n');  %ѵ���õ�δ��֦ģ��
load('big_tree_ucut.mat')

fprintf('������֤��ȷ�ʡ���\n');
for i =1:length(train_labels)
     result(i) = CART_predict_C(tree_C, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('δ��֦ģ�Ͷ�ѵ����Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('δ��֦ģ�ͶԲ��Լ�Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);

load('big_tree_yucut.mat')          %ѵ���õ�Ԥ��֦ģ��

result = [];
for i =1:length(train_labels)
     result(i) = CART_predict_C(tree_C, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('Ԥ��֦ģ�Ͷ�ѵ����Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(tree_C, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('Ԥ��֦ģ�ͶԲ��Լ�Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);

fprintf('ѡ�������������Ԥ�⡭��\n');
n = size(test_samples, 1);
sample = test_samples(randperm(n,1),:);
label = CART_predict_C(tree_C, sample);
img = reshape(sample,28,28);
img = imresize(img,10);
figure,imshow(img,[]);
fprintf('������ͼ��ʾ��ʶ������Ϊ��%d\n',label);

