%Group 3 Monty Matlab Wen Bing, Yueqiu Wang, Tianyuan Kong, Mingcong Li
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
        %initialisation
        function obj = GUI_start() 
            obj.createLayout();
            obj.Comment.String = ['Welcome to Silly Walk Detection Lab, do you want to know if your current gait is considered silly?'];
            imshow("silly2.jpg", 'Parent', obj.Axis);
            imshow("tumlogo.png", 'Parent', obj.tumlogo);
        end

        % createing Layout
        function createLayout(obj,~,~)
            obj.Gui_fig = figure('Name', 'MontyMatlab_Group03', ...
                'NumberTitle', 'off', ...
                'toolbar', 'none', ...
                'Menubar', 'none', ...
                'Units','normalized');
            obj.hp0 = uipanel('Units','normalized', ...
                'Position', [0.05 0.05 0.9 0.85], ...
                'Title','', 'Parent', ...
                obj.Gui_fig,'Visible','on');
            obj.Axis = uiaxes('Units', 'normalized',...
                'Position', [0.05 0.05 0.6 0.9],...
                'Parent', obj.hp0,'Visible','on');
            obj.Comment = uicontrol('Style','text',...
                'String',obj.textmsg,...
                'FontWeight','bold',...
                'FontSize',10,...
                'Units','normalized',...
                'Position',[0.68 0.6 0.3 0.3],...
                'Parent',obj.hp0, ...
                'Visible','on');
            obj.ImportButton = uicontrol('Style', 'pushbutton', ...
                'String', 'Sure! Import my gait!', ...
                'Units', 'normalized', ...
                'Position', [0.65 0.4 0.34 0.18], ...
                'Parent', obj.hp0, ...
                'Callback',@obj.importmyData);
            obj.GIFButton = uicontrol('Style', 'pushbutton', ...
                'String', 'How does Silly Walk look like?', ...
                'Units', 'normalized', ...
                'Position', [0.65 0.2 0.34 0.18], ...
                'parent', obj.hp0, ...
                'Callback',@obj.start_gifPlayerGUI);
            obj.Caption_title = uicontrol('Style','text',...
                'String','Welcome to Silly Walk Detection Lab!',...
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

       % Startup of the second GUI interface
        function importmyData(obj,~,~)
            GUI_main();
        end


       % Silly Walk Animation
        function start_gifPlayerGUI(obj,~,~)
            obj.gifPlayerGUI('SillyShow.gif')
        end

       % Setup of silly walk animation
        function gifPlayerGUI(obj, GIFname)
            info = imfinfo(GIFname, 'GIF');
            delay = ( info(1).DelayTime ) / 20;
            [img,map] = imread(GIFname, 'gif', 'frames','all');
            [imgH,imgW,~,numFrames] = size(img);
            hFig = figure();
            movegui(hFig,'center')
            hAx = axes('Parent',hFig, ...
            'Units','pixels', 'Position',[1 1 imgW imgH]);
            hImg = imshow(img(:,:,:,1), map, 'Parent',hAx);
            counter = 1;
            while ishandle(hImg)
                %Increment counter circularly
                counter = rem(counter, numFrames) + 1;
                set(hImg, 'CData',img(:,:,:,counter))
                %Pause for the specified delay
                pause(delay)
            end
         end
      end
  end