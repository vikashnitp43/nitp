clc
clear all
close all
I = imread('board.tif');
I=rgb2gray(I);
I=imresize(I,[256,256]);
   % Show current image.
   figure(1)
   subplot(1,2,1)
   imshow(I);
   axis('square');
   colormap('gray');
   title('Original Image');
   subplot(1,2,2)
   imhist(I);
   xlabel('Intensity value')
   ylabel('Number of pixels')
   % Blurring the image
   G=imnoise(I,'gaussian',0.0005,0.0019);
  % imshow(G);
   %figure;
   h = fspecial('average', 3);
   BI=imfilter(G,h);  
   %imshow(BI);
   meanintensvalue=mean2(BI);
   BE=[];
   DE=[];
for i=1:256
    for j= 1:256
        if(BI(i,j)>meanintensvalue)
      BE(i,j)=(BI(i,j)-meanintensvalue)/meanintensvalue;
     DE(i,j)=0;
        else
            DE(i,j)=(meanintensvalue-BI(i,j))/meanintensvalue;
             BE(i,j)=0;
        end
    end
end
BE1=uint8(BE);
DE1=uint8(DE);
%figure
%imshow(BE)
%figure
%imshow(DE)
DR=1.4;BR=0.05 ;
IE=(I+(DR*(DE1.*I))-(BR*(BE1.*I)));
figure(2)
subplot(1,2,1)
imshow(IE)
axis('square');
colormap('gray');
title('Enhanced Image')
subplot(1,2,2)
imhist(IE)
xlabel('Intensity value')
ylabel('Number of pixels')
a = min(IE(:));  %minimum pixel of image IE
b = max(IE(:)); %maximum pixel of image IE 
Iout= (IE-a).*(255/(b-a)); %just using the formula above
figure(3)
subplot(1,2,1)
imshow(Iout)
axis('square');
colormap('gray');
title('Contrast Streached Image')
subplot(1,2,2)
imhist(Iout)
xlabel('Intensity value')
ylabel('Number of pixels')
% Qulitative Analysis
% Histogram Equalisation
imhist(I);
I_histeq=histeq(I);
figure
subplot(1,2,1);
imshow(I_histeq);  % display
axis('square');
colormap('gray');
title('Histogram equalised Image')
subplot(1,2,2);
imhist(I_histeq);
xlabel('Intensity value')
ylabel('Number of pixels')
% Quantitative Analysis
% ORIGINAL IMAGE
% Entropy
H=imhist(I);
sum1=0;
for i=1:256
    sum1=sum1+(H(i)/(256*256))*log2((H(i)/(256*256)));
end
E_0riginal=-sum1

% ENHANCED IMAGE using proposed technique
% 1.PSNR(Peak signal-to-noise ratio)
sum2=sum(sum((Iout(i,j)-I(i,j))^(2)));
MSE=(1/(256*256))*sum2; % Mean square error
PSNR_enhance=20*log10(255/sqrt(MSE))
% 2. Entropy
H=imhist(Iout);
sum3=0;
for i=1:256
    sum3=sum3+(H(i)/(256*256))*log2((H(i)/(256*256)));
end
E_enhance=-sum3

% HISTOGRAM EQUALISED IMAGE
% 1.PSNR(Peak signal-to-noise ratio)
sum4=sum(sum((I_histeq(i,j)-I(i,j))^(2)));
MSE=(1/(256*256))*sum4; % Mean square error
PSNR_hist=20*log10(255/sqrt(MSE))
% 2. Entropy
H=imhist(I_histeq);
sum5=0;
for i=1:256
    if(H(i)==0)
        sum5=sum5;
    else
    sum5=sum5+(H(i)/(256*256))*log2((H(i)/(256*256)));
    end
end
E_hist=-sum5








