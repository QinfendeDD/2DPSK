clear all; 
close all;
clc;
%%
max=10;
g=zeros(1,max);
g=randi([0 1],max,1)     %����Ϊmax���������������
cp=[];
mod1=[];
f=2*pi;                    
fc=10000;                  %�ز�Ƶ��
fs=90000;                  %������
Sp=200;                     %ÿ��ֵ100��������
t=0:2*pi/199:2*pi;
for n=1:length(g)
    if g(n)==0 
        A=zeros(1,Sp);   %ÿ��ֵ100����          
    else g(n)=1;
        A=ones(1,Sp);          
    end
    cp=[cp A];                   %��Ԫ���100  
    c=cos(f*t*fc);                   %�ز��ź�  
    mod1=[mod1 c];         %��s(t)�ȳ����ز��ź�,��Ϊ������ʽ
end
 figure(1);subplot(4,2,1);plot(cp);grid on;
 axis([0 200*length(g) -2 2]);title('�������ź�����');
 xlabel("t/s");
 ylabel('��ֵ');
 se1 = [];
 se1 = [se1 2*g-1];
%%
cm=[];mod=[];
for n=1:length(g)
    if g(n)==0; 
        B=ones(1,Sp);      %ÿ��ֵ200���� 
        c=cos(f*t);            %�ز��ź�
    else g(n)=1;
        B=ones(1,Sp); 
        c=cos(f*t+pi);      %�ز��ź�
    end
    cm=[cm B];              %s(t)��Ԫ���200   
    mod=[mod c];          %��s(t)�ȳ����ز��ź�
end
tiaoz=cm.*mod;          %e(t)����
%% ��ͼ
figure(1) ; subplot (4, 2, 2);plot(tiaoz) ;grid on;
axis([0 200*length(g) -2 2]);title( '2PSK�����ź�');
 xlabel("t/s");
 ylabel('��ֵ');
figure (2) ; subplot (4, 2, 1) ;plot (abs(fft(cp)));
axis([0 200*length(g) 0 400]) ;title('ԭʼ�ź�Ƶ��');
 xlabel("t/s");
 ylabel('��ֵ');
figure(2) ; subplot (4, 2, 2) ;plot (abs(fft(tiaoz)));
axis([0 200*length(g) 0 400]);title('2PSK�ź�Ƶ��');
 xlabel("t/s");
 ylabel('��ֵ');
%���и�˹���������ŵ�
tz=awgn(tiaoz, 10) ;%�ź�tiaoz�м���������������Ϊ10
figure (1) ;subplot (4, 2, 3) ;plot(tz);grid on
axis([0 200*length(g) -2 2]);
 xlabel("t/s");
 ylabel('��ֵ');
title('ͨ����˹�������ŵ�����ź�');
figure (2) ;subplot (4, 2, 3) ;plot (abs(fft(tz)));
axis([0 200*length(g) 0 400]);
 xlabel("t/s");
 ylabel('��ֵ');
title('�����������2PSK�ź�Ƶ��');
jiet=2*mod1.*tz;%ͬ�����
figure(1) ; subplot (4, 2, 4) ;plot (jiet);grid on
axis([0 200*length(g) -2 2]);
 xlabel("t/s");
 ylabel('��ֵ');
title('��˺��źŲ���');
figure(2) ; subplot (4, 2, 4) ;plot (abs (fft (jiet)));
axis([0 200*length(g) 0 400]) ;
xlabel("t/s");
 ylabel('��ֵ');
 title('��˺��ź�Ƶ��');
%��ͨ�˲���
fp=500; fs=700;rp=3;rs=20;fn=11025;
ws=fs/(fn/2); wp=fp/(fn/2) ;%�����-һ����Ƶ��
[n, wn]=buttord(wp, ws, rp, rs) ;%��������ͽ�ֹƵ��
[b, a]=butter (n, wn) ;%����H(z)
% figure(4) ;freqz (b, a, 1000, 11025) ;subplot(2, 1, 1);
% axis([0 4000 -100 3 ])
% title(' LPF��Ƶ��Ƶͼ' );
jt=filter(b, a, jiet);
figure(1) ; subplot (4, 2, 5) ;plot(jt);grid on
axis([0 200*length(g) -2 2]) ;
 xlabel("t/s");
 ylabel('��ֵ');
title('����ͨ�˲������źŲ���')
figure (2) ;subplot (4, 2, 5) ;plot (abs (fft(jt)));
axis([0 200*length(g) 0 400]);
 xlabel("t/s");
 ylabel('��ֵ');
title('����ͨ�˲������ź�Ƶ��');
%�����о�
for m=1:200*length(g);
    if jt(m)<0;
        jt(m)=1;
    else jt(m)>=0;
        jt (m)=0;
    end
end
figure(1) ;subplot (4, 2, 6) ;plot(jt);grid on;
axis([0 200*length(g) -2 2]);
 xlabel("t/s");
 ylabel('��ֵ');
title(' �������о����ź�s^ (t)����')
figure (2) ; subplot (4, 2, 6) ;plot (abs (fft(jt)));
axis([0 200*length(g) 0 400]) ;
 xlabel("t/s");
 ylabel('��ֵ');
title('�������о����ź�Ƶ��');
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
legend('BPSK����������','BPSK����������');