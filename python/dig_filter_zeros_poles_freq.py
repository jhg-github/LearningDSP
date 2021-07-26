from numpy.lib.polynomial import polyint
from plot_zplane_expanded import zplane
import numpy as np
from numpy.polynomial import polynomial
from scipy import signal
import matplotlib.pyplot as plt

#        G1*(z-z0)*(z-z1)*(z-z2)...     G*(z-z0)*(z-z1)*(z-z2)... 
# H(z)= ---------------------------- = ---------------------------
#        G2*(p-p0)*(p-p1)*(p-p2)...       (p-p0)*(p-p1)*(p-p2)...

# G = 1
# z0 = 0.7071+0.7071j
# z1 = 0.7071-0.7071j
# z2 = -1
# z3 = 0.5+0.866j
# z4 = 0.5-0.866j
# z5 = -0.5+0.866j
# z6 = -0.5-0.866j
# b = G * polynomial.polyfromroots( [z0,z1, z2, z3, z4, z5, z6] ) # coeficients returned inversed!!! p(x)=c0+c1*x+...cn-1*x^n-1+x^n
# b = np.flip(b)
# print(b)
# p0 = 0.597-0.282j
# p1 = 0.597+0.282j
# a = polynomial.polyfromroots( [p0,p1] )
# a = np.flip(a)
# print(a)

# G = 1
# z0 = (0.7071+0.7071j)*0.7
# z1 = (0.7071-0.7071j)*0.7
# z2 = -1
# z3 = (0.5+0.866j)*0.7
# z4 = (0.5-0.866j)*0.7
# b = G * polynomial.polyfromroots( [ z0, z1, z2, z3, z4] ) # coeficients returned inversed!!! p(x)=c0+c1*x+...cn-1*x^n-1+x^n
# b = np.flip(b)
# print(b)
# p0 = 0.99
# a = polynomial.polyfromroots( [p0] )
# a = np.flip(a)
# print(a)

# G = 1
# z0 = -0.5+0.8660254j
# z1 = -0.5-0.8660254j
# z2 = 0.5+0.8660254j
# z3 = 0.5-0.8660254j
# z4 = -1
# z5 = (0.7071+0.7071j)
# z6 = (0.7071-0.7071j)
# b = G * polynomial.polyfromroots( [ z0, z1, z2, z3, z4, z5, z6] ) # coeficients returned inversed!!! p(x)=c0+c1*x+...cn-1*x^n-1+x^n
# b = np.flip(b)
# print(b)
# p0 = 0.9
# a = polynomial.polyfromroots( [p0] )
# a = np.flip(a)
# print(a)


b = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
print(b)
a = 1
print(a)

# zplane(b,a)

w, h = signal.freqz(b, a)
H_db = 20 * np.log10(abs(h)/max(h))
# H_db /=max(H_db)
print( 'max',  max(H_db) )
fig = plt.figure()
ax1 = fig.add_subplot(111)
plt.title('Digital filter frequency response')
plt.plot(w, H_db , 'b')
# plt.plot(w, abs(h), 'b')
plt.ylabel('Amplitude [dB]', color='b')
plt.xlabel('Frequency [rad/sample]')
# ax2 = ax1.twinx()
# angles = np.unwrap(np.angle(h))
# plt.plot(w, angles, 'g')
# plt.ylabel('Angle (radians)', color='g')
plt.grid()
plt.axis('tight')
plt.show()