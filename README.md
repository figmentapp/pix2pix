# pix2pix from scratch

An attempt at creating a pix2pix implementation from scratch, using only Tensorflow as a dependency.

This largely follows Tensorflow's pix2pix tutorial:

https://www.tensorflow.org/tutorials/generative/pix2pix

## Image Preparation

Images are required to be 1024x512, where the left image is the "real" image and the right image is the input image. You can use [Figment](https://figmentapp.com/) to prepare these.

## Setup

I use a machine with Ubuntu 20.04 and [Lambda Stack](https://lambdalabs.com/lambda-stack-deep-learning-software).

The easiest method was to use Docker:

```bash
docker run -it --rm -v $PWD:/tf -w /tf -p 8888:8888 --gpus all tensorflow/tensorflow:latest-gpu-jupyter
```

Then open a browser to the shown URL and open `pix2pix_train.ipynb`.

Change the directories as required to set up your project.

## Convert Model

Once the model is running, run the last cell to convert the generator to a SavedModel file.

To convert the saved model to tensorflowjs, open the `pix2pix_tfjs.ipynb` notebook, adjust the directories, and run all cells.
