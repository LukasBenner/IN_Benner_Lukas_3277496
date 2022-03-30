classdef numDiff < matlab.mixin.SetGet
% Class Name: numDiff
%
% Description: A class to calculate the numerical dericative of a function.
%
% Syntax:  myDiffClass = numDiff('function', aFunction)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: myNewton, myPoly, dmyPoly, numDiff/diff
%
% Author: Lukas Benner
% Date: March 30, 2020

% ------------- BEGIN CODE --------------

    properties (Access=private)
        func
        diffMethod
    end
    
    methods
        function obj = numDiff(varargin)
        % Constructor for the class numDiff.
        %
        % Inputs:
        %    function - The function to calculate the derivative for. (required)
        %
        % Syntax:  myDiffClass = numDiff('function', aFunction)
        %
        % See also: numDiff
        %
        % Author: Lukas Benner
        % Date: March 30, 2020
        
        % ------------- BEGIN CODE --------------
            for i = 1:nargin
                if strcmp(varargin{i},'function')
                    obj.func = varargin{i+1}; 
                end
            end
            obj.diffMethod = obj.getDiffDirection();
        end
        
        function dy = diff(obj, x)
        % Calculates the numerical derivative of the function specified when the class was created, at a point x.
        %
        % Inputs:
        %    x - The x Value to calculate the derivative at. (required)
        %
        % Syntax:  dy = myDiffClass.diff(x)
        %
        % Example: 
        %    dy = myDiffClass.diff(5)
        %
        % See also: numDiff
        %
        % Author: Lukas Benner
        % Date: March 30, 2020

        % ------------- BEGIN CODE --------------
            switch obj.diffMethod
                case 'forward'
                    dy = obj.diffForward(x);
                case 'backward'
                    dy = obj.diffBackward(x);
                case 'central'
                    dy = obj.diffCentral(x);
                otherwise
                    error('No valid direction for numeric method!');
            end
        end
    end
    
    methods (Access=private)
        function dy = diffForward(obj,x)
            hForward = 1e-8;
            dy = (obj.func(x + hForward) - obj.func(x)) / hForward;
        end
        function dy = diffBackward(obj,x)
            hBackward = 1e-8;
            dy = (obj.func(x) - obj.func(x - hBackward)) / hBackward;
        end
        function dy = diffCentral(obj,x)
            hCentral = 1e-6;
            dy = (obj.func(x + hCentral) - obj.func(x - hCentral)) / (2 * hCentral);
        end
    end

    methods (Static, Access=private)
        % This method has to be static because it is used in the
        % constructor of the class
        function direction = getDiffDirection()
            answer = questdlg('Which numerical method do you want to use?', ...
	            'Numerical differentiation', ...
	            'Forward differences','Backward differences','Central differences','Forward differences');
            % Handle response
            switch answer
                case 'Forward differences'
                    direction = 'forward';
                case 'Backward differences'
                    direction = 'backward';
                case 'Central differences'
                    direction = 'central';
                otherwise
                    error('User closed the dialog window!');
            end
            disp(['Using the method of "', answer, '".']);
        end
    end
end

