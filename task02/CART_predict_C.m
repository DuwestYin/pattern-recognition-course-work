function result = CART_predict_C(tree, sample)
 while(1)
     %Ҷ�ӽڵ�����
     if ~isempty(tree.class)
         result = tree.class;
         return;
     end
     %��ɢ�����
     if tree.split_left ~= tree.split_right
          if sample(tree.attribute) == tree.split_left
             tree = tree.child_left;
          else
             tree = tree.child_right;
          end
     else
         %���������
         if sample(tree.attribute) <= tree.split_left
             tree = tree.child_left;
         else
             tree = tree.child_right;
         end
         
     end 
 end
 
 
end
