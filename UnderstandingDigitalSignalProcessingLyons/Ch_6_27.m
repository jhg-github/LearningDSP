close all
clear

b1 = [0.1032 -0.1837 0.1032];
a1 = [1 -1.8275 0.9834];
[z1,p1,k1] = tf2zpk(b1,a1)
p1_mag=abs(p1)
p1_theta=angle(p1)

b2 = [0.3034 -0.5768 0.3034];
a2 = [1 -1.8462 0.9843];
[z2,p2,k2] = tf2zpk(b2,a2)
p2_mag=abs(p2)
p2_theta=angle(p2)

b = conv(b1,b2);
a = conv(a1,a2);
figure(1)
freqz(b,a, 1024, 8000); 
figure(2)
zplane(b,a); 


