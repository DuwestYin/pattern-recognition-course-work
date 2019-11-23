function gt = get_gt(Tt)  %�������Ľڵ�t����ʧ����
Ct = Gini_fun(Tt.labels);
clear leaf_cnt;
leaf_labels = leaf_cnt(Tt);
CTt = 0;
for i = 1:length(leaf_labels)
    Ni = length(leaf_labels{i});
    Gi = Gini_fun(leaf_labels{i});
    CTt = CTt + Ni*Gi/length(Tt.labels);
end
gt = (Ct - CTt)/(length(leaf_labels) - 1);

end


function leaf_labels = leaf_cnt(Tt) %��������t��Ҷ�ӽڵ�ĸ�������Ҷ�ӽڵ�Ļ���ָ��
persistent leaf_n;
if ~isempty(Tt.class)
    k = length(leaf_n);
    k = k + 1;
    leaf_n{k} = Tt.labels;
    return;
end
leaf_cnt(Tt.child_left);
leaf_cnt(Tt.child_right);
leaf_labels = leaf_n;
end
