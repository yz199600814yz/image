clc;
clear;
close all;
%% ����׼����Ӱ��Ϳ��Ƶ��ȡ
im1 = imread('Ӱ��\SS-3m-1202.tiff');
GCP = load('���Ƶ�\SS-3m-1202.txt');
% GCP = GCP(:,2:3);
pointnum = size(GCP,1);
%% ��ȡ���Ƶ���δ���
% step1 ��������ת��Ϊ�������겢ȡ�����ڵĻҶ�ֵ����������
win = 1;               % ���ڴ�С��ֵ
ww = cell(pointnum,1); % �������������ڴ洢���������ĻҶ�ֵ
Index1 = cell(pointnum,1); %�������������ڴ洢��������ֵ
uv = [];                   %���Ƶ���������
for i = 1:pointnum 
    %temp = make_u_v(GCP(i,1),GCP(i,2));
    temp = make_u_v(GCP(i,2),GCP(i,3));
    tempw = im1(temp(:,2)-win:temp(:,2)+win,temp(:,1)-win:temp(:,1)+win);
    % ȡ��ȡ���Ƶ�ľ�����������
    tempx = [temp(:,1)-win:temp(:,1)+win];
    tempy = [temp(:,2)-win:temp(:,2)+win];
    index = [];
    for j = 1:size(tempx,2)
        aa = [];
        for k = 1:size(tempy,2)
            tempm = [tempx(:,j) tempy(:,k)];
            aa = [aa;tempm];
        end
        index = [index,aa];
    end
    num = size(tempx,2);   
    bb = zeros(1,num);
    for ii = 1:size(bb,2)
        bb(ii) = 1;
    end
    dim1 = bb;
    dim2 = bb.*2;
    Index = mat2cell(index,dim1,dim2);
    ww{i,:} = tempw;   % ���ο�Ҷ�Ԫ������
    Index1{i,:} = Index;  %���ο���������Ԫ������
    uv = [uv;temp];
end
%%
%%%%������ֵ
Pixelvalue = fopen('����ֵ�洢\SS-3m-1202-3.txt','wt'); 
for i = 1:pointnum
  mat = ww{i,1};
  for i = 1:size(mat, 1)
        fprintf(Pixelvalue, '%d\t', mat(i,:));
        fprintf(Pixelvalue, '\n');

  end
  fprintf(Pixelvalue, '\n');
end
fclose(Pixelvalue);
