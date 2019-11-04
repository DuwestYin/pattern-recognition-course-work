function result = CART_predict_C(tree, sample)
 while(1)
     %叶子节点的情况
     if ~isempty(tree.class)
         result = tree.class;
         return;
     end
     %离散的情况
     if tree.split_left ~= tree.split_right
          if sample(tree.attribute) == tree.split_left
             tree = tree.child_left;
          else
             tree = tree.child_right;
          end
     else
         %连续的情况
         if sample(tree.attribute) <= tree.split_left
             tree = tree.child_left;
         else
             tree = tree.child_right;
         end
         
     end 
 end
 
 
end
