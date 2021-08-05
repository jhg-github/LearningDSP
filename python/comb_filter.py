import matplotlib.pyplot as plt
import numpy as np
from scipy import signal


# constants
FS_Hz = 800


# comb0 filter
comb0 = [1, 1]
w0, H0 = signal.freqz(comb0, fs=FS_Hz, worN=(FS_Hz//2)+1, include_nyquist=True)
H0 = abs(H0)
H0 = 20*np.log10(H0/H0[0])

# comb1 filter
comb1 = [1, 0, 1]
w1, H1 = signal.freqz(comb1, fs=FS_Hz, worN=(FS_Hz//2)+1, include_nyquist=True)
H1 = abs(H1)
H1 = 20*np.log10(H1/H1[0])

# comb2 filter
comb2 = [1, 0, 0, 1]
w2, H2 = signal.freqz(comb2, fs=FS_Hz, worN=(FS_Hz//2)+1, include_nyquist=True)
H2 = abs(H2)
H2 = 20*np.log10(H2/H2[0])

# comb3 filter 50Hz -> 800/50=16
comb3 = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1]
w3, H3 = signal.freqz(comb3, fs=FS_Hz, worN=(FS_Hz//2)+1, include_nyquist=True)
H3 = abs(H3)
H3 = 20*np.log10(H3/max(H3))

# comb3 filter 50Hz -> 800/50=16 + DC (pole)
comb4_b = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1]
comb4_a = [1, -0.999999]
w4, H4 = signal.freqz(comb4_b, comb4_a, fs=FS_Hz, worN=(FS_Hz//2)+1, include_nyquist=True)
H4 = abs(H4)
H4 = 20*np.log10(H4/max(H4))



# plots
fig, axes = plt.subplots(1, 1)
# plt.plot(w0, H0, '-', label ='comb [1, 1]')
# plt.plot(w1, H1, '-', label ='comb [1, 0, 1]')
# plt.plot(w2, H2, '-', label ='comb [1, 0, 0, 1]')
plt.plot(w3, H3, '-', label ='comb 50Hz')
plt.plot(w4, H4, '-', label ='comb ')
plt.legend()
plt.grid()
plt.show()