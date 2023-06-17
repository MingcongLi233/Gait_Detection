%Group 3 Monty Matlab Wen Bing, Yueqiu Wang, Tianyuan Kong, Mingcong Li
classdef GUI_main < handle
    properties (Access = public)
        TimeVector
        DataMatrix 
    end

    properties (Access = public, SetObservable, AbortSet)
        GUI_dataset
        end   


    methods (Access = public)
        function obj = GUI_main(); %initial
        obj.createLayout();
        end

        end