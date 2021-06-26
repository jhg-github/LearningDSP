# y[n] = (1/4)*(x[n]+x[n-1]+x[n-2]+x[n-3]) = (1/4)*SUM(k=n-3,n,x[k])
# x[-1] = 0 -> y[-1] = (1/4)*(x[-1]+x[-2]+x[-3]+x[-4]) = (1/4)*(0+0+0+0) = 0
# x[0]  = 1 -> y[0]  = (1/4)*(x[0]+x[-1]+x[-2]+x[-3])  = (1/4)*(1+0+0+0) = 1/4
# x[1]  = 0 -> y[1]  = (1/4)*(x[1]+x[0]+x[-1]+x[-2])   = (1/4)*(0+1+0+0) = 1/4
# x[2]  = 0 -> y[2]  = (1/4)*(x[2]+x[1]+x[0]+x[-1])    = (1/4)*(0+0+1+0) = 1/4
# x[3]  = 0 -> y[3]  = (1/4)*(x[3]+x[2]+x[1]+x[0])     = (1/4)*(0+0+0+1) = 1/4
# x[4]  = 0 -> y[4]  = (1/4)*(x[4]+x[3]+x[2]+x[1])     = (1/4)*(0+0+0+0) = 0

import scipy
from scipy import signal
from scipy import fft
import matplotlib.pyplot as plt

L = 8
movavg_filter = scipy.array([0.25, 0.25, 0.25, 0.25])
movavg_filter_fft = fft( movavg_filter, 32 )
input_signal = scipy.array([2,1,1,1,1,1])
print(type(input_signal))
# input_signal = signal.unit_impulse(L)
filtered_signal = signal.convolve(input_signal, movavg_filter)

fig, (ax_input, ax_movavg, ax_movavg_fft, ax_filt) = plt.subplots(4, 1, sharex=True)
ax_input.stem(input_signal, use_line_collection=True)
ax_movavg.stem(movavg_filter, use_line_collection=True)
ax_movavg_fft.stem(movavg_filter_fft, use_line_collection=True)
ax_filt.stem(filtered_signal, use_line_collection=True)
plt.show()