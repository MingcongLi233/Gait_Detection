function YPred = classifyWalk(model, XTest)
% This is a trivial example for a classifier. It classifies any input as a
% normal walk.
    YPred = categorical(repmat({'Normal walk'}, size(XTest)));
    predictions = predict(model, XTest);
    for i=1:size(predictions,1)
        if predictions(i,1)>0.5
            YPred(i)='Silly walk'; 
        else
            YPred(i)='Normal walk';
        end   
    end
