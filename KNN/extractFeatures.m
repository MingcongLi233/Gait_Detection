function features = extractFeatures(X)
% This function is used to extract features from data, which will bw used in the training process
%
% INPUTS:
% - X: data, from which we want to extract features 
%
% OUTPUT:
% - features: extracted features

numData = size(X,1);
 for i = 1:numData
     data = X{i};
     mean_x(i,1) = mean(data(1,:)); % mean value
     mean_y(i,1) = mean(data(2,:));
     mean_z(i,1) = mean(data(3,:));
     dev_x(i,1) = std(data(1,:)); % standart deviation
     dev_y(i,1) = std(data(2,:));
     dev_z(i,1) = std(data(3,:));
     sum_x(i,1) = sum(data(1,:)); % sum of magnitude
     sum_y(i,1) = sum(data(2,:));
     sum_z(i,1) = sum(data(3,:));
     range_x(i,1) = range(data(1,:)); % range of magnitude
     range_y(i,1) = range(data(2,:));
     range_z(i,1) = range(data(3,:));
     max_x(i,1) = max(data(1,:)); % maximal magnitude
     max_y(i,1) = max(data(2,:));
     max_z(i,1) = max(data(3,:));

 end
    features = table(mean_x,mean_y,mean_z,dev_x,dev_y,dev_z,sum_x,sum_y,sum_z,range_x,range_y,range_z,max_x,max_y,max_z);
end










