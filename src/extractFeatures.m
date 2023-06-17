function features = extractFeatures(XTrain)

numData = size(XTrain,1);
 for i = 1:numData
     data = XTrain{i}
     x_mean(i,1) = mean(data(1,:)); % mean value of x-axis
     y_mean(i,1) = mean(data(2,:)); % mean value of y-axis
     z_mean(i,1) = mean(data(3,:)); % mean value of z-axis
     x_diff(i,1) = range(data(1,:)); % max. magnitude of x-axis
     y_diff(i,1) = range(data(2,:)); % max. magnitude of y-axis
     z_diff(i,1) = range(data(3,:)); % max. magnitude of z-axis
     x_sum(i,1) = sum(data(1,:)); % sum of magnitude of x-axis
     y_sum(i,1) = sum(data(2,:)); % sum of magnitude of y-axis
     z_sum(i,1) = sum(data(3,:)); % sum of magnitude of z-axis
     x_dev(i,1) = std(data(1,:));
     y_dev(i,1) = std(data(2,:));
     z_dev(i,1) = std(data(3,:));
 end
features = table(x_mean,y_mean,z_mean,x_diff,y_diff,z_diff,x_sum,y_sum,z_sum,...
    x_dev,y_dev,z_dev);

end




