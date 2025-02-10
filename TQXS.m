clc;
clear;
close all;
%% 数据准备，影像和控制点读取
im1 = uint8(imread('影像\SS-8M-8163.tiff'));
%im1 = imread('影像\ZW-5m-8845.tiff');
GCP = load('控制点\SS-8M-8163.txt');%最大值点读取
CRPE = load('点提取坐标显示\8163-11.txt');%拟合点读取
% GCP = GCP(:,2:3);
pointnum = size(GCP,1);
%% 获取控制点矩形窗口
% step1 将点坐标转换为像素坐标并取邻域内的灰度值和坐标索引
win = 1;               % 窗口大小阈值
ww = cell(pointnum,1); % 创建空数组用于存储窗口索引的灰度值
Index1 = cell(pointnum,1); %创建空数组用于存储窗口索引值
uv = [];                   %控制点整数坐标
for i = 1:pointnum 
    %temp = make_u_v(GCP(i,1),GCP(i,2));
    temp = make_u_v(GCP(i,2),GCP(i,3));
    tempw = im1(temp(:,2)-win:temp(:,2)+win,temp(:,1)-win:temp(:,1)+win);
    % 取所取控制点的矩形区域索引
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
    ww{i,:} = tempw;   % 矩形框灰度元胞数组
    Index1{i,:} = Index;  %矩形框像素索引元胞数组
    uv = [uv;temp];
end
%% 图像显示,按照拟合原理,拟合所得点应该位于光斑最亮的像素块内
figure
imshow(im1);
hold on;
%plot(GCP(:,1),GCP(:,2),'r*');
plot(CRPE(1,2),CRPE(1,3),'m*');
plot(CRPE(2,2),CRPE(2,3),'b*');
plot(CRPE(3,2),CRPE(3,3),'y*');
plot(CRPE(4,2),CRPE(4,3),'g*');
%plot(GCP(1,2),GCP(1,3),'c*');
plot(uv(:,1),uv(:,2),'r^');