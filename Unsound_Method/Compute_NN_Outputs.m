function y = Compute_NN_Outputs(W,b,X)

% Initialise Variables
i = 1;
L = 5;

X = transpose(X);

while(i<L)
    Y = W{i}*X+b{i};
    Y = max(0,Y);
    X = Y;
    i = i+1;
end

y = W{i}*X+b{i};

y = transpose(y);


