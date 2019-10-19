import numpy as np
import torch
from torch.nn.parameter import Parameter


def gaussian(kernel_size, sigma):
    gauss = torch.Tensor([exp(-(x - kernel_size//2)**2/float(2*sigma**2)) for x in range(kernel_size)])
    return gauss/gauss.sum()


def init_kernel(kernel_size, channel):
    _1d_kernel = gaussian(kernel_size, 1.5).unsqueeze(1)
    _2d_kernel = _1d_kernel.mm(_1d_kernel.t()).float().unsqueeze(0).unsqueeze(0)
    kernel = _2d_kernel.expand(channel, 1, kernel_size, kernel_size).contiguous()
    return kernel.to(torch.float32)


def _ssim(img1, img2, kernel):
    channel, _, _, kernel_size = kernel.shape
    mu1 = F.conv2d(img1, kernel, padding=kernel_size//2, groups=channel)
    mu2 = F.conv2d(img2, kernel, padding=kernel_size//2, groups=channel)

    mu1_sq = mu1.pow(2)
    mu2_sq = mu2.pow(2)
    mu1_mu2 = mu1*mu2

    sigma1_sq = F.conv2d(img1*img1, kernel, padding = kernel_size//2, groups = channel) - mu1_sq
    sigma2_sq = F.conv2d(img2*img2, kernel, padding = kernel_size//2, groups = channel) - mu2_sq
    sigma12 = F.conv2d(img1*img2, kernel, padding = kernel_size//2, groups = channel) - mu1_mu2

    C1 = 0.01**2
    C2 = 0.03**2
    ssim_map = ((2*mu1_mu2 + C1)*(2*sigma12 + C2))/((mu1_sq + mu2_sq + C1)*(sigma1_sq + sigma2_sq + C2))
    return ssim_map.mean()


class SSIM(torch.nn.Module):
    def __init__(self, channel, kernel_size=11):
        super(SSIM, self).__init__()
        self.weight = Parameter(init_kernel(kernel_size, channel))

    def forward(self, img1, img2):
        return _ssim(img1, img2, self.weight)

ssim = SSIM(1).to(device='cuda')
