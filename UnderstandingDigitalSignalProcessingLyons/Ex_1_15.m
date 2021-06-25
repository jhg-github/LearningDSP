% n_periods=3;
% samples_period=20;
% n=[0:n_periods*samples_period]';
% fs=1;
% ts=1/fs;
% f0=fs/samples_period;
% xn=sin(2*pi*f0*n*ts);
% shifted_data = delayseq(xn, 1);
% stem(n, [xn , shifted_data]);

close all

n_periods=3;
samples_period=20;
n=[0:n_periods*samples_period]';
fs=1;
ts=1/fs;
f0=fs/samples_period;
xn1=sin(2*pi*f0*n*ts);
xn2=sin(2*pi*2*f0*n*ts);

%a
xn1_m_1=delayseq(xn1, 1);
xn2_m_1=delayseq(xn2, 1);
y1=xn1_m_1/6;
y2=xn2_m_1/6;
c1=1;
c2=2;
figure
s(1) = subplot(2,1,1);
s(2) = subplot(2,1,2);  
stem(s(1),n, [c1*xn1_m_1/6 + c2*xn2_m_1/6]);
stem(s(2),n, [c1*y1 + c2*y2]);

%b
y1=3+xn1;
y2=3+xn2;
c1=1;
c2=2;
figure
s(1) = subplot(2,1,1);
s(2) = subplot(2,1,2);  
stem(s(1),n, [3+c1*xn1 + 3+c2*xn2]);
stem(s(2),n, [c1*y1 + c2*y2]);

%c
y1=sin(xn1);
y2=sin(xn2);
c1=1;
c2=2;
figure
s(1) = subplot(2,1,1);
s(2) = subplot(2,1,2);  
stem(s(1),n, [sin(c1*xn1) + sin(c2*xn2)]);
stem(s(2),n, [c1*y1 + c2*y2]);