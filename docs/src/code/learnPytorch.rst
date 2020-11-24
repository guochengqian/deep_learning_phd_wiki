:github_url: https://github.com/guochengqian/deep_learning_phd_wiki

Learn PyTorch
=============

Pitfall in Python
-----------------

.. raw:: html

   <!--the content inside list will be changed or not?-->

1. Mutable and immutable data types:

   | In Python, data types can be either mutable (changeable) or
     immutable (unchangable). And while most of the data types in Python
     are immutable (including integers, floats, strings, Booleans, and
     tuples), ``lists and dictionaries are mutable``. That means
     ``a global list or dictionary (mutable datatypes) can be changed even when it’s used inside of a function.``
   | If a data type is immutable, it means it can’t be updated once it’s
     been created. In Pytorch, all tensor operations are immutable.
     e.g.:

   ::

       initial_list = [1, 2, 3]
       def duplicate_last(a_list):
           last_element = a_list[-1]
           a_list.append(last_element)
           return a_list

       new_list = duplicate_last(a_list = initial_list)
       print(new_list)
       print(initial_list)
       [1, 2, 3, 3]
       [1, 2, 3, 3]

   | As we can see, here the global value of initial_list was updated,
     even though its value was only changed inside the function!
   | Because of the mutable characteristics of list and dictionary, we
     usually use it to save the imortant middle results (like accuracy,
     metrics, args).

2. 

Some advanced operations
~~~~~~~~~~~~~~~~~~~~~~~~

1. Change layers in pretrained models
   ``model.conv1[0] = new_model.conv1[0]``
2. detach some modules

::

   for param in model.conv1.parameters():
       param.requres_grad = False
   for k, param in model.named_parameters():
       print(k, param.requires_grad)

Suggested Pytorch Libraries
---------------------------

general
~~~~~~~

-  `wandb`_: Experiment tracking, hyperparameter optimization, model and
   dataset versioning.

-  `hydra`_: A framework for elegantly configuring complex applications.

-  `PyTorch Metric Learning`_: The easiest way to use deep metric
   learning in your application. Modular, flexible, and extensible. Like
   triplet loss support.

-  `TNT`_: torchnet(TNT) is a library providing powerful dataloading,
   logging and visualization utilities for Python. It is closely
   integrated with PyTorch and is designed to enable rapid iteration
   with any model or training regimen.

3D
~~

-  `Pytorch-Geometric`_: Geometric Deep Learning Extension Library for
   PyTorch

-  `torch-points-kernels`_: Pytorch kernels for spatial operations on
   point clouds

-  `torch-points3d`_: Pytorch framework for doing deep learning on point
   clouds.

-  `pytorch3d`_: PyTorch3D is FAIR’s library of reusable components for
   deep learning with 3D data.


.. _wandb: https://www.wandb.com/
.. _hydra: https://hydra.cc/
.. _PyTorch Metric Learning: https://github.com/KevinMusgrave/pytorch-metric-learning
.. _TNT: https://github.com/pytorch/tnt
.. _Pytorch-Geometric: https://github.com/rusty1s/pytorch_geometric
.. _torch-points-kernels: https://github.com/nicolas-chaulet/torch-points-kernels
.. _torch-points3d: https://github.com/nicolas-chaulet/torch-points3d
.. _pytorch3d: https://github.com/facebookresearch/pytorch3d