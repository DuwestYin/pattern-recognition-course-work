function result = CART_predict_C(tree, sample)
 M = length(sample);
 while(1)
     if ~isempty(tree.class)
         result = tree.clss;
         return;
     end
 end
end
