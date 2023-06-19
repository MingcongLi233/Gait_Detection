%Group 3 Monty Matlab Wen Bing, Yueqiu Wang, Tianyuan Kong, Mingcong Li
classdef GUI_main < handle
    properties (Access = public)
        TimeVector
        DataMatrix
        filename 
        Gui_fig
        hp0
        hp1
        hp2
        hp3
        Table 
        Axis 
        DataImportButton
        ModelImportButton
        ClassifyButton
        ConfusionMatrix
        textresult
        sillynormal
        samplingRateH = 50
        windowWidthSeconds = 3.4
        matFileContent
        XTest
        YTest
        labels
        windowedData
        
    end

        properties (Access = public, SetObservable, AbortSet)
        GUI_dataset
        end   


    methods (Access = public)
        function obj = GUI_main(); %initial
        obj.createLayout();
        obj.GUI_dataset = GUI_dataset();
        end


        %GUI layout
        function createLayout(obj)
                % GUI figure initialisation
                obj.Gui_fig = figure('Name', 'Final Project','NumberTitle', 'off','toolbar', 'none','Menubar', 'none');
                % 设置好hp0是用来进行整体缩放
                obj.hp0 = uipanel('Units','normalized','Position', [0.05 0.35 0.9 0.6], 'Title','Visual and control', 'Parent', obj.Gui_fig,'Visible','on');%总的panel面板
                % Elements
                obj.Table = uitable('Units', 'normalized',...
                    'Data', obj.Table,'Units','normalized',...
                    'Position', [0.05 0.05 0.2 0.95],...
                    'ColumnEditable', true,...
                    'ColumnName',{'Time [s]';'X [m/s^2]';'Y [m/s^2]';'Z [m/s^2]'},...
                    'parent', obj.hp0,'Callback',@obj.TableEdit);
                 %Add figure axes
                 obj.Axis = uiaxes('Units', 'normalized',...
                    'Position', [0.27 0.05 0.5 0.95],...
                    'Parent', obj.hp0,'Visible','on');

                %Control Panel   hp1
                obj.hp1 = uipanel('Position', [0.78 0.45 0.2 0.55],'Units','normalized','Title', 'Import Data','Title','Control Panel','Parent',obj.hp0);
                obj.ModelImportButton = uicontrol('Style', 'pushbutton','String', 'Choose model','Units', 'normalized','Position', [0.05 0.7 0.2 0.2], 'FontWeight','bold',... 
                    'ForeGroundColor','#FFFFFF',...
                    'BackgroundColor','#0072BD',...
                    'parent', obj.hp1,'Callback',@obj.modelImport);

                %obj.DataImportButton = uicontrol('Style', 'pushbutton','String', 'Import one walkdata', 'Units', 'normalized','Position', [0.15 0.05 0.15 0.9],'parent', obj.hp0, 'Callback',@obj.importData);
               
                % classify button
                obj.ClassifyButton = uicontrol('Style', 'pushbutton',...
                    'String', 'Classify',...
                    'Units', 'normalized',...
                    'Position', [0.1 0.3 0.4 0.2],...
                    'parent', obj.hp1,...
                    'FontWeight','bold',... 
                    'ForeGroundColor','#FFFFFF',...
                    'BackgroundColor','#0072BD', 'Callback',@obj.classification);

              % choosed model
                obj.hp2 = uipanel('Position', [0.78 0.05 0.2 0.35],'Units','normalized',...
                    'Title', 'Choosed model',...
                    'Parent', obj.hp0,'Visible','off');



               % show the reslut of classify in panel 2
                obj.hp3 = uipanel('Position', [0.05 0.05 0.9 0.3],'Units','normalized',...
                    'Title', 'Result',...
                    'Parent', obj.Gui_fig,'Visible','on');
                 %confusion matrix
                 obj.ConfusionMatrix = uiaxes('Units','normalized',...
                'Position', [0.05 0.05 0.3 0.9],...
                'Parent', obj.hp3,'Visible','on'); 
                %显示silly or Normal的图
                obj.sillynormal = uiaxes('Units','normalized',...
                'Position', [0.35 0.05 0.3 0.9],...
                'Parent', obj.hp3,'Visible','on'); 
            
                %显示准确率
                    obj.textresult =   uicontrol('Style','text',...
                    'String',"Result",...
                    'FontWeight','bold',...
                    'FontSize',10,...
                    'Units','normalized',...
                    'Position',[0.65 0.4 0.3 0.5],...
                    'Parent',obj.hp3,'Visible','on');
            end



            function importData(obj)
            obj.fileName = uigetfile('.mat');
            obj.matFileContent = load(fileName);
            end

            function modelImport(obj,~,~)
            model_filename = uigetfile('*.mat');
            obj.Trained_model = load(model_filename); %加载模型变量
            msgbox("The trained Model has been loaded!")
            obj.hp2.Visible = 'On';  % 此时再打开hp2的显示
            end   



            % Import data to Table
            function TableEdit(obj, ~, ~)
            obj.GUI_dataset.DataMatrix = obj.Table.Data; %只要修改了table里的数据后，原本的数据就会跟着改变
        end




 
          % function of extracting data
            function extractData(obj,~,~)

% matFileContent: contents of a MAT file as obtained by matFileContent=load(filename)
% filename: the name of the file including extension (e.g. Group1_Walk7_N.mat, without path)
% samplingRateHz: sampling rate in Hz
% windowWidthSeconds: window width in seconds
%***********************parameters***************************
minimun_length = 50*3.4;
addpath("Preprocessed_Data");


% check the data
if exist(obj.filename,"file")==0
    error("the data file does not exist. Please check the name of the file.\n");
else
    fprintf("*******loading data******.\n");
    
    % continues to check the name of File
    if contains(obj.filename,'_N.mat')| contains(obj.filename,'_S.mat')==0
        error("the file dose not have N or S to show the style of walk ");
    else % check the data structurw
        if isfield(obj.matFileContent,"data")& isfield(obj.matFileContent,"time")==0
            error("the file dose not correct data structure ");
        else % check the form of data
            if size(obj.matFileContent.data,1)~=3
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
                        else
                            fprintf("the walking data meets the requirement!")
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

            

       
            % use imported model to classify
            function classification(obj, ~, ~) 
                tic
                obj.XTest={};
                obj.YTest={};
                obj.extractData()
                obj.classifyWalk()
                obj.classification_runtime = toc;
                obj.evaluate()
                end
           


        end