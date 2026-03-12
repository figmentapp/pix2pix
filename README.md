# pix2pix from scratch

An attempt at creating a pix2pix implementation from scratch, using PyTorch and ONNX.

This largely follows Tensorflow's pix2pix tutorial:

https://www.tensorflow.org/tutorials/generative/pix2pix

## Scripts

- [train_pix2pix_default.ipynb](./train_pix2pix_default.ipynb): The "vanilla" implementation of pix2pix
- [train_pix2pix_ccm.ipynb](./train_pix2pix_ccm.ipynb): Optimized version with CCM (Consistency of Conditional Mapping), label smoothing, instance noise, asymmetric learning rates
- [train_pix2pixhd.ipynb](./train_pix2pixhd.ipynb): Experimental [pix2pixHD](https://github.com/NVIDIA/pix2pixHD) port to ONNX

## Image Preparation

Images are required to be 1024x512, where the left image is the "real" image and the right image is the input image. You can use [Figment](https://figmentapp.com/) to prepare these. For pix2pixHD, images are double that size (2048x1024).

## Setup

I use [RunPod](https://runpod.io?ref=5op0fpok) (affiliate link) to train the model.

Add some credits, then create a "Pod" there (I use NVIDIA RTX 5090) and open the link to Jupyter Lab. Upload your dataset, unzip, and make sure the directories point to the right model.

After a few minutes/hours, you can download the `generator_epoch_XXX.onnx` file and run that in Figment.
