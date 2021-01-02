close all;
clear
clc; 

%%
max=10; 
s = round(rand(1,max)) %��������0-1֮��ĳ���Ϊmax��1���������
Sinput=[] ; 
for n=1:length(s)
    if s(n)==0
        A=zeros(1,2000);    %��Ԫ���Ϊ2000
    else
        s(n)=1;
        A=ones(1,2000);
    end 
    Sinput=[Sinput A]; 
end  
% Sinput      %Sinput����22000�и�����������
figure(1);
subplot(2,1,1);
plot(Sinput);
grid on 
axis([0,2000*length(s),-2,2]);
title('�����źŲ���'); 
Sbianma=encode(s,15,11,'hamming') %�������������У�һ��15�еĶ���������
a1=[];
b1=[];
f=1000; 
t=0:2*pi/1999:2*pi; 
for n=1:length(Sbianma)
    if Sbianma(n)==0
        B=zeros(1,2000);  %ÿ��ֵ2000����
    else
        Sbianma(n)=1; 
        B=ones(1,2000);
    end 
    a1=[a1 B];  %s(t),��Ԫ���2000
    c=cos(2*pi*t);  %�ز��ź� 
    b1=[b1 c];  %��s(t)�ȳ����ز��źţ���Ϊ������ʽ
end 
figure(10);
c=cos(2*pi*t);  %�ز��ź�
plot(c);
xlabel('t/s');
ylabel('��ֵ');
title('�ز��ź�');
%%
se1 = [];
se1 = [se1 2*s-1];
% figure
% plot(se1);
% title('˫���Բ�������');
% xlabel('t/s');
% ylabel('��ֵ');
% axis([0,5,-2,2]);
%%
figure(2);
subplot(2,1,1)
plot(a1);
grid on; 
axis([0 2000*length(Sbianma) -2 2]);
title('�����������ź�����');
subplot(2,1,2); 
plot(abs(fft(a1)));
axis([0 2000*length(Sbianma) 0 400]);
title('�����������ź�����Ƶ��');
a2=[];
b2=[];
for n=1:length(Sbianma)
    if Sbianma(n)==0
        C=ones(1,2000);  %ÿ��ֵ2000��
        d=cos(2*pi*t);  %�ز��ź�
    else
        Sbianma(n)=1; 
        C=ones(1,2000);
        d=cos(2*pi*t+pi);  %�ز��ź�
    end 
    a2=[a2 C];  %s(t),��Ԫ���2000
    b2=[b2 d];  %��s(t)�ȳ����ز��ź� 
end 
tiaoz=a2.*b2;  %e(t)����
figure(3);
subplot(2,1,1);
plot(tiaoz);
grid on; 
axis([0 2000*length(Sbianma) -2 2]);
title('2psk�ѵ����ź�');
subplot(2,1,2); 
plot(abs(fft(tiaoz))); 
axis([0 2000*length(Sbianma) 0 400]);
title('2psk�ź�Ƶ��') 
%-----------------���и�˹���������ŵ�---------------------
tz=awgn(tiaoz,10);  %�ź�tiaoz���������,�����Ϊ10
figure(4);
subplot(2,1,1);
plot(tz);
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('ͨ����˹����������ź�');
subplot(2,1,2); 
plot(abs(fft(tz))); 
axis([0 2000*length(Sbianma) 0 800]);
title('�����������2psk�ź�Ƶ��'); 
%-------------------ͬ�����-------------
jiet=2*b1.*tz;  %ͬ�����
figure(5); 
subplot(2,1,1);
plot(jiet);
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('����������ɽ������źŲ���')
subplot(2,1,2);
plot(abs(fft(jiet))); 
axis([0 2000*length(Sbianma) 0 800]);
title('����������ɽ������ź�Ƶ��');
%--------------------------------û������---------
jiet1=2*b1.*tiaoz;  %ͬ�����
figure(9); 
subplot(2,1,1);
plot(jiet1);
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('δ��������ɽ������źŲ���')
subplot(2,1,2);
plot(abs(fft(jiet1))); 
axis([0 2000*length(Sbianma) 0 800]);
title('δ��������ɽ������ź�Ƶ��');
%----------------------��ͨ�˲���--------------------------- 
fp=500;
fs=700;
rp=3;
rs=20;
fn=11025; 
ws=fs/(fn/2); 
wp=fp/(fn/2);  %�����һ����Ƶ�� 
[n,wn]=buttord(wp,ws,rp,rs);  %��������ͽ�ֹƵ��
[b,a]=butter(n,wn);  %����H(z)
figure(6);
freqz(b,a,1000,11025);      %���Ƶ�ͨ�˲����ķ�Ƶ��������
% subplot(2,1,1); 
axis([0 40000 -100 3])
title('��ͨ�˲���Ƶ��ͼ');
jt=filter(b,a,jiet);
figure(12);
subplot(2,1,1);
plot(jt);
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('����ͨ�˲�����Ľ���źŲ���');
subplot(2,1,2);
plot(abs(fft(jt))); 
axis([0 2000*length(Sbianma) 0 800]);
title('����ͨ�˲�����Ľ���ź�Ƶ��'); 
%%--------------------δ�������ĵ�ͨ�˲������-----------------------
fp=500;
fs=700;
rp=3;
rs=20;
fn=11025; 
ws=fs/(fn/2); 
wp=fp/(fn/2);  %�����һ����Ƶ�� 
[n,wn]=buttord(wp,ws,rp,rs);  %��������ͽ�ֹƵ��
[b,a]=butter(n,wn);  %����H(z)
figure(11);
freqz(b,a,1000,11025);      %���Ƶ�ͨ�˲����ķ�Ƶ��������
% subplot(2,1,1); 
axis([0 40000 -100 3])
title('δ�������ĵ�ͨ�˲���Ƶ��ͼ');
jt=filter(b,a,jiet1);
figure(7);
subplot(2,1,1);
plot(jt);
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('δ����������ͨ�˲�����Ľ���źŲ���');
subplot(2,1,2);
plot(abs(fft(jt))); 
axis([0 2000*length(Sbianma) 0 800]);
title('δ����������ͨ�˲�����Ľ���ź�Ƶ��'); 
%-----------------------�����о�--------------------------
for m=1:2000*length(Sbianma)
    if jt(m)<0
        jt(m)=1;
    else jt(m)>0
        jt(m)=0;
    end
