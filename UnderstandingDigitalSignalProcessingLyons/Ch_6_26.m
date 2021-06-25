close all
clear

z0=0.5657+0.5657j
z0_mag=abs(z0)
z0_theta=angle(z0)
z1=conj(z0)
z2=1/z0_mag*exp(z0_theta*j)
z2_mag=abs(z2)
z2_theta=angle(z2)
