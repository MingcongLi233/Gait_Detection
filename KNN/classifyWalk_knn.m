function YPred = classifyWalk_knn(model, XTest)

% Step 1: extract features of the test data
features = extractFeatures(XTest); 

% Step 3: do the prediction
YPred = predict(model,features);

end

