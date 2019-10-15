function result = predict_45(tree, sample)

if isempty(tree.dim)      %当前节点为叶子节点
    result = tree.child;
    return
end
% 
% if length(sample) == 1
%     if tree.split_val ~= inf
%         if sample <= tree.split_val
%             result = tree.child(1).child;
%         else
%             result = tree.child(2).child;
%         end
%     end
% end

if tree.split_val ~= inf  %特征连续
   if sample(tree.dim) <= tree.split_val
       n = ones(length(sample), 1);
       n(tree.dim) = 0;
       n = logical(n);
       sample = sample(n);
       tree = tree.child(1);
       result = predict_45(tree, sample);
   else
       n = ones(length(sample), 1);
       n(tree.dim) = 0;
       n = logical(n);
       sample = sample(n);
       tree = tree.child(2);
       result = predict_45(tree, sample);
   end
else
    %没有考虑离散的情况
end


end



