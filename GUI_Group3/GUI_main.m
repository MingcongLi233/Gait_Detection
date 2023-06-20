%Group 3 Monty Matlab Wen Bing, Yueqiu Wang, Tianyuan Kong, Mingcong Li
classdef GUI_main < handle
    properties (Access = public)
       TimeVector
        DataMatrix
        fileName 
        Gui_fig
        ChangeButton 
        Axisplot
        Trained_model
        classification_runtime
        textresult
        textresult2
        sillynormal
        samplingRateHZ = 50
        windowWidthSeconds = 3.4
        matFileContent
        labels
        windowedData
        YPred
        accuracy 
    end


    methods (Access = public)
        function obj = GUI_main(); %initial
        obj.createLayout();
        end


        %GUI layout
        function createLayout(obj)
                % GUI figure initialisation
                obj.Gui_fig = figure('Name', 'MontyMatlab_Group03','NumberTitle', 'off','toolbar', 'none','Menubar', 'none');
                % 设置好hp0是用来进行整体缩放
               

                %clear button
                obj.ChangeButton  = uicontrol('Style', 'pushbutton',...
                    'String', 'Choose another Data',...
                    'Units', 'normalized',...
                    'Position', [0.7 0.15 0.2 0.1],...
                    'parent', obj.Gui_fig,...
                    'Callback',@obj.secondData);

                 %显示准确率
                    obj.textresult2 =  uicontrol('Style','text',...
                    'String',"Result",...
                    'FontWeight','bold',...
                    'FontSize',10,...
                    'Units','normalized',...
                    'Position',[0.7 0.27 0.2 0.15],...
                    'Parent',obj.Gui_fig,'Visible','on');
                  

                % plotaxis
                 obj.Axisplot = uiaxes('Units','normalized',...
                'Position', [0.05 0.5 0.9 0.4],...
                'Parent', obj.Gui_fig,'Visible','on','NextPlot','add'); 


                %显示silly or Normal的图
                obj.sillynormal = uiaxes('Units','normalized',...
                'Position', [0.05 0.05 0.3 0.4],...
                'Parent', obj.Gui_fig,'Visible','on');
            
                %显示结果
                    obj.textresult =   uicontrol('Style','text',...
                    'String',"Result",...
                    'FontWeight','bold',...
                    'FontSize',10,...
                    'Units','normalized',...
                    'Position',[0.4 0.15 0.2 0.3],...
                    'Parent',obj.Gui_fig,'Visible','on');
            end



            
            function importData(obj,~,~)
            obj.fileName = uigetfile('.mat');
            obj.matFileContent = load(obj.fileName);
            obj.TimeVector = obj.matFileContent.time;
            obj.DataMatrix = obj.matFileContent.data;
            plot(obj.matFileContent.time, obj.matFileContent.data(1,:),'g','Parent',obj.Axisplot);
            
            hold on
            plot(obj.matFileContent.time, obj.matFileContent.data(2,:),'r','Parent',obj.Axisplot);
          
            hold on 
            plot(obj.matFileContent.time, obj.matFileContent.data(3,:),'b','Parent',obj.Axisplot);
            legend(obj.Axisplot,'X','Y','Z')
            hold off
            grid(obj.Axisplot,'on');
            %legend(obj.Axisplot,'Location','northwest');
            xlabel(obj.Axisplot,'Time [s]');
            ylabel(obj.Axisplot,'Acceleration [m/s^2]');
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
                if size(obj.matFileContent.time,1)~=1
                    error("the form of .time is wrong");
                else
                    if size(obj.matFileContent.data,2)<minimun_length
                        error("the length does not meet the requirement");
                    else
                        if length(obj.matFileContent.data)~= length(obj.matFileContent.time)
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

if obj.samplingRateHZ <=0
    error("the Sampling Rate is wrong");
else
    interval = 1/obj.samplingRateHZ;
end

extracted_data_time = obj.matFileContent.time(1):interval:objmatFileContent.time(end);
% adapt to new Hz
Extracted_data_X = interp1(obj.matFileContent.time,obj.matFileContent.data(1,:),extracted_data_time);
Extracted_data_Y = interp1(obj.matFileContent.time,obj.matFileContent.data(2,:),extracted_data_time);
Extracted_data_Z = interp1(obj.matFileContent.time,obj.matFileContent.data(3,:),extracted_data_time);
Extracted_whole_data=[Extracted_data_X;Extracted_data_Y;Extracted_data_Z];

% How many points do we need
point_number=obj.windowWidthSeconds*obj.samplingRateHZ;
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

obj.windowedData = data_cell;
%get the label
labels_structure = ones(data_number,1);
if contains(filename,'_N.mat')
   obj.labels = categorical(labels_structure,1,"Normal walk");
else
    obj.labels = categorical(labels_structure,1,"Silly walk");
end
end



%import classifyWalk
function  classifyWalk(obj,~,~)
% This is a trivial example for a classifier. It classifies any input as a
% normal walk.
    obj.YPred = categorical(repmat({'Normal walk'}, size(XTest)));
    predictions = predict(obj.model, XTest);
    for i=1:size(predictions,1)
        if predictions(i,1)<0.5
            obj.YPred(i)='Silly walk'; 
        else
            obj.YPred(i)='Normal walk';
        end   
    end
end




% import 
function evaluate(obj,~,~)
% compute the accuracy of the model
iscorrect = obj.YPred == obj.YTest;
obj.accuracy = sum(iscorrect)/numel(iscorrect);
% plot confusion chart
confusionchart(obj.YTest,obj.YPred,'Parent',obj.ConfusionMatrix)
if mode(obj.YPred) == 'Silly walk'
rgbImage = imread("silly.jpg");
imshow(rgbImage,obj.sillynormal)
else
rgbImage = imread("normal.jpg");
imshow(rgbImage,obj.sillynormal)
end



% Introduce reset function
        function clear_data(obj, ~, ~)
              clear
              GUI_main()     
        end


       
            % use imported model to classify
            function classification(obj, ~, ~) 
                tic    
                obj.extractData() %这里引入test集合
                obj.classifyWalk()
                obj.classification_runtime = toc;
                obj.evaluate()
                end
           


        end


    end
end