import numpy as np

def SingleSidedFFT(y, fs, scale = True):
    """ len(y) must be even """
    l = len(y)
    Y = np.fft.fft(y)               # fft
    Y = np.abs(Y)                   # abs to get magnitude
    Y = Y[:l//2+1]                  # only positive frequencies
    if scale:
        Y = Y/l                     # to scale it back
        Y[1:] = Y[1:]*2                 # scale for single sided spectrum
    l = len(y)
    f = np.arange(0,l//2+1)*fs/l    # from 0 to Nyquist
    return f, Y