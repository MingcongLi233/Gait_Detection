function model = trainSillyWalkClassifier_knn(XTrain, YTrain)
% This function is used to train the k-NN model
% 
% INPUTS:
% -XTrain: training data
% -YTrain: true labels of the corresponding training data
%
% OUTPUT:
% -model: trained knn-model 

% Step 1: preprocess data to extract features
features = extractFeatures(XTrain);

% Step 2: train the model using knn algorithm
model = fitcknn(features,YTrain,'NumNeighbors',10); % k = 10

save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line
% 
end