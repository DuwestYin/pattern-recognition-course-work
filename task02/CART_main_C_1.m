clear;clc;close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  CART�������ɽ�ɽŦԼס���ж�            
% 1. �������ݣ��ָ�Ϊѵ������295�������Լ���98������֤����99��
% 2. ѵ��ģ��
% 3. ���֦
% 4. ��֤Ԥ����ȷ�� 
% 5. ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fprintf('���ڶ�ȡ�������ݡ���\n');
% data2 = xlsread('data1.xlsx');
% samples = data2(:, 2:end);
% [N, M] = size(samples);
% labels = data2(:, 1); 
% n1 = 295;
% n2 = 393;
% n3 = 492;
% fprintf('���ڷָ���������\n');
% rand_n = randperm(N); 
% train_samples = samples(rand_n(1:n1),:); %��������Ϊѵ���������Լ�����֤��
% train_labels = labels(rand_n(1:n1));
% test_samples = samples(rand_n(n1:n2),:);
% test_labels = labels(rand_n(n1:n2));
% cv_samples = samples(rand_n(n2:n3),:);
% cv_labels = labels(rand_n(n2:n3));
% 
% %��ʼ����������
% fprintf('���ڳ�ʼ��ѵ����������\n');
% M = size(train_samples, 2);
% samples_T = 5; 
% gini_T = 0.1;
% attr_state = ones(1,M);
% discrete_dim = CART_is_continue(train_samples,10);
% fprintf('����ѵ��ģ�͡���\n');
% tree_C = CART_build_tree_C(train_samples, train_labels, attr_state, discrete_dim, samples_T, gini_T); 
% fprintf('���ڼ�֦����\n');
% b_tree = CART_pruning_C(tree_C, cv_samples, cv_labels);
% fprintf('ģ�ͼ�֦���,�õ���������!\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         ���ñ����ѵ���õ�ģ������֤����Լ��֦ʱ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('���ڼ������ݡ���\n');
load('samples_and_labels.mat');
fprintf('���ڼ���ѵ���õ�ģ�͡���\n');  %ѵ���õ�δ��֦ģ��
load('small_tree.mat')

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

result = [];
for i =1:length(train_labels)
     result(i) = CART_predict_C(b_tree, train_samples(i,:));
end
correct_ratio = 100*sum(result' == train_labels)/length(train_labels);
fprintf('���֦ģ�Ͷ�ѵ����Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);
result = [];
for i =1:length(test_labels)
     result(i) = CART_predict_C(b_tree, test_samples(i,:));
end
correct_ratio = 100*sum(result' == test_labels)/length(test_labels);
fprintf('���֦ģ�ͶԲ��Լ�Ԥ����ȷ�ʣ�%2.2f%%\n',correct_ratio);

fprintf('ѡ�������������Ԥ�⡭��\n');
n = size(test_samples, 1);
k = randperm(n,1);
sample = test_samples(k,:);
label = test_labels(k);
label_2 = CART_predict_C(tree_C, sample);
fprintf('����Ϊ��\n')
disp(sample');
fprintf('��������ʵ���Ϊ��%d��Ԥ�����Ϊ��%d\n',label,label_2);