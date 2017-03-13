%Raphael Stern, Fab. 11, 2014
%This function is used to build a machine learning based surrogate
%model from a given network. You can select the number of training points
tic
clear all
close all
nTrain=5000  ; %Number of training points
load scaledBlankNetwork.mat %Load the network topology


train_data = genRandEarthquakeData(networkStruct, nTrain); %generate a trainin gset
disp('Done generating data!')
x_train=train_data(1:networkStruct.numEdges, :); %split training set into data and labels
y_train=train_data((networkStruct.numEdges+1),:)+1;%*2-1;


disp('Starting to train a model')
%learn the SVM model
SVMModel = fitcsvm(x_train', y_train', 'Standardize',true,'KernelFunction','RBF', 'KernelScale','auto');
save fitted_model_SVM.mat

%learn logit model
B = mnrfit(x_train', y_train');
save fitted_model_logit.mat


toc