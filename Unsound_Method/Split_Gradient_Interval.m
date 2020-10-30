function [x_bar_min,x_bar_max] = Split_Gradient_Interval(W,b,xmin,xmax,k)

x_bar_min = xmin;
x_bar_max = xmax;

Box_Constraints = cell(1,2);
Y = zeros(1,1);

Box_Constraints(1,1) = {x_bar_min};
Box_Constraints(1,2) = {x_bar_max};

X = Generate_Inputs(xmin,xmax,1);
y = Compute_NN_Outputs(W,b,X);

Y(1,1) = y;

i = 1;
vSize = 2;
while(i<k)
    [maxValue,indexY] = max(Y);
    
    x_bar_min = Box_Constraints(indexY,1);
    x_bar_min = cell2mat(x_bar_min);
    x_bar_max = Box_Constraints(indexY,2);
    x_bar_max = cell2mat(x_bar_max);
    
    [~,~,R] = Symbolic_Interval_Analysis(W,b,x_bar_min,x_bar_max);
    [~,g_up] = Gradient_Interval(W,b,x_bar_min,x_bar_max,R);
    indexS = Input_Split(x_bar_min,x_bar_max,g_up);
    
    S = zeros(6,1);
    j = 1;
    while(j<7)
        S(j) = (x_bar_max(j)-x_bar_min(j))/(xmax(j)-xmin(j));
        j = j+1;
    end
    [~,indexS] = max(S);
    
    j = 1;
    
    x_1_bar_min = zeros(1,6);
    x_1_bar_max = zeros(1,6);
    x_2_bar_min = zeros(1,6);
    x_2_bar_max = zeros(1,6);
    
    while(j<7)
        x_1_bar_min(j) = x_bar_min(j);
        x_2_bar_max(j) = x_bar_max(j);
        
        if(j ~= indexS)
            x_1_bar_max(j) = x_bar_max(j);
            x_2_bar_min(j) = x_bar_min(j);
        else
            x_1_bar_max(j) = x_bar_min(j) + (x_bar_max(j) - x_bar_min(j))/2;
            x_2_bar_min(j) = x_bar_min(j) + (x_bar_max(j) - x_bar_min(j))/2;
        end
        j = j+1;
    end
    X1 = Generate_Inputs(x_1_bar_min, x_1_bar_max, i);
    X2 = Generate_Inputs(x_2_bar_min, x_2_bar_max, i);
    y1 = Compute_NN_Outputs(W,b,X1);
    y2 = Compute_NN_Outputs(W,b,X2);
    
    [row1,~] = size(Y);
    New_Y = zeros(row1+1,1);
    New_Y(1:indexY-1,1) = Y(1:indexY-1,1);
    New_Y(indexY) = max(y1);
    New_Y(indexY+1) = max(y2);
    New_Y(indexY+2:row1+1) = Y(indexY+1:row1);
 
    New_Box_Constraints = cell(vSize,2);
    [row2,~] = size(Box_Constraints);
    New_Box_Constraints(1:indexY-1,1:2) = Box_Constraints(1:indexY-1,1:2);
    New_Box_Constraints(indexY,1) = {x_1_bar_min};
    New_Box_Constraints(indexY,2) = {x_1_bar_max};
    New_Box_Constraints(indexY+1,1) = {x_2_bar_min};
    New_Box_Constraints(indexY+1,2) = {x_2_bar_max};
    New_Box_Constraints(indexY+2:row2+1,1:2) = Box_Constraints(indexY+1:row2,1:2);
    
    Y = New_Y;
    Box_Constraints = New_Box_Constraints;
    
    i = i+1;
end

[maxValue,indexY] = max(Y);

x_bar_min = Box_Constraints(indexY,1);
x_bar_min = cell2mat(x_bar_min);
x_bar_max = Box_Constraints(indexY,2);
x_bar_max = cell2mat(x_bar_max);



