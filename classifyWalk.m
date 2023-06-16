function YPred = classifyWalk(model, XTest)
% This is a trivial example for a classifier. It classifies any input as a
% normal walk.
YPred = categorical(repmat({'Normal walk'}, size(XTest)));

