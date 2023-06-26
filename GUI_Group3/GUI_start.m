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
    end

    methods (Access = public)
        function obj = GUI_start() % Initial
            obj.createLayout();
            obj.Comment.String = ['Welcome to SillyWalk Detection. Do you want to know if your current gait is silly or not?'];
            imshow("silly2.jpg", 'Parent', obj.Axis);
        end

        function createLayout(obj, ~, ~)
            obj.Gui_fig = figure('Name', 'MontyMatlab_Group03', 'NumberTitle', 'off', 'Toolbar', 'none', 'Menubar', 'none');
            obj.hp0 = uipanel('Units', 'normalized', 'Position', [0.05 0.05 0.9 0.95], 'Title', 'SillyWalk Detection', 'Parent', obj.Gui_fig, 'Visible', 'on'); % Total panel
            obj.Axis = uiaxes('Units', 'normalized', 'Position', [0.05 0.05 0.7 0.9], 'Parent', obj.hp0, 'Visible', 'on');
            obj.Comment = uicontrol('Style', 'text', 'String', obj.textmsg, 'FontWeight', 'bold', 'FontSize', 12, 'Units', 'normalized', 'Position', [0.75 0.4 0.24 0.5], 'Parent', obj.hp0, 'Visible', 'on');
            obj.ImportButton = uicontrol('Style', 'pushbutton', 'String', 'Import my gait!!', 'Units', 'normalized', 'Position', [0.75 0.2 0.24 0.2], 'Parent', obj.hp0, 'Callback', @obj.importmyData);
        end

        function importmyData(obj, ~, ~)
            GUI_main();
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
    end
end