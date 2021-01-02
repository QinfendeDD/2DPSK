clc;
clear;
%����������ȴ���1000�ġ�0������1���ź����У��������BPSK����
%������������е�ά�� N
global N
N=2000;
%���������1���ĸ���Ϊ p
global p
p=0.5;
%�����������������
s_bpsk=randsrc(1,N,[1,0;p,1-p]);
%�������ɵ��������ͼ
figure(1);
stem(s_bpsk);
axis([0 50 -0.5 1.5]);
xlabel('ά��N')
ylabel('�ź�ǿ��')
title('0/1�ȸŷֲ����ź�')

%********BPSK�źŵ����ֵ���********
m_bpsk=bpsk_modulation(s_bpsk);
figure(2);
t=zeros(1,N);
plot(m_bpsk,t,'r*');
axis([-1.5 1.5 -1 1]);
title('BPSK���źſռ�ͼ');

%********��ֵ�������źż����7�����********
insert_bpsk=upsample(m_bpsk,8);
%������ֵ�������
figure(3);
plot(insert_bpsk(1:90),'ro');
hold on;
plot(insert_bpsk(1:90));
axis([0 100 -1.5 1.5]);
title('BPSK��ֵ������');

%********�������˲����˲�********
out_bpsk=rise_cos(insert_bpsk,N,8*N);
%�����˲�����ź�
figure(5);
n=1:100;
plot(n,out_bpsk(1:100),'r.-');
hold on;
m=25:104;
stem(m,insert_bpsk(1:80),'o');
legend('�˲�����ź�','�����ź�');
title('ͨ��ƽ�����������˲����˲��õ�BPSK����źţ�10�����ڣ�');

%********����ź���ͼ********
eyediagram(out_bpsk(25:8*(N)),5*8);
title('BPSK��ͼ');

%********����źŹ������ܶ�********
R_I=xcorr(out_bpsk);
power_bpsk=fft(R_I);
figure(7);
plot(10*log10(abs(power_bpsk(1:(length(power_bpsk)+1)/2)))-max(10*log10(abs(power_bpsk(1:(length(power_bpsk)+1)/2)))));
grid on;
xlabel('Ƶ��');
ylabel('dB');
title('BPSK�������ܶ�');
%-----------���������Ĺ������ܶ�----------
out_bpsk1 = awgn(out_bpsk,10);
R_I1 = xcorr(out_bpsk1);
power_bpsk1 = fft(R_I1);
figure(8);
plot(10*log10(abs(power_bpsk1(1:(length(power_bpsk1)+1)/2)))-max(10*log10(abs(power_bpsk1(1:(length(power_bpsk1)+1)/2)))));
grid on;
xlabel('Ƶ��');
ylabel('dB');
title('����������BPSK�������ܶ�');
