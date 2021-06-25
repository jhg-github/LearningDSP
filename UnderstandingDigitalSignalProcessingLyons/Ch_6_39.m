close all
clear

fs=15e3

%a
fa=3.8e3
fd=fs*atan(pi*fa/fs)/pi

%b
fd=3.8e3
fa=fs*tan(pi*fa/fs)/pi
fd=fs*atan(pi*fa/fs)/pi


