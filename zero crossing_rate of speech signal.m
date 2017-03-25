clc
clear all
close all
N=16000;
x = wavrecord(N,8000);
n1= 160;
y = hamming(n1)
for n=500:N
     for m=n-n1+1:n-1
    E(n) = x(m)*x(m)*y(n-m)*y(n-m);
   z(n)= (abs(((sign(x(m)))-(sign(x(m-1)))))).*y(n-m);
     end
end
plot(E)
figure,
plot(N,z')
%%
delay = (n1 - 1)/2;
%plot(N,z/max(z))

figure,
plot(N, z'/max(z'),'r');
xlabel('Time (sec)');
legend('Speech','Average Zero Crossing Rate');
hold off;