%������������н���16QAM����
function [y1,y2]=sixteenQam_modulation(x)
%���Ƚ��д���ת������ԭ����������ת������·�ź�
N=length(x);
a=1:2:N;
z1=x(a);
z2=x(a+1);
%�ֱ����·�źŽ���QPSK����
%����·�źŷֱ����2��4��ƽ�任
b=1:2:N/2;
temp1=z1(b);
temp2=z1(b+1);
y11=temp1*2+temp2;

temp1=z2(b);
temp2=z2(b+1);
y22=temp1*2+temp2;

%���ո�����Ĺ������ӳ��
y1(find(y11==0))=-3;
y1(find(y11==1))=-1;
y1(find(y11==3))=1;
y1(find(y11==2))=3;

y2(find(y22==0))=-3;
y2(find(y22==1))=-1;
y2(find(y22==3))=1;
y2(find(y22==2))=3;
