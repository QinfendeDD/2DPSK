%������������н���BPSK����
function y=bpsk_modulation(x);
n=1:length(x);
y(find(x==0))=-1;
y(find(x==1))=1;