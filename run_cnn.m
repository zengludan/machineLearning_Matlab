clear all;
cd('./cnn');
disp('testing using a pretrained imageNet convolutional neural network model')
Main_CNN_ImageNet_minimal();
cd ..

clear all;
cd('./cnn');
disp('testing training a new convolutional neural network')
Main_CIFAR_CNN_slow_SGD();
cd ..