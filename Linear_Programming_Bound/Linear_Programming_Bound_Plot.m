function Linear_Programming_Bound_Plot

i = 1;
num_Files = 500;

maxY = zeros(1,num_Files);
minY = zeros(1,num_Files);

Count = zeros(1,num_Files);
Flag = zeros(1,num_Files);

Iteration = zeros(1,num_Files);

while(i<num_Files+1)
    fileName = sprintf('C:/Users/Jin Chung/Desktop/B1_Restructured/collisionDetectionMat/property%03d.mat',i);
    load(fileName,'-mat');
    
    [ymin, ymax] = Linear_Programming_Bound(W,b,xmin,xmax);
    
    maxY(1,i) = ymax;
    minY(1,i) = ymin;
    
    if(ymin<0&&ymax<0)
        Flag(1,i) = 1;
    elseif(ymin>0&&ymax>0)
        Flag(1,i) = 1;
    else
        Flag(1,i) = 0;
    end
    
    Iteration(1,i) = i;
    
    fprintf("%d Iterations Complete\n",i);

    i=i+1;
end

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% subplot(3,1,1);
% plot(Iteration,AveY);
subplot(2,1,1);
plot(Iteration,minY,'b--o',Iteration,maxY,'r--o');
ylabel({'Average Value of LB and UB'});
xlabel({'Iteration'});
title({'Graph of Averague Value of LB and UB against Iteration'});
hold on

subplot(2,1,2);
bar(Iteration,Flag,'b');
ylabel({'Number of Properties Proved'});
xlabel({'Iteration'});
title({'Number of Properties Proved against Iteration'});
hold on