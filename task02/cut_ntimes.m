function best_trees = cut_ntimes(T)
k = 0;
while true
    if ~isempty(T.child_left.class) && ~isempty(T.child_right.class)  %һ�����ڵ�����Ҷ�ӽڵ�
       break;
    end
    clear get_alhpas;
    [T, alphas] = get_alhpas(T);
    alpha_min = min(alphas);
    T2 = cut_once(T, alpha_min);
    k = k + 1;
%     disp(k);
    best_trees{k} = T2;
    T = T2;
end

end