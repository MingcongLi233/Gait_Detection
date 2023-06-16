matFileContent=load('D:\TUM\class\23SS\Monty_matlab\group work\group-3\Preprocessed_Data\Group3_Walk3_S.mat');
filename = 'Group3_Walk3_S.mat';
samplingRateHZ =50;
windowWidthSeconds=3.4;

[windowedData, labels] = extractData(matFileContent, filename, samplingRateHZ, windowWidthSeconds);