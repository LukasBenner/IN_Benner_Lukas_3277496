classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
% Class Name: LinearRegressionDataFormatter
%
% Description: Class to model the training data for lineare regression model object
%
% Syntax:  myDatFormatter = LinearRegressionDataFormatter('Data','TempearatureMeasurement.mat','Feature','T3','CommandVar','T4');
%
% Other m-files required: LinearRegressionModel.m, GradientDescentOptimizer.mat
% Subfunctions: none
% MAT-files required: none
%
% See also: GradientDescentOptimizer, LinearRegressionModel
%
% Author: Lukas Benner
% Date: April 10, 2022

% ------------- BEGIN CODE --------------
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
           for i= 1:2:nargin
               switch varargin{i}
                   case 'Data'
                       data = load(varargin{i+1});
                       obj.data = data.measurement;
                   case 'Feature'
                       obj.featureName = varargin{i+1};
                   case 'CommandVar'
                       obj.commandVarName = varargin{i+1};
               end
           end
            
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end
end

