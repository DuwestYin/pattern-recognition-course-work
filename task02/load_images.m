function images = load_images(filename)
% 函数功能: 加载手写数字图像样本
% 函数输入参数:
% filename: 样本文件名
% 函数输出值: 一幅图像为单行的样本集

% MNIST数据集的图像为28*28，images的每一行为28*28=787，行数为数据集中图像的个数
% images 的每一行，为一幅图像的所有列的拼接

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2051, ['Bad magic number in ', filename, '']);

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);

fclose(fp);

% 重构为单行样本
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
% 归一化到0-1
images = double(images) / 255;
images = images';

end
