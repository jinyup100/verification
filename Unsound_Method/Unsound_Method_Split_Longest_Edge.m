function Unsound_Method_Split_Longest_Edge(maxValue)

% Initialise Variables
k = 1;                                                                      % Initialise k
num_Files = 500;                                                            % Total number of property files
K = zeros(1,maxValue);                                                      % Initialise 1*maxValue Matrix
Ave_T = zeros(1,maxValue);                                                  % Initialise 1*maxValue Matrix
Ave_Y = zeros(1,maxValue);                                                  % Initialise 1*maxValue Matrix
Total_Count = zeros(1,maxValue);                                            % Initiailise1*maxValue Matrix

while(k<maxValue+1)                                                         % Repeat for k<maxValue
    i = 1;                                                                  % Initialise y
    T = zeros(1,num_Files);                                                 % Initialise T
    Max_Y = zeros(1,num_Files);                             
    Count = zeros(1,num_Files);
    
    while(i<num_Files+1)
        fileName = sprintf('C:/Users/Jin Chung/Desktop/B1_Restructured/collisionDetectionMat/property%03d.mat',i);
        load(fileName,'-mat');
        
        [x_bar_min,x_bar_max] = Split_Longest_Edge(W,b,xmin,xmax,k);
        X = Generate_Inputs(x_bar_min,x_bar_max,k);                                   % k*6 Matrix
        
        tic;
        y = Compute_NN_Outputs(W,b,X);                                      % k*1 Vector
        t = toc;
        
        Max_Y(1,i) = max(y,[],'all');                                       % 1*500 Matrix filling in from 1
        
        % ave_count = length(nonzeros(Max_Y(Max_Y>0)));
        if(Max_Y(1,i)>0)
            Count(1,i) = 1;
        else
            Count(1,i) = 0;
        end
            
        T(1,i) = t;
        i = i+1; 
    end
    
    Ave_Y(1,k) = mean(Max_Y);
    % Ave_Count(1,k) = mean(Count);
    Total_Count(1,k) = sum(Count,'all');
    Ave_T(1,k) = mean(T);
 
    K(1,k) = k;
    fprintf("%d Iterations Complete\n",k);
    k = k+1;
end

% Create figures

%subplot(3,1,1);
figure(1);
plot(K,Ave_T);
set(gca,'FontSize',17);
ylabel({'Average Time'},'fontsize',20);
xlabel({'k'},'FontSize',20);
title({'Graph of k against Average Time'},'fontsize',23);
hold on

%subplot(3,1,2);
figure(2);
plot(K,Ave_Y);
set(gca,'FontSize',17);
ylabel({'Average Lower Bound for corresponding k'},'fontsize',20);
xlabel({'k'},'FontSize',20);
title({'Graph of k against Average Lower Bound for corresponding k'},'fontsize',23);

%subplot(3,1,3);
figure(3);
bar(K,Total_Count);
set(gca,'FontSize',17);
ylabel({'Number of Counter-Examples for corresponding k'},'fontsize',20);
xlabel({'k'},'FontSize',20);
title({'Number of Counter-Examples for corresponding k'},'fontsize',23);




