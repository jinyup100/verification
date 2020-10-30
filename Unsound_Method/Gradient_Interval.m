function [g_low,g_up] = Gradient_Interval(W,b,xmin,xmax,R)

numLayer = 5;
Weight = W{numLayer};               % 1 x 19

g_up = Weight;                      % 1 x 19
g_low = Weight;                     % 1 x 19

i = numLayer-1;
while(i>0)
    j = 1;
    [~, columnSize] = size(Weight);    % columnSize = 19;
    while(j<columnSize+1)
        r = cell2mat(R(i,j));
        g_low(j) = r(1)*g_low(j);
        g_up(j) = r(2)*g_up(j);
        j = j+1;
    end
    
    Weight = W{i};                  % 19 x 38
    posW = max(0,Weight);
    negW = min(0,Weight);
    g_low_new = g_up*negW+g_low*posW;
    g_up_new = g_up*posW+g_low*negW;
    
    g_low = g_low_new;
    g_up = g_up_new;
    
    i = i-1;
end

g_low = transpose(g_low);
g_up = transpose(g_up);