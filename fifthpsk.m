%% 2PSK
clear
close all
clc;
N=10;
snr=10;
n0=8; %���г���
fc=800; %�ز�Ƶ��
fs=4000; %����Ƶ��
%% ���������Ԫ
X=rand(1,n0);
figure(1)
subplot(2,1,1);stem(X);grid;
title('��Ԫ����');xlabel('����');ylabel('��Ԫ');
%% ���������ź�
x=[ ];
for i=1:n0
for j=1:fs
x=[x X(i)];
end
end
k=linspace(0,n0,n0*fs);
subplot(2,1,2);
plot(k,x);grid;axis([0,n0,-0.1,1.1])
title('�����ź�');xlabel('����');ylabel('������Ԫ');
%% BPSK����
y1=cos(2*pi*fc*k);
y2=cos(2*pi*fc*k+pi);
y=[ ];
for i=1:length(x)
if x(i)==1
y=[y y1(i)];
else
y=[y y2(i)];
end
end
figure(2);
plot(k,y);axis([0,n0,1.1*min(y),1.1*max(y)]);
title('BPSK�����ź�');xlabel('ʱ��');ylabel('�����ź�');
%% ������˹���������ŵ�����ź�
n=awgn(y,snr);
figure(3);
plot(k,n);axis([0,n0,1.1*min(n),1.1*max(n)]);
title('���������ź�');xlabel('ʱ��');ylabel('�źŷ�ֵ');
%% ��˽��
p=n.*y1;
figure(4);
plot(k,p);axis([0,n0,1.1*min(p),1.1*max(p)]);grid;
title('��ɽ��');xlabel('ʱ��');ylabel('��Ԫ��ֵ');
%% ��ͨ�˲�
b1=fir1(N,2*fc/fs);
L=filter(b1,1,p);
figure(5);
plot(k,L);axis([0,n0,1.1*min(L),1.1*max(L)]);grid;
title('��ͨ�˲���Ľ����ź�');xlabel('ʱ��');ylabel('��Ԫ��ֵ');
%% �����о�
u=[];
for i=0:n0-1
if [L(fs*i+0.3*fs)+L(fs*i+0.7*fs)]/2 > 0.2
u(i+1)=1;
else
u(i+1)=0;
end
end
figure(6);stem(u);grid;
title('�о��ź�');xlabel('ʱ��');ylabel('��Ԫ��ֵ');
%% �����ʼ���
disp('����������ʵĽ����ʾ���£�');
error=sum(abs(X-u))
error_rate=error/n0