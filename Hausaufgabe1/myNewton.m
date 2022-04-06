function [xZero, abortFlag, iters] = myNewton(varargin)
% Function Name: myNewton
%
% Description: The Newton-Raphson Algorithm to find the zeros of a function.
%
% Syntax:  [xZero, abortFlag, iters] = myNewton(varargin)
%
% Inputs:
%    function - The function to find the zeros of. (required)
%    derivative - The derivative of the function provided for "function". (optional)
%    startValue - Start Value of the algorithm. (optional, default = 0)
%    maxIter - Maximum number of iterations. (optional, default = 50)
%    feps - Termination condition: Value of the function is in a range of 0+-feps. (optional, default = 1e-6)
%    xeps - Termination condition: Successive approximations are only marginally different. (optional, default = 1e-6).
%    livePlot - Show live plot of the algorithm. (optional, default = 'off')
%
% Outputs:
%    xZero - x Value where the function is zero.
%    abortFlag - Flag that holds the termination condition.
%    iters - Number of iterations.
%
% Example: 
%    myNewton('function', @myPoly)
%    myNewton('function', @myPoly, 'startValue', 10)
%    myNewton('function', @myPoly, 'startValue', 10, 'livePlot', 'on')
%    myNewton('function', @myPoly, 'derivative', @dmyPoly);
%
% Other m-files required: numDiff.m
% Subfunctions: none
% MAT-files required: none
%
% See also: numDiff, myPoly, dmyPoly
%
% Author: Lukas Benner
% Date: March 30, 2022

% ------------- BEGIN CODE --------------

%% do the varargin
for i = 1:nargin
    if strcmp(varargin{i},'function')
        func = varargin{i+1};
    elseif strcmp(varargin{i},'derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i},'startValue')
        x0 = varargin{i+1};
    elseif strcmp(varargin{i},'maxIter')
        maxIter = varargin{i+1};
    elseif strcmp(varargin{i},'feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i},'xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i},'livePlot')
        livePlot = varargin{i+1};   
    end
end

%% check for necessary parameters
if ~exist('func','var')
    error('No valid function');
end

if ~exist('x0','var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ',num2str(x0)]);
end

if ~exist('maxIter','var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ',num2str(maxIter)]);
end

if ~exist('feps','var')
    feps = 1e-6;
    disp(['Using default Feps: feps = ',num2str(feps)]);
end

if ~exist('xeps','var')
    xeps = 1e-6;
    disp(['Using default Xeps: xeps = ',num2str(xeps)]);
end

if ~exist('livePlot','var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ','off']);
end

if ~exist('dfunc','var')
    disp('Using a numerical approximation as the derivative!');
    diffClass = numDiff('function',func);
    dfunc = @diffClass.diff;
end

%% start of algorithm
if strcmp(livePlot,'on')
   h = figure('Name','Newton visualization');
   ax1 = subplot(2,1,1);
   plot(ax1,0,x0,'bo');
   ylabel('xValue');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
   ax2 = subplot(2,1,2);
   semilogy(ax2,0,func(x0),'rx');
   xlabel('Number of iterations')
   ylabel('Function value');
   hold on;
   grid on;
   xlim('auto')
   ylim('auto')
end
xOld = x0;
abortFlag = 'maxIter';
for i = 1:maxIter
    f = func(xOld);
    if abs(f) < feps
        abortFlag = 'feps';
        break;
    end
    df = dfunc(xOld);
    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld - f/df; 
    if abs(xNew-xOld) < xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew;
    if strcmp(livePlot,'on')
       plot(ax1,i,xNew,'bo');
       semilogy(ax2,i,func(xNew),'rx');
       pause(0.05);
    end
end
iters = i;
xZero = xNew;
end