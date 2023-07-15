function accuracy = evaluate(YPred,YTest)
% This function is used to evaluate two trained model
%
% INPUTS: 
% - YPred: predicted labels from the model
% - YTest: the true labels from test data
%
% OUTPUT:
% - accuracy: how good is the predction ability from the trained model
%   accuracy = (number of correct predictions)/(number of predictions)
% - confusionchart: a confusion matrix chart from true labels YTest and 
%   predicted labels predictedLabels and returns a ConfusionMatrixChart object. 
%   The rows of the confusion matrix correspond to the true class and the columns 
%   correspond to the predicted class. Diagonal and off-diagonal cells correspond 
%   to correctly and incorrectly classified observations, respectively.

% compute the accuracy of the model
iscorrect = YPred == YTest;
accuracy = sum(iscorrect)/numel(iscorrect);

% plot confusion chart
confusionchart(YTest,YPred);
end