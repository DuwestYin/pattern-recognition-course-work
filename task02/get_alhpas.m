function [T, alphas] = get_alhpas(T)   
% ��������: ����һ����ÿ���ڵ��alphaֵ
% �����������: 
% T: һ�÷�����
% �������ֵ:
% T: ���ÿ���ڵ�alphaֵ����
% alphas: ����ÿ���ڵ��alphaֵ����


persistent alpha;
if ~isempty(T.class) 
    T.alpha = inf;     %Ҷ�ӽڵ��alpha��Ϊ�����
    return;
end
k = length(alpha);
k = k + 1;
aaa = get_gt(T);       %��ýڵ��alphaֵ
alpha(k) = aaa;        %���浽����
T.alpha = aaa;
if ~isempty(T.child_left) 
   [T.child_left] = get_alhpas(T.child_left);   %�ݹ����
end
if ~isempty(T.child_right)
   [T.child_right] = get_alhpas(T.child_right); 
end

alphas = alpha;
end