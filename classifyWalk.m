function YPred = classifyWalk(model, XTest)
% This function is used to classify the test data using the trained LSTM model.
%
% INPUTS:
% - model: trained LSTM model
% - XTest: test data
%
% OUTPUT:
% - YPred: predicted label from test data.

    YPred = categorical(repmat({'Normal walk'}, size(XTest)));
    predictions = predict(model, XTest);
    for i=1:size(predictions,1)
        if predictions(i,1)>0.5
            YPred(i)='Silly walk'; 
        else
            YPred(i)='Normal walk';
        end   
    end
