% Group 3 Monty Matlab Wen Bing, Yueqiu Wang, Tianyuan Kong, Mingcong Li
classdef GUI_start < handle
    properties (Access = public)
        Gui_fig
        hp0
        Axis
        Comment
        textmsg
        ImportButton
        fileName
        GIFButton
        Caption_title
        tumlogo
    end 

    methods (Access = public)
        function obj = GUI_start() %initial
        obj.createLayout();
        obj.Comment.String = ['Welcome to SillyWalk Detection, do you want to know if your current gait is considered silly?'];
         imshow("silly2.jpg", 'Parent', obj.Axis);
         imshow("tumlogo.png", 'Parent', obj.tumlogo);
        end



        function createLayout(obj,~,~)
            obj.Gui_fig = figure('Name', 'MontyMatlab_Group03','NumberTitle', 'off','toolbar', 'none','Menubar', 'none','Units','normalized');
            obj.hp0 = uipanel('Units','normalized','Position', [0.05 0.05 0.9 0.85], 'Title','', 'Parent', obj.Gui_fig,'Visible','on');%总的panel面板
            obj.Axis = uiaxes('Units', 'normalized',...
                    'Position', [0.05 0.05 0.6 0.9],...
                    'Parent', obj.hp0,'Visible','on');
            obj.Comment = uicontrol('Style','text',...
                    'String',obj.textmsg,...
                    'FontWeight','bold',...
                    'FontSize',10,...
                    'Units','normalized',...
                    'Position',[0.7 0.7 0.25 0.2],...
                    'Parent',obj.hp0, ...
                    'Visible','on');
             
            
            obj.ImportButton = uicontrol('Style', 'pushbutton','String', 'Import my gait!!', 'Units', 'normalized','Position', [0.7 0.4 0.25 0.2],'parent', obj.hp0, 'Callback',@obj.importmyData);
            obj.GIFButton = uicontrol('Style', 'pushbutton','String', 'I want to learn silly walk!!', 'Units', 'normalized','Position', [0.7 0.2 0.25 0.2],'parent', obj.hp0, 'Callback',@obj.start_gifPlayerGUI);
            
            obj.Caption_title = uicontrol('Style','text',...
                    'String','Welcome to SillyWalk Detection Lab!',...
                    'FontWeight','bold',...
                    'FontSize',18,...
                    'Units','normalized',...
                    'Position',[0.05 0.90 0.815 0.1],...
                    'Parent',obj.Gui_fig, ...
                    'Visible','on'); 

            obj.tumlogo = uiaxes('Units', 'normalized',...
                    'Position', [0.855 0.9 0.1 0.12],...
                    'Parent', obj.Gui_fig,'Visible','on');
        end

        function importmyData(obj,~,~)
              GUI_main();
        end



        function start_gifPlayerGUI(obj,~,~)
            obj.gifPlayerGUI('SillyShow.GIF')
        end



         function gifPlayerGUI(obj, GIFname)
            info = imfinfo(GIFname, 'GIF');
            delay = ( info(1).DelayTime ) / 20;
            [img,map] = imread(GIFname, 'gif', 'frames','all');
            [imgH,imgW,~,numFrames] = size(img);

            %Prepare GUI, and show first frame
            hFig = figure();
            movegui(hFig,'center')
            hAx = axes('Parent',hFig, ...
            'Units','pixels', 'Position',[1 1 imgW imgH]);
            hImg = imshow(img(:,:,:,1), map, 'Parent',hAx);
            

            %pause(delay)
            %truesize(hFig)
            %Loop over frames continuously
            counter = 1;
            while ishandle(hImg)
                %Increment counter circularly
                counter = rem(counter, numFrames) + 1;
                set(hImg, 'CData',img(:,:,:,counter))
                %Pause for the specified delay
                pause(delay)
            end
 
        end