clear;
%����������ȴ���1000�ġ�0������1���ź����У��������QPSK����
%������������е�ά�� N
global N
N=2000;
%���������1���ĸ���Ϊ p
global p
p=0.5;
%�����������������
s_qpsk=randsrc(1,N,[1,0;p,1-p]);
%�������ɵ��������ͼ
figure(1);
stem(s_qpsk);
axis([0 50 -0.5 1.5]);
xlabel('ά��N')
ylabel('�ź�ǿ��')
title('0/1�ȸŷֲ����ź�')

%********QPSK�źŵ����ֵ���********
[m_qpsk1,m_qpsk2]=qpsk_modulation(s_qpsk);
figure(2);
plot(m_qpsk1,m_qpsk2,'r*');
axis([-2 2 -2 2]);
title('QPSK���źſռ�ͼ');

%********��ֵ�������źż����7�����********
insert_qpsk1=upsample(m_qpsk1,8);
insert_qpsk2=upsample(m_qpsk2,8);
%������ֵ�������
figure(3);
subplot(2,1,1);
plot(insert_qpsk1(1:90),'ro');
axis([0 100 -1.5 1.5]);
hold on;
plot(insert_qpsk1(1:90));
xlabel('ʵ���ź�');
axis([0 100 -1.5 1.5]);
title('QPSK��ֵ������');
subplot(2,1,2);
plot(insert_qpsk2(1:90),'yo');
axis([0 100 -1.5 1.5]);
hold on;
plot(insert_qpsk2(1:90));
xlabel('�鲿�ź�');
axis([0 100 -1.5 1.5]);

%********�������˲����˲�********
out_qpsk1=rise_cos(insert_qpsk1,N,8*N);
out_qpsk2=rise_cos(insert_qpsk2,N,8*N);
%�����˲�����ź�
figure(5);
subplot(2,1,1);
n=1:100;
plot(n,out_qpsk1(1:100),'.-r');
hold on;
m=25:104;
stem(m,insert_qpsk1(1:80),'o');
legend('�˲�����ź�','�����ź�');
title('ͨ��ƽ�����������˲����˲��õ�QPSKʵ������źţ�10�����ڣ�');
subplot(2,1,2);
plot(n,out_qpsk2(1:100),'.-r');
hold on;
stem(m,insert_qpsk2(1:80),'y');
legend('�˲�����ź�','�����ź�');
title('ͨ��ƽ�����������˲����˲��õ�QPSK�鲿����źţ�10�����ڣ�');

%********����ź���ͼ********
%�˲�����·�źźϲ������ɸ�����ʽ
eyediagram(out_qpsk1,5*8);
title('QPSKʵ����ͼ');
eyediagram(out_qpsk2,5*8);
title('QPSK�鲿��ͼ');

%********����źŹ������ܶ�********
out_qpsk=out_qpsk1+i*out_qpsk2;
R_I=xcorr(out_qpsk);
power_qpsk=fft(R_I);
figure(8);
plot(10*log10(abs(power_qpsk(1:(length(power_qpsk)+1)/2)))-max(10*log10(abs(power_qpsk(1:(length(power_qpsk)+1)/2)))));
grid on;
xlabel('Ƶ��');
ylabel('dB');
title('QPSK�������ܶ�');
