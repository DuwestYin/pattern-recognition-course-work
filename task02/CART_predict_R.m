function result = CART_predict_R(tree, sample)
% 函数功能：对一个样本进行取值预测
% 函数输入参数：
% tree:   训练好的回归树
% sample: 一个样本
% 函数输出值: 样本的取值
while(1)
     %叶子节点的情况
     if ~isempty(tree.value)
         result = tree.value;
         return;
     end
     %离散的情况
     if tree.split_left ~= tree.split_right
          if (sample(tree.attribute) == tree.split_left) || (isempty(tree.child_right))
             tree = tree.child_left;
          else
             tree = tree.child_right;
          end
     else
         %连续的情况
         if (sample(tree.attribute) <= tree.split_left) || (isempty(tree.child_right))
             tree = tree.child_left;
         else
             tree = tree.child_right;
         end
         
     end 
 end
 


end