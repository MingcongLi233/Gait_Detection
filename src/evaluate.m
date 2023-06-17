function accuracy = evaluate(YPred,YTest)


% compute the accuracy of the model
iscorrect = YPred == YTest;
accuracy = sum(iscorrect)/numel(iscorrect);

% plot confusion chart
confusionchart(YTest,YPred)