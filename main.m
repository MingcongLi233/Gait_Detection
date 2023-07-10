clear all
close all
clc
% This is the main function to produce the model and evaluate it using some testing data

%% Prepare the training data
addpath(pwd)
% Specify the folder path and file extension
folderPath = 'TrainingData/';
fileExtension = '*.mat';

% Specify the samplingRateHz, windowWidthSeconds
samplingRateHZ = 50;
windowWidthSeconds = 3.4;

% Get a list of all .mat files in the folder
fileList = dir(fullfile(folderPath, fileExtension));

% Initialize empty cell arrays for storing training data and labels
XTrain = {};
YTrain = categorical([]);
% Loop through each .mat file
for i = 1:numel(fileList)
    % Load the current .mat file
    matFileContent = load(fullfile(folderPath, fileList(i).name));
    
    % Extract data using the extractData function
    [XTrain_i, YTrain_i] = extractData(matFileContent, fileList(i).name, samplingRateHZ, windowWidthSeconds);
    
    % Concatenate the extracted data and labels to the overall arrays
    XTrain = [XTrain; XTrain_i];
    YTrain = [YTrain; YTrain_i];
end
%% Prepare the testing data
% Specify the folder path and file extension
folderPath = 'TestData/';
fileExtension = '*.mat';

% Specify the samplingRateHz, windowWidthSeconds
samplingRateHZ = 50;
windowWidthSeconds = 3.4;

% Get a list of all .mat files in the folder
fileList = dir(fullfile(folderPath, fileExtension));

% Initialize empty cell arrays for storing training data and labels
XTest = {};
YTest = categorical([]);
% Loop through each .mat file
for i = 1:numel(fileList)
    % Load the current .mat file
    matFileContent = load(fullfile(folderPath, fileList(i).name));
    
    % Extract data using the extractData function
    [XTest_i, YTest_i] = extractData(matFileContent, fileList(i).name, samplingRateHZ, windowWidthSeconds);
    
    % Concatenate the extracted data and labels to the overall arrays
    XTest = [XTest; XTest_i];
    YTest = [YTest; YTest_i];
end
%% Train the model
Model = trainSillyWalkClassifier(XTrain, YTrain);
%% Evaluate the model on test data
model = load('Model.mat').model;
YPred = classifyWalk(model, XTest);
accuracy = evaluate(YPred,YTest);
