close all

%a
n=[-10:10]';
xn=zeros(length(n),1);
xn(11)=1;
xn_m4=delayseq(xn, 4);
stem(n, [xn - xn_m4]);

%b ???
