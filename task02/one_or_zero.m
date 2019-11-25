function result = one_or_zero(samples)
% 函数功能：二值化手写数字图像
% 函数输入参数：图像样本集
% 函数输出值：二值化后的图像样本集
[N, ~] = size(samples);
for i = 1:N
    img = samples(i,:);
    ave_gray = mean(img);    %求平均灰度
    a = img >= ave_gray;
    b = logical(1 - a);
    img(a) = 1;              %二值化
    img(b) = 0;
    sa(i,:) = img;
end
result = sa;
end