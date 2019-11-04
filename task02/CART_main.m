clear;clc;close all;
a = [1,2,2,1,3,1,2,2,2,1,3,3,1,3,2,3,1];
b = [1,1,1,1,1,2,2,2,2,3,3,1,2,2,2,1,1];
c = [1,2,1,2,1,1,1,1,2,3,3,1,1,2,1,1,2];
d = [1,1,1,1,1,1,2,1,2,1,3,3,2,2,1,3,2];
e = [1,1,1,1,1,2,2,2,2,3,3,3,1,1,2,3,2];
f = [1,1,1,1,1,2,2,1,1,2,1,2,1,1,2,1,1];
samples = [a', b', c', d', e', f'];
labels = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0];
labels = labels';
attr_state = ones(1,6);
samples_T = 1;
gini_T = 0;
attr_state(3) = 0;
tree_C = CART_build_tree_C(samples, labels, attr_state, samples_T, gini_T); 
% s = samples(:,[1,2]); 
% tree_C = CART_build_tree_C(s, labels, [1,1], samples_T, gini_T); 
% aa = [s,labels]