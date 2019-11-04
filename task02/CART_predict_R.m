function result = CART_predict_R(tree, sample)
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