from numpy.random import default_rng
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal


def CalcStadistics(signal):
    calc_mean = np.mean(signal)
    calc_var = np.var(signal)
    calc_std = np.std(signal)
    return calc_mean, calc_var, calc_std

def GetStadisticsLines( length, mean, std):
    mean_line = np.ones(length)*mean
    std_pos_line = mean_line + np.ones(length)*std
    std_neg_line = mean_line - np.ones(length)*std
    return mean_line, std_pos_line, std_neg_line


ORIGINAL_L = 2000
ORIGINAL_MEAN = 10
ORIGINAL_STD = 4

rng = default_rng()

# original signal
        # original = rng.standard_normal(10)
        # original = rng.random(ORIGINAL_L)
original = rng.normal(ORIGINAL_MEAN,ORIGINAL_STD,size=ORIGINAL_L)
x_original = np.arange(ORIGINAL_L)
original_mean, original_var, original_std = CalcStadistics(original)
print('original_mean', original_mean)
print('original_var', original_var)
print('original_std', original_std)
mean_line, std_pos_line, std_neg_line = GetStadisticsLines( len(original), original_mean, original_std)

# averaged signal N=4
n=4
filt_avg_N4 = np.ones(n)/n
sig_avg4 = signal.convolve(original, filt_avg_N4, mode='full')[0:len(original)]   # filter
sig_avg4 = sig_avg4[n-1::n]                                         # downsample
x_sig_avg4 = x_original
x_sig_avg4 = x_sig_avg4[n-1::n]
sig_avg4_mean, sig_avg4_var, sig_avg4_std = CalcStadistics(sig_avg4)
print('sig_avg4_mean', sig_avg4_mean)
print('sig_avg4_var', sig_avg4_var)
print('sig_avg4_std', sig_avg4_std)
sig_avg4_mean_line, sig_avg4_std_pos_line, sig_avg4_std_neg_line = GetStadisticsLines( len(original), sig_avg4_mean, sig_avg4_std)

# averaged signal N=16
n=16
filt_avg_N16 = np.ones(n)/n
sig_avg16 = signal.convolve(original, filt_avg_N16, mode='full')[0:len(original)]   # filter
sig_avg16 = sig_avg16[n-1::n]                                         # downsample
x_sig_avg16 = x_original
x_sig_avg16 = x_sig_avg16[n-1::n]
sig_avg16_mean, sig_avg16_var, sig_avg16_std = CalcStadistics(sig_avg16)
print('sig_avg16_mean', sig_avg16_mean)
print('sig_avg16_var', sig_avg16_var)
print('sig_avg16_std', sig_avg16_std)
sig_avg16_mean_line, sig_avg16_std_pos_line, sig_avg16_std_neg_line = GetStadisticsLines( len(original), sig_avg16_mean, sig_avg16_std)



fig, axes = plt.subplots(1, 1)

axes.plot(x_original,original, '-', color='#1F89D6', label='original')
axes.plot(mean_line, color='#0A3350', label='original mean = {:.2f}'.format(original_mean))
axes.plot(std_pos_line, '--', color='#0A3350', label='original std = {:.2f}'.format(original_std))
axes.plot(std_neg_line, '--', color='#0A3350')

axes.plot(x_sig_avg4,sig_avg4, '-', color='#1EE930', label='avg N4')
axes.plot(sig_avg4_mean_line, color='#0C6313', label='avg N4 mean = {:.2f}'.format(sig_avg4_mean))
axes.plot(sig_avg4_std_pos_line, '--', color='#0C6313', label='avg N4 std = {:.2f}'.format(sig_avg4_std))
axes.plot(sig_avg4_std_neg_line, '--', color='#0C6313')

axes.plot(x_sig_avg16,sig_avg16, '-', color='#D8961C', label='avg N16')
axes.plot(sig_avg16_mean_line, color='#61430B', label='avg N16 mean = {:.2f}'.format(sig_avg16_mean))
axes.plot(sig_avg16_std_pos_line, '--', color='#61430B', label='avg N16 std = {:.2f}'.format(sig_avg16_std))
axes.plot(sig_avg16_std_neg_line, '--', color='#61430B')

axes.legend()
plt.show()

# try to divide and avg of size N (avg+decimation) and see that std_new = std_original/sqrt(N)
