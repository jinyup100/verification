function [ymin, ymax] = Interval_Bound_Propagation(W,b,xmin,xmax)

% Initialise Variables
i = 1;                                                                      % Repeat Variable
L = 5;                                                                      % Repeat Length

% Initialise Inputs
zmax = transpose(xmax);                                                     % 6*1 Matrix
zmin = transpose(xmin);                                                     % 6*1 Matrix

% Repeat Over 
while(i<L)
    posW = max(0,W{i});                                                     % 40*6 Matrix                                                     
    negW = min(0,W{i});                                                     % 40*6 Matrix 
    
    zmax_new = posW*zmax+negW*zmin+b{i};                             
    zmin_new = posW*zmin+negW*zmax+b{i}; 
    
    zmax = max(0,zmax_new);
    zmin = max(0,zmin_new);
    
    i = i+1;
end

posW = max(0,W{i});
negW = min(0,W{i});

ymax = posW*zmax+negW*zmin+b{i};
ymin = negW*zmin+negW*zmax+b{i};