function X = Generate_Inputs(xmin, xmax, k)
% Summary of this function goes here
% Detailed explanation goes here

% Initialise Variables
i = 1;

% Initialise an output matrix
X = zeros(k,6);

% For k+1 number of columns
while(i<k+1)
    % For 6 number of rows
    j= 1;
    while(j<7)
        % Assign a random value between xmin and xmax to the ith column and
        % jth row of the output matrix
        X(i,j) = xmin(j)+((xmax(j)-xmin(j))*rand(1));
        j = j+1;
    end
    i = i+1;
end