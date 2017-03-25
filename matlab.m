clc
clear all
close all
I = imread('first.tiff');
I=rgb2gray(I);
   % Show current image.
   figure(1)
   subplot(1,2,1)
   imshow(I);
   axis('square');
   colormap('gray');
   title('Original Image');
   subplot(1,2,2)
   imhist(I)
   [counts,x] = imhist(I);
   xlabel('Intensity value')
   ylabel('Number of pixels')
   a=1;
   b=256;
   d=0;
   while(d<10)
   m=a;
   n=b;
   sum=0;
   for i=m:n
   sum = sum+(counts(i));
   end
   mean=0;
   for i=m:n
   mean = mean+(counts(i)*x(i))/sum;
   end
   var=0;
   for i=m:n
   var=var+(counts(i)*((x(i)-mean)^2))/sum;
   end
   staDev = sqrt(var);
   t1 = round(mean-staDev)
   t2 = round(mean+staDev)
   
   sum1=0;
   for i=m:t1
   sum1 = sum1+(counts(i));
   end
   mean1=0;
   for i=m:t1
   mean1 = mean1+(counts(i)*x(i))/sum1;
   end
   var1=0;
   for i=m:t1
   var1=var1+(counts(i)*((x(i)-mean1)^2))/sum1;
   end
   staDev1 = sqrt(var1);
   
   sum2=0;
   for i=t2:n
   sum2 = sum2+(counts(i));
   end
   mean2=0;
   for i=t2:n
   mean2 = mean2+(counts(i)*x(i))/sum2;
   end
   var2=0;
   for i=t2:n
   var2=var2+(counts(i)*((x(i)-mean2)^2))/sum2;
   end
   staDev2 = sqrt(var2);
   m = t1+1;
   n = t2-1;
   d=d+1;
   end
   t1 = mean;
   t2 = mean+1;
   
   
   
%% 1.PSNR(Peak signal-to-noise ratio)
sum4=sum(sum((II(i,j)-I(i,j))^(2)));
MSE=(1/(256*256))*sum4; % Mean square error
PSNR_hist=20*log10(255/sqrt(MSE))
   
   