end
figure(8);
subplot(2,1,1);
plot(jt)
grid on 
axis([0 2000*length(Sbianma) -2 2]);
title('�������о����ź�jt(t)����')
subplot(2,1,2); 
plot(abs(fft(jt))); 
axis([0 2000*length(Sbianma) 0 800]); 
title('�������о�����ź�Ƶ��');
grid on;
n=1:2000:2000*length(Sbianma);
a5=[]; 
a5=[a5 jt(n)]; 
s1=decode(a5,15,11,'hamming');
a6=[]; 
for n=1:length(s1)
    if s1(n)==0 
        G=zeros(1,2000);
    else
        s1(n)=1;
        G=ones(1,2000);
    end 
    a6=[a6 G];
end 
figure(1);
subplot(2,1,2);
plot(a6);
grid on
axis([0 2000*length(s) -2 2]);
title('�����������Ĳ���')
grid on
snr_dB=1:10;  %����ȷ�Χ
snr = 10.^(snr_dB/10); %��λ����
delt_fa = 10.^(-snr_dB/10);  %�������ķ���  ����������
delt = sqrt(delt_fa);  %������ֵ��ǿ�ȣ�
Pe = zeros(1,length(snr_dB));   %�����������ʵľ���
for iter  = 1:length(snr_dB)
N = 100000; %���������г���
fa_bit = randi([0 1],[1 N]); %bit stream ����������������У�����ΪN
fa_key = randi([0 1],[1 N]);  %��Կ����
fa_enc = bitxor(fa_bit,fa_key); %�Ѽ���Կ����
% m_s =2*fa_bit-1;  %double polar
m_s =2*fa_enc-1;  %double polar   ����Կ���˫�������У�BPSK�źţ�
me = mean(fa_key);  %���ֵ
av = var(fa_key);  %�󷽲�
n =delt(iter)*(randn(1,N) + sqrt(-1)*randn(1,N))/sqrt(2); %������
r = m_s + n; % BPSK�źż��ŵ�����
es_fa = sign(real(r));  %�����о�
es_bit = (1+es_fa)/2;  %���������У������
de_enc = bitxor(es_bit,fa_key);  %����
Pe(iter) = sum(fa_bit~=de_enc)/N; %����������
theory_Pe = erfc(sqrt(snr))/2; %��������������
end
figure
semilogy(snr_dB,Pe,'r-o',snr_dB,theory_Pe,'*-b');%������
xlabel('�����SNR (dB) ');                          
ylabel('������BER'); 
title('���������� SNR/10dB')
legend('2PSK����������','2PSK����������');