import matplotlib.pyplot as plt
import numpy as np
from scipy import signal
from numpy.polynomial import polynomial



# I want of have a moving average filter and freq. rejections at 50 and 60 Hz and harmonics
# For FS_Hz = 800 and N = 32 I already get rejection for 50 Hz and harmonics
# I want to cascade a filter to give rejection for 60 Hz and harmonics

# constants
FS_Hz = 800
N = 32


# Moving average
filt1 = np.ones(N)/N
w1, H1 = signal.freqz(filt1, fs=FS_Hz, include_nyquist=False)
H1_mag = abs(H1)
H1_mag_db = 20*np.log10(H1_mag/H1_mag[0])


# # 60 Hz rejections: Method 1. Notch FIR filter with direct formula
# # z^2 - 2cos(wNotchNormalized)z + 1
# fNotch = 60
# wNotch = 2*np.pi*fNotch
# wNotchNormalized = wNotch / FS_Hz
# print(wNotchNormalized)
# notch60AndHarmonics_b = [1, -2*np.cos(wNotchNormalized), 1]
# notch60AndHarmonics_b /= sum(notch60AndHarmonics_b) # to normalize for 1 on DC
# print(notch60AndHarmonics_b)
# wNotch, H_Notch = signal.freqz(notch60AndHarmonics_b, fs=FS_Hz, include_nyquist=False)
# H_Notch_mag = abs(H_Notch)
# H_Notch_mag /= H_Notch_mag[0]
# H_Notch_mag = 20*np.log10(H_Notch_mag)

# 60 Hz rejections: Method 2. Create from zeros
#        G1*(z-z0)*(z-z1)*(z-z2)...     G*(z-z0)*(z-z1)*(z-z2)... 
# H(z)= ---------------------------- = ---------------------------
#        G2*(p-p0)*(p-p1)*(p-p2)...       (p-p0)*(p-p1)*(p-p2)...
fNotch = 60
wNotch = 2*np.pi*fNotch
wNotchNormalized = wNotch / FS_Hz
z0 = np.cos(wNotchNormalized) + np.sin(wNotchNormalized)*1j # 60Hz
z1 = np.cos(wNotchNormalized) - np.sin(wNotchNormalized)*1j # -60Hz to make it symetrical
z2 = -1    # zero at Nyquist freq
fNotch = 120
wNotch = 2*np.pi*fNotch
wNotchNormalized = wNotch / FS_Hz
z3 = np.cos(wNotchNormalized) + np.sin(wNotchNormalized)*1j # 120Hz
z4 = np.cos(wNotchNormalized) - np.sin(wNotchNormalized)*1j # -120Hz to make it symetrical
fNotch = 180
wNotch = 2*np.pi*fNotch
wNotchNormalized = wNotch / FS_Hz
z5 = np.cos(wNotchNormalized) + np.sin(wNotchNormalized)*1j # 180Hz
z6 = np.cos(wNotchNormalized) - np.sin(wNotchNormalized)*1j # -180Hz to make it symetrical
notch60AndHarmonics_b = polynomial.polyfromroots( [z0,z1,z2,z3,z4,z5,z6] ) # coeficients returned inversed!!! p(x)=c0+c1*x+...cn-1*x^n-1+x^n
notch60AndHarmonics_b = np.flip(notch60AndHarmonics_b)

notch60AndHarmonics_b /= sum(notch60AndHarmonics_b) # to normalize for 1 on DC
print(notch60AndHarmonics_b)
wNotch, H_Notch = signal.freqz(notch60AndHarmonics_b, fs=FS_Hz, include_nyquist=False)
H_Notch_mag = abs(H_Notch)
H_Notch_mag_db = 20*np.log10(H_Notch_mag/H_Notch_mag[0])


# Combined
H_Combined = H1 * H_Notch   # we can't just multiply the maginitudes !!!!
H_Combined_mag = abs(H_Combined)
H_Combined_mag_db = 20*np.log10(H_Combined_mag/H_Combined_mag[0])

# # fig, axes = plt.subplots(3, 2)
fig, axes = plt.subplots()
# axes.plot(w1, H1_mag_db, '.-', label ='H1')
axes.plot(wNotch, H_Notch_mag_db, '.-', label ='Notch')
axes.plot(wNotch, H_Combined_mag_db, '.-', label ='Combined')
plt.grid()
plt.show()
