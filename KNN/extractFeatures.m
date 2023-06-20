function features = extractFeatures(X)

numData = size(X,1);
 for i = 1:numData
     data = X{i};
     mean_x(i,1) = mean(data(1,:)); % mean value
     mean_y(i,1) = mean(data(2,:));
     mean_z(i,1) = mean(data(3,:));
     dev_x(i,1) = std(data(1,:)); % standart deviation
     dev_y(i,1) = std(data(2,:));
     dev_z(i,1) = std(data(3,:));
     sum_x(i,1) = sum(abs(data(1,:))); % sum of magnitude
     sum_y(i,1) = sum(abs(data(2,:)));
     sum_z(i,1) = sum(abs(data(3,:)));
     range_x(i,1) = range(data(1,:)); % range of magnitude
     range_y(i,1) = range(data(2,:));
     range_z(i,1) = range(data(3,:));
     max_x(i,1) = max(data(1,:)); % maximal magnitude
     max_y(i,1) = max(data(2,:));
     max_z(i,1) = max(data(3,:));

 end
    features = table(mean_x,mean_y,mean_z,dev_x,dev_y,dev_z,range_x,range_y,range_z,max_x,max_y,max_z);
end











% Fs = 50;
%      [X,freq_x]=centeredFFT(data(1,:),Fs);
%      [Y,freq_y]=centeredFFT(data(2,:),Fs);
%      [Z,freq_z]=centeredFFT(data(3,:),Fs);
%      X = abs(X);
%      Y = abs(Y);
%      Z = abs(Z);
%      max_fx(i,1) = max(freq_x); 
%      max_fy(i,1) = max(freq_y); 
%      max_fz(i,1) = max(freq_z); 
%      ind_x = find(freq_x<=5&freq_x>=-5);
%      sum_x(i,1) = sum(X(ind_x));
%      num_p_x(i,1) = numel(findpeaks(X(ind_x)));
%      ind_y = find(freq_y<=5&freq_y>=-5);
%      sum_y(i,1) = sum(Y(ind_y));
%      num_p_y(i,1) = numel(findpeaks(Y(ind_y)));
%      ind_z = find(freq_z<=5&freq_z>=-5);
%      sum_z(i,1) = sum(Z(ind_z));
%      num_p_z(i,1) = numel(findpeaks(Z(ind_z)));
