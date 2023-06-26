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
        obj.importData();
        model = load('Model.mat');
        obj.Trained_model = model.model;
                  tic    
                obj.extractData() %这里引入test集合
                obj.classifyWalk()
                obj.classification_runtime = toc;
                obj.evaluate()
        end

        %GUI layout
        function createLayout(obj,~,~)
                % GUI figure initialisation
                obj.Gui_fig = figure('Name', 'MontyMatlab_Group03','NumberTitle', 'off','toolbar', 'none','Menubar', 'none','Units', 'normalized');
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
                    'FontWeight','bold','Units','normalized',...
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
addpath("TrainingData");
addpath("TestData");

if obj.samplingRateHZ <=0
    error("the Sampling Rate is wrong");
else
    interval = 1/obj.samplingRateHZ;
end

extracted_data_time = obj.matFileContent.time(1):interval:obj.matFileContent.time(end);
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
if contains(obj.fileName,'_N.mat')
   obj.labels = categorical(labels_structure,1,"Normal walk");
else
    obj.labels = categorical(labels_structure,1,"Silly walk");
end

end



%import classifyWalk
function  classifyWalk(obj,~,~)
% This is a trivial example for a classifier. It classifies any input as a
% normal walk.
    obj.YPred = categorical(repmat({'Normal walk'}, size(obj.windowedData)));
    predictions = predict(obj.Trained_model, obj.windowedData);
    for i=1:size(predictions,1)
        if predictions(i,1)>0.5
            obj.YPred(i)='Silly walk'; 
        else
            obj.YPred(i)='Normal walk';
        end   
    end
end




% evaluate
function evaluate(obj,~,~)
% compute the accuracy of the model
iscorrect = obj.YPred == obj.labels;
obj.accuracy = sum(iscorrect)/numel(iscorrect)*100;
if mode(obj.YPred) == 'Silly walk'
imshow("silly2.jpg",'Parent',obj.sillynormal);
obj.textresult.String = 'Based on our experimental results, your gait is considered as silly, and we recommend reducing the amplitude of body sway.'
%obj.textresult2.String = 'The Time of classification is'+ num2str(obj.classification_runtime) + ' and the accuracy is' + num2str(obj.accuracy)
obj.textresult2.String="The accuracy is: "+num2str(obj.accuracy) + "%! The Time of classification is: " +num2str(obj.classification_runtime) + "s";
else
    
imshow("normal.jpg",'Parent',obj.sillynormal);
obj.textresult.String ='Congratulations! Based on our experimental results, your gait is considered normal. Please continue to maintain it!'
obj.textresult2.String="The accuracy is: "+num2str(obj.accuracy) + "%! The Time of classification is: " +num2str(obj.classification_runtime) + "s";
end


end

    function secondData(obj,~,~)
            clear
            GUI_main();
    end
end
    end