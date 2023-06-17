classdef GUI_dataset < handle
    %Initialize properties
    properties (SetAccess=public, SetObservable, AbortSet) 
        TimeVector
        DataMatrix 
        filename
    end
    
    methods
        % import the data file and Get the selected file name
        function importData(obj)
            fileName = uigetfile('.mat');
            importData(obj, fileName);
             accelerate_data = load(fileName);
             % 得到时间 M
            obj.TimeVector = accelerate_data.time; 
            % 得到data 3*M
            obj.DataMatrix = accelerate_data.data; 
            % Get file name
            obj.filename = fileName;
        end
        end
        end