clear;clc;close all;
x = 1:100;
x = x';
y = (x-10).^2 -5;
x2 = 1:0.1:100;
y2 = (x2-10).^2 -5;
tree = CART_build_tree_R(x, y, 1, 0, 2);
for i = 1:length(x2);
    y3(i) = CART_predict_R(tree,x2(i));
end

plot(x2,y2,'b'),hold on;
plot(x2,y3,'k')