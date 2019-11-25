function images = load_images(filename)
% ��������: ������д����ͼ������
% �����������:
% filename: �����ļ���
% �������ֵ: һ��ͼ��Ϊ���е�������

% MNIST���ݼ���ͼ��Ϊ28*28��images��ÿһ��Ϊ28*28=787������Ϊ���ݼ���ͼ��ĸ���
% images ��ÿһ�У�Ϊһ��ͼ��������е�ƴ��

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

% �ع�Ϊ��������
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
% ��һ����0-1
images = double(images) / 255;
images = images';

end
