function result = one_or_zero(samples)
% �������ܣ���ֵ����д����ͼ��
% �������������ͼ��������
% �������ֵ����ֵ�����ͼ��������
[N, ~] = size(samples);
for i = 1:N
    img = samples(i,:);
    ave_gray = mean(img);    %��ƽ���Ҷ�
    a = img >= ave_gray;
    b = logical(1 - a);
    img(a) = 1;              %��ֵ��
    img(b) = 0;
    sa(i,:) = img;
end
result = sa;
end