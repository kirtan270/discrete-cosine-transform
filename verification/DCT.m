% Input: impulse at n = 0 in Q1.15 (1.0)
x = [0.999969482421875, zeros(1, 15)];

% Length
N = 16;
X = zeros(1, N);

% DCT-II computation
for k = 0:N-1
    if k == 0
        alpha = sqrt(2)/N;
    else
        alpha = 0.125; % 1/8
    end
    
    sum_val = 0;
    for n = 0:N-1
        angle = pi / N * (n + 0.5) * k;
        sum_val = sum_val + x(n+1) * cos(angle);
    end
    X(k+1) = alpha * sum_val;
end

% Display output
disp('--- 16-point Manual DCT Output ---');
for k = 0:N-1
    fprintf('X[%2d] = %.10f\n', k, X(k+1));
end
