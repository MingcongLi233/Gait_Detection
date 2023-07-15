function [windowedData, labels] = extractData(matFileContent, filename, samplingRateHZ, windowWidthSeconds)
% This functiuon is used to preprocess the collected data 
% INPUTS:
% - matFileContent: contents of a MAT file as obtained by matFileContent=load(filename)
% - filename: the name of the file including extension (e.g. "Group1_Walk7_N.mat", without path)
% - samplingRateHz: sampling rate in Hz
% - windowWidthSeconds: window width in seconds
%
% OUTPUTS:
% - windowedData: Smaller parts of data by shifting a window of 3.4 seconds with a 50% overlap from one sample
% - labels: corresponding true labels of the windowedData

%***********************parameters***************************
minimun_length = 50*3.4;
addpath("TrainingData");
addpath("TestData");

% check the data
if exist(filename,"file")==0
    error("the data file does not exist. Please check the name of the file.\n");
% else
%     fprintf("*******loading data******.\n");
    
    % continues to check the name of File
    if contains(filename,'_N.mat')==0 & contains(filename,'_S.mat')==0
        error("the file dose not have N or S to show the style of walk ");
    else % check the data structurw
        if isfield(matFileContent,"data")& isfield(matFileContent,"time")==0
            error("the file dose not correct data structure ");
        else % check the form of data
            if size(matFileContent.data,1)~=3
                error("the form of .data is wrong");
            else % check the form of time
                if size(matFileContent.time,1)~=1
                    error("the form of .time is wrong");
                else
                    if size(matFileContent.data,2)<minimun_length
                        error("the length does not meet the requirement");
                    else
                        if length(matFileContent.data)~= length(matFileContent.time)
                            error("the length of time and the length of data is not equ");
%                         else
%                             fprintf("the walking data meets the requirement!");
                        end
                    end
                end
            end
        end
    end
end

if samplingRateHZ <=0
    error("the Sampling Rate is wrong");
else
    interval = 1/samplingRateHZ;
end

extracted_data_time = matFileContent.time(1):interval:matFileContent.time(end);
% adapt to new Hz
Extracted_data_X = interp1(matFileContent.time,matFileContent.data(1,:),extracted_data_time);
Extracted_data_Y = interp1(matFileContent.time,matFileContent.data(2,:),extracted_data_time);
Extracted_data_Z = interp1(matFileContent.time,matFileContent.data(3,:),extracted_data_time);
Extracted_whole_data=[Extracted_data_X;Extracted_data_Y;Extracted_data_Z];

% How many points do we need
point_number=windowWidthSeconds*samplingRateHZ;
point_number_half = floor(point_number/2);
total_point = numel(extracted_data_time);
data_number = floor((total_point-point_number)/point_number_half)+1;

% create a cell to store the splited data
data_cell = cell(data_number,1);
for i=1:data_number
    start_time = point_number_half*(i-1)+1;
    end_time = point_number_half*(i+1);
    data_cell(i) = {Extracted_whole_data(:,start_time:end_time)};
end

windowedData = data_cell;

%get the label
labels_structure = ones(data_number,1);
if contains(filename,'_N.mat')
    labels = categorical(labels_structure,1,"Normal walk");
else
    labels = categorical(labels_structure,1,"Silly walk");
end

end