%�����޳����Ӧƽ�����������˲������е�ͨ�˲�
%x�����źţ�fd�������źŵĲ���Ƶ�ʣ�fs���˲���õ����źŵĲ���Ƶ�ʡ�
function y=rise_cos(x,fd,fs)
%����ƽ�����������˲���
[yf, tf]=rcosine(fd,fs, 'fir/sqrt');
%���źŽ����˲�
[y, t]=rcosflt(x, fd,fs,'filter/fs',  yf);
figure(4);
stem(yf,'.');
title('�������˲����ĳ����Ӧ');
grid on;


