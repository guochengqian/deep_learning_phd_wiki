import os

src_path = '/home/qiang/Documents/codefiles/3D/DeepGCN/examples/sem_seg_dense/checkpoints/pretrained'

for file in os.listdir(src_path):
    file_ = file.split('-')
    new_name = '-'.join(file_[0:-1]) + '_' + '_'.join(file_[-1].split('_')[1:])
    os.rename(os.path.join(src_path, file), os.path.join(src_path, new_name))


