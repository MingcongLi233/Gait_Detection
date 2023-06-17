function model = trainSillyWalkClassifier_knn(XTrain, YTrain)

% Step 1: preprocess data to extract features
features = extractFeatures(XTrain);

% Step 2: train the model using knn algorithm
model = fitcknn(features,YTrain,'NumNeighbors',10); % k = 5

save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line
% 
end