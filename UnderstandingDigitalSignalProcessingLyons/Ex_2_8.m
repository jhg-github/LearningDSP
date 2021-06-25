% n=[0:20]';
% fs=160;
% ts=1/fs;
% f0=340;
% xn_340=sin(2*pi*f0*n*ts);
% f0=180;
% xn_180=sin(2*pi*f0*n*ts);
% f0=20;
% xn_20=sin(2*pi*f0*n*ts);
% stem(n,[xn_340, xn_180, xn_20])

n=[0:20]';
fs=1000;
ts=1/fs;
f0=800;
xn=cos(2*pi*f0*n*ts);
stem(n,xn)