%{
Author: Shlok Sobti
Written for KCL Solutions

This script serves as an implementation of a 
Polynomial Kalman Filter to accomodate for sensor fusion,
as per the example in the book ?Fundamentals of 
Kalman Filtering: A Practical Approach? (Page 632 - 642).
%}

clear all;
close all;

% Initilize Matrices/Scalars
phi = 1; %Co-Variance
phi_s = 10; %From Experiments
T_s = 1; % Time Stamp
Q = phi_s * T_s; % Covariance Matrix
sigGPS = 50; % GPS Noise
R = sigGPS^2;
w = 0.1;
actualBias = 1;
bias_h = 1;
P = 1000000; % Initialize to High Value
x_lose = Inf;
i =1;
for t = 0:T_s:200
    if t>x_lose
        R = Inf;
    end
    H = 0.5*t^2;
    M = phi*P*phi' + Q;
    K = M*H'*inv(H*M*H' + R);
    P = (1-K*H)*M;
    x = [100*t - (20*cos(w*t)) + 20/w;
         100 + 20*sin(w*t);
         20*w*cos(w*t)]; % Actual State Vector
     
    % Measured GPS and INS
    z_GPS(1) = x(1) + normrnd(0,sigGPS);
    z_INS(1) = x(1) + 0.5*actualBias*t^2;
    
    z_delta = z_INS - z_GPS; 
    bias_h = bias_h + K*(z_delta - 0.5*bias_h*t^2); % Updated Bias
    bias_error = actualBias-bias_h;
    x_h = z_INS - 0.5*bias_h*t^2;
    
    errorPos(i) = x(1)-x_h(1);
    bias_plot(i) = bias_h(1);
    estimatedPos(i) = x_h(1);
    time(i) = t;
    i = i+1;
    
end

% Visualization
hold on;
plot(time, bias_plot, '-');
plot(time, actualBias*ones(length(time),1));
xlim([0 200])
ylim([0 2.0])
title('Bias - Aided Kalman Filter')
xlabel('Time (seconds)')
ylabel('Bias (Ft/Sec^2)')
legend('Estimated Bias', 'Actual Bias')
