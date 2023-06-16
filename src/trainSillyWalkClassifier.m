function model = trainSillyWalkClassifier(XTrain, YTrain)
% For this trivial example, no model is required. 
model = [];

save(fullfile(fileparts(mfilename('fullpath')), 'Model.mat'), 'model'); % do not change this line