function [ymin,ymax] = Linear_Programming_Bound(W,b,xmin,xmax)

rows_ = {};
cols_ = {};
I_ = cell(1,5);
for k = 1:5
    W_{k} = W{k};
    siz = size(W_{k});
    rows_{k} = siz(1);
    cols_{k} = siz(2);
    I_{k} = eye(rows_{k});
end
 
% initialise variables
input_size = length(xmin);
rows_0 = input_size;

z_hat_min = {xmin'};
z_hat_max = {xmax'};

% compute layer outputs from 1 to 5
for k = 1:5
    
    [A,B] = find_ineq(k,I_,rows_,z_hat_max,z_hat_min,rows_0);
    [Aeq,Beq] = find_eq(k,I_,W_,b);
    [lb,ub] = find_bounds(k,rows_,xmin,xmax,z_hat_min,z_hat_max);
        
    len_layer = length(b{k});
    z_hat_min{k+1} = [zeros(len_layer, 1); z_hat_min{k}]';
    z_hat_max{k+1} = [zeros(len_layer, 1); z_hat_max{k}]';
    
    options = optimoptions('linprog','Display','none');
    for n = 1:len_layer
        len_f = length(lb);
        f = find_coeff(len_f,n);
        
        x_min = linprog(f,A,B,Aeq,Beq,lb,ub,options);
        z_hat_min{k+1}(n) = x_min(n);
        
        f = -f;
        x_max = linprog(f,A,B,Aeq,Beq,lb,ub,options);
        z_hat_max{k+1}(n) = x_max(n);
    end
    
    z_hat_min{k+1} = z_hat_min{k+1}';
    z_hat_max{k+1} = z_hat_max{k+1}';
    
end

ymin = z_hat_min{6}(1);
ymax = z_hat_max{6}(1);
end

% set up bounds
function [lb,ub] = find_bounds(k,rows_,xmin,xmax,z_hat_min,z_hat_max)

lb_{1} = xmin';
ub_{1} = xmax';
lb_{2*k} = -Inf*ones(rows_{k},1);
ub_{2*k} = +Inf*ones(rows_{k},1);

for i = 2:k
    sizzle = length(z_hat_min{i}) - length(z_hat_min{i-1});
    zhat_max{i} = z_hat_max{i}(1:sizzle);
    zhat_min{i} = z_hat_min{i}(1:sizzle);
    
    lb_{2*i-2} = zhat_min{i};
    ub_{2*i-2} = zhat_max{i};
    lb_{2*i-1} = max(zhat_min{i},0);
    ub_{2*i-1} = max(zhat_max{i},0);
end

lb_ = flip(lb_);
ub_ = flip(ub_);
lb = vertcat(lb_{:});
ub = vertcat(ub_{:});
end


% set up inequality A and b
function [A,B] = find_ineq(k,I_,rows_,z_hat_max,z_hat_min,rows_0)
    A_centre_bit = {};
    B_ = {};

    for n = 2:k
        M = find_M(rows_,z_hat_max,z_hat_min,n);
        c = find_c(rows_,z_hat_max,z_hat_min,n);

        for i = 2:n
            if isempty(M{i})
                M{i} = zeros(length(I_{n-1}));
            end
            if isempty(c{i})
                c{i} = zeros(length(rows_{n-1}),1);
            end
        end

        B_{n} = [zeros(2*rows_{n-1}, 1); c{n}];

        A_centre_bit{n} = [-I_{n-1}, zeros(rows_{n-1}); 
                             -I_{n-1}, I_{n-1}; 
                             I_{n-1}, -M{n}];
                         
    end

    % compute central diagonal matrix for A
    A_centre_bit = flip(A_centre_bit);
    A_centre = blkdiag(A_centre_bit{:});
    [A_rows, ~] = size(A_centre);
    
    % compute side columns of zeros for A
    A_lhs = zeros(A_rows, rows_{k});
    A_rhs = zeros(A_rows, rows_0);

    % combine to compute inequality matrix A
    A = [A_lhs, A_centre, A_rhs];

    % combine to compute inequality matrix B
    B_ = flip(B_);
    B = vertcat(B_{:});
end


% compute m
function M = find_M(rows_,z_hat_max,z_hat_min,k) 
    zhat_max = z_hat_max{k}(1:rows_{k-1});
    zhat_min = z_hat_min{k}(1:rows_{k-1});
    m = zhat_max./(zhat_max - zhat_min);
    m = min(max(m,0),1);
    M{k} = diag(m);
end


% compute c
function c = find_c(rows_,z_hat_max,z_hat_min,k)
    zhat_max = z_hat_max{k}(1:rows_{k-1});
    zhat_min = z_hat_min{k}(1:rows_{k-1});
    m = zhat_max./(zhat_max - zhat_min);
    m = min(max(m,0),1);
    c_ = -m .* zhat_min;
    c{k} = max(c_,0);                      
end


% set up equality Aeq and beq
function [Aeq,Beq] = find_eq(k,I_,W_,b)    
    diag_bit = {};
    for n = 1:k
        diag_bit{n} = [I_{n}, -W_{n}];
    end
    diag_bit = flip(diag_bit);
    Aeq = blkdiag(diag_bit{:});
    Beq = vertcat(b{k:-1:1});

end


% find lin prog f
function f = find_coeff(length_f,n)
    f = zeros(length_f,1); % make f a column vector as linprog takes its transpose
    f(n) = 1;
end