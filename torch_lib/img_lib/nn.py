import torch.nn as nn
import torch.nn.functional as F
from torch.nn import Sequential as Seq
import math
import torchvision.models as models


def act_layer(act, inplace=False, neg_slope=0.2, n_prelu=1):
    act = act.lower()
    if act == 'relu':
        layer = nn.ReLU(inplace)
    elif act == 'leaky_relu':
        layer = nn.LeakyReLU(neg_slope, inplace)
    elif act == 'prelu':
        layer = nn.PReLU(num_parameters=n_prelu, init=neg_slope)
    else:
        raise NotImplementedError('activation layer [%s] is not found' % act)
    return layer

def basic_conv(in_channels, out_channels, kernel_size, bias):
    return nn.Conv2d(in_channels, out_channels, kernel_size, padding=kernel_size//2, bias=bias)


class Conv(Seq):
    def __init__(
        self, in_channels, out_channels, kernel_size=3, bias=True, act='relu', norm=True):
        m = [basic_conv(in_channels, out_channels, kernel_size, bias=bias)]
        if norm:
            m.append(nn.BatchNorm2d(out_channels))
        if act:
            m.append(act_layer(act))
        super(Conv, self).__init__(*m)

        
class DenseConv(nn.Module):
    def __init__(
        self, in_channels, out_channels, kernel_size=3, bias=True, act='relu', norm=True):
        super(DenseConv, self).__init__()
        self.conv = Conv(in_channels, out_channels, kernel_size, bias, act, norm)
    def forward(self, x):
        return torch.cat((x, self.conv(x)), 1)

                         
class DenseBlock(nn.Module):
    def __init__(self, in_channels, n_growth=32, kernel_size=3, bias=True,
                 act='relu', norm=True, res_scale=1., n_layers=3):
        super(DenseBlock, self).__init__()
        self.res_scale = res_scale
        convs = Seq(*[DenseConv(in_channels+i*n_growth, n_growth, kernel_size, bias, act, norm) for i in range(n_layers-1)])
        tail = Conv(in_channels+(n_layers-1)*n_growth, in_channels, kernel_size, bias, act, norm)
        self.body = Seq(*[convs, tail])
        self.n_layers=n_layers
                         
    def forward(self, x):
        feat = self.body(x)   
        return feat.mul(self.res_scale) + x
    
                         
class Upsampler(nn.Sequential):
    def __init__(self, scale, in_channels, act='relu', norm=False, bias=True):

        m = []
        act = act_layer(act) if act else None
        norm = nn.BatchNorm2d(in_channels) if norm else None
        if (scale & (scale - 1)) == 0:    # Is scale = 2^n?
            for _ in range(int(math.log(scale, 2))):
                m.append(basic_conv(in_channels, in_channels*4, 3, bias))
                m.append(nn.PixelShuffle(2))
                if norm: m.append(norm)
                if act is not None: m.append(act)

        elif scale == 3:
            m.append(basic_conv(in_channels, in_channels*9, 3, bias))
            m.append(nn.PixelShuffle(3))
            if norm: m.append(norm)
            if act is not None: m.append(act)
        else:
            raise NotImplementedError

        super(Upsampler, self).__init__(*m)
