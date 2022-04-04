classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            for i= 1:2:nargin
               switch varargin{i}
                   case 'Data'
                       obj.trainingData = varargin{i+1};
                   case 'Optimizer'
                       obj.optimizer = varargin{i+1};
               end
            end
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples;
            hypothesis =  obj.hypothesis();
            delta = hypothesis - obj.trainingData.commandVar;
            deltaSqare = power(delta,2);
            J = sum(deltaSqare) / (2 * m);
        end

        function costs = costsFunction(obj, theta0_vals, theta1_vals)
            costs = zeros(size(theta0_vals,2),size(theta1_vals, 2));
            for i = 1:size(theta0_vals,2)
                for j = 1:size(theta1_vals,2)
                    obj.theta = [theta0_vals(i); theta1_vals(j)];
                    costs(j,i) = obj.costFunction();  
                    % cost(j,i) is cost(row, column)
                    % and not cost(row, column) like for pictures
                end
            end
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            hValue = X * obj.theta;
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            
            costs = obj.costsFunction(theta0_vals, theta1_vals);
            contour(theta0_vals, theta1_vals, costs);
            hold on
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'rx', 'LineWidth',2, 'MarkerSize',10);
            hold off
            xlabel('\theta_0');
            ylabel('\theta_1');
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);

            % ========= YOUR CODE HERE =========
            costs = obj.costsFunction(theta0_vals, theta1_vals);
            surf(theta0_vals, theta1_vals, costs);
            xlabel('\theta_0');
            ylabel('\theta_1');
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           % add the final trained model plot to the figure ('b-')
           % update the legend
           hold on
           x = obj.trainingData.feature;
           y = obj.thetaOptimum(1) + x * obj.thetaOptimum(2); 
           plot(x,y,'b-');
           hold off
           legend('Training Data','Linear Regression Model');
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end


