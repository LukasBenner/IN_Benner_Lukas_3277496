[result, abortFlag, iters]  = myNewton('function', @myPoly, 'startValue', 10, 'livePlot', 'on');
%% runMyNewton: 
% runs the Newton-Raphson Algorithm
%
% See also: myNewton, numDiff, myPoly, dmyPoly
% Author: Lukas Benner
% Date: April 6, 2022