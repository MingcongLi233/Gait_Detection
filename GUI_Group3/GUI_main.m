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
                    'parent', obj.hp1,...);

                %obj.DataImportButton = uicontrol('Style', 'pushbutton','String', 'Import one walkdata', 'Units', 'normalized','Position', [0.15 0.05 0.15 0.9],'parent', obj.hp0, 'Callback',@obj.importData);
               
                % classify button
                obj.ClassifyButton = uicontrol('Style', 'pushbutton',...
                    'String', 'Classify',...
                    'Units', 'normalized',...
                    'Position', [0.1 0.3 0.4 0.2],...
                    'parent', obj.hp1,...
                    'FontWeight','bold',... 
                    'ForeGroundColor','#FFFFFF',...
                    'BackgroundColor','#0072BD',...);

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

            function modelImport(obj,~,~)
            model_filename = uigetfile('*.mat');
            obj.Trained_model = load(model_filename); %加载模型变量
            msgbox("The trained Model has been loaded!")
            obj.hp2.Visible = 'On';  % 此时再打开hp2的显示
            end   

            function TableEdit(obj, ~, ~)
            obj.GUI_dataset.DataMatrix = obj.Table.Data; %只要修改了table里的数据后，原本的数据就会跟着改变
        end
        end