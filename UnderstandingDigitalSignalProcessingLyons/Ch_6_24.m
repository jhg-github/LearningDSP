close all
clear

% %a
% b = [1];
% a = [1 -2/sqrt(2) 1];
% figure(1)
% freqz(b,a,512);
% figure(2)
% zplane(b,a);

% %b
% z = [-1];
% p0 = 0.9*exp(i*pi/4)
% p1 = conj(p0)
% p = [ p0 ; p1 ];
% k = 1;
% [b,a] = zp2tf(z,p,k);
% figure(1)
% freqz(b,a,512);
% figure(2)
% zplane(b,a);

% %c
% z0 = exp(i*(0 + pi/100))
% z1 = conj(z0)
% z2 = exp(i*(pi/4 - pi/100))
% z3 = conj(z2)
% z4 = exp(i*(pi/4 + pi/100))
% z5 = conj(z4)
% z6 = exp(i*(pi/2 - pi/100))
% z7 = conj(z6)
% z8 = exp(i*(pi/2 + pi/100))
% z9 = conj(z8)
% z10 = exp(i*(3*pi/4 - pi/100))
% z11 = conj(z10)
% z12 = exp(i*(3*pi/4 + pi/100))
% z13 = conj(z12)
% z14 = exp(i*(pi - pi/100))
% z15 = conj(z14)
% z = [ z0; z1; z2; z3; z4; z5; z6; z7; z8; z9; z10; z11; z12; z13; z14; z15 ];
% p0 = exp(i*(0 + pi/100))
% p1 = conj(p0)
% p = [ p0 ; p1 ];
% k = 1;
% [b,a] = zp2tf(z,p,k);
% figure(1)
% freqz(b,a,512);
% figure(2)
% zplane(b,a);

%d
N = 16 ;
z_int = zeros(N,1) ;
m_int = 0.9;
z_ext = zeros(N,1) ;
m_ext = 1 / m_int;
z_unit = zeros(N,1) ;
for index = 1:N
    z_int(index) = m_int * exp(i*((index-1)*pi/8));
    z_ext(index) = m_ext * exp(i*((index-1)*pi/8));
    z_unit(index) = 1 * exp(i*((index-1)*pi/8));
end
z = [ z_int ; z_ext; z_unit(2:N)];
p = 0;
k = 1;
[b,a] = zp2tf(z,p,k);
figure(1)
freqz(b,a,512);
figure(2)
zplane(b,a);