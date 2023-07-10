function YPred = classifyWalk_knn(model, XTest)
% This function is used to classify the test data using the trained knn model.
%
% INPUTS:
% - model: trained k-NN model
% - XTest: test data
%
% OUTPUT:
% - YPred: the predicted label from test data.

% Step 1: extract features of the test data
features = extractFeatures(XTest); 

% Step 3: do the prediction
YPred = predict(model,features);

end

