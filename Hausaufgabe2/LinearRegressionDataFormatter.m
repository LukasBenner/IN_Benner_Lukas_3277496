classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    %DATAPRERPERATOR Class to model the training data for lineare
    %regression model object
   
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
            %DATAPRERPERATOR Construct an instance of this class
            
            % ========= YOUR CODE HERE =========

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

