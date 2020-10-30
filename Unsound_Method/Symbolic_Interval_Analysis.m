
function [ymin,ymax,R] = Symbolic_Interval_Analysis(W,b,xmin,xmax)
 
numLayer = 5;
layerSize = 6;
R = cell(numLayer,layerSize);
eq_low = transpose(xmin);
eq_up = transpose(xmax);
 
i = 1; 
while(i<numLayer)
    Weight = W{i};
    posW = max(0,Weight);                                                    
    negW = min(0,Weight);
    
    eq_bar_up = posW*eq_up+negW*eq_low+b{i};
    eq_bar_low = posW*eq_low+negW*eq_up+b{i};
    
    [rowSize, ~] = size(Weight);
    
    eq_low = zeros(rowSize,1);
    eq_up = zeros(rowSize,1);
    
    if(rowSize ~= 1)
        j = 1;
        while(j<rowSize+1)
            if(eq_bar_up(j)<=0)
                A = [0 0];
                R(i,j) = {A};
                eq_up(j) = 0;
                eq_low(j) = 0;
                
            elseif(eq_bar_low(j)>=0)
                A = [1 1];
                R(i,j) = {A};
                eq_up(j) = eq_bar_up(j);
                eq_low(j) = eq_bar_low(j);
                
            else
                A = [0 1];
                R(i,j) = {A};
                eq_low(j) = 0;
                eq_up(j) = eq_bar_up(j);
            end
            j = j+1;
        end
    end
    i = i+1;
end
 
Weight = W{i};
posW = max(0,Weight);
negW = min(0,Weight);
 
eq_bar_up = posW*eq_up+negW*eq_low+b{i};
eq_bar_low = posW*eq_low+negW*eq_up+b{i};
 
[rowSize, ~] = size(Weight);
 
ymin = eq_bar_low;
ymax = eq_bar_up;