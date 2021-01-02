clear;
%����������ȴ���1000�ġ�0������1���ź����У��������16QAM����
%������������е�ά�� N
global N
N=2000;
%���������1���ĸ���Ϊ p
global p
p=0.5;
%�����������������
s_16Qam=randsrc(1,N,[1,0;p,1-p]);
%�������ɵ��������ͼ
figure(1);
stem(s_16Qam);
axis([0 50 -0.5 1.5]);
xlabel('ά��N')
ylabel('�ź�ǿ��')
title('0/1�ȸŷֲ����ź�')

%********16QAM�źŵ����ֵ���********
[m_16Qam1,m_16Qam2]=sixteenQam_modulation(s_16Qam);
figure(2);
plot(m_16Qam1,m_16Qam2,'r*');
axis([-4 4 -4 4]);
title('16QAM���źſռ�ͼ');

%********��ֵ�������źż����7�����********
insert_16Qam1=upsample(m_16Qam1,8);
insert_16Qam2=upsample(m_16Qam2,8);
%������ֵ�������
figure(3);
subplot(2,1,1);
plot(insert_16Qam1(1:90),'ro');
axis([0 100 -1.5 1.5]);
hold on;
plot(insert_16Qam1(1:90));
xlabel('ʵ���ź�');
axis([0 100 -5 5]);
title('16QAM��ֵ������');
subplot(2,1,2);
plot(insert_16Qam2(1:90),'yo');
axis([0 100 -1.5 1.5]);
hold on;
plot(insert_16Qam2(1:90));
xlabel('�鲿�ź�');
axis([0 100 -5 5]);

%********�������˲����˲�********
out_16Qam1=rise_cos(insert_16Qam1,N,8*N);
out_16Qam2=rise_cos(insert_16Qam2,N,8*N);
%�����˲�����ź�
figure(5);
subplot(2,1,1);
n=1:100;
plot(n,out_16Qam1(1:100),'.-r');
hold on;
m=25:104;
stem(m,insert_16Qam1(1:80),'o');
legend('�˲�����ź�','�����ź�');
title('ͨ��ƽ�����������˲����˲��õ�16QAMʵ������źţ�10�����ڣ�');
subplot(2,1,2);
plot(n,out_16Qam2(1:100),'.-r');
hold on;
stem(m,insert_16Qam2(1:80),'y');
legend('�˲�����ź�','�����ź�');
title('ͨ��ƽ�����������˲����˲��õ�16QAM�鲿����źţ�10�����ڣ�');

%********����ź���ͼ********
%�˲�����·�źźϲ������ɸ�����ʽ
eyediagram(out_16Qam1,5*8);
title('16QAMʵ����ͼ');
eyediagram(out_16Qam2,5*8);
title('16QAM�鲿��ͼ');

%********����źŹ������ܶ�********
out_16Qam=out_16Qam1+i*out_16Qam2;
R_I=xcorr(out_16Qam);
power_16Qam=fft(R_I);
figure(8);
plot(10*log10(abs(power_16Qam(1:(length(power_16Qam)+1)/2)))-max(10*log10(abs(power_16Qam(1:(length(power_16Qam)+1)/2)))));
grid on;
xlabel('Ƶ��');
ylabel('dB');
title('16QAM�������ܶ�');
