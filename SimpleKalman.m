%{
Author: Shlok Sobti
Written for KCL Solutions

This script serves as an implementation of a simple 
Polynomial Kalman Filter as per the example in the 
book ?Fundamentals of Kalman Filtering: A Practical
Approach? (Page 632 - 642).
%}

clear all;
close all;

% Initialize Matrices
x_h = [0;0;0]; % Initialize Estimated State
T_s = 1; % Time Step
phi = [1  T_s (0.5*T_s^2); 
       0   1      T_s  ;
       0   0       1   ]; % Co-Variance Matrix
   
P =  diag([9223372036854775807, 9223372036854775807, 9223372036854775807]); % Covariance Matrix P
H = [1 0 0]; % Measuring Matrix
sigNoise = 50; % Noise
R = sigNoise^2; 
phi_s = 1; % Based on experiments
Q = phi_s*[T_s^5/20 T_s^4/8 T_s^3/6;
           T_s^4/8  T_s^3/3 T_s^2/2;
           T_s^3/6  T_s^2/2 T_s]; % Covariance Matrix
w = 1; 
x_lose = 100; % Simulation of lost data
i = 1;

for t=0:T_s:200
    if t>x_lose
        R = 9223372036854775807;
    end
    x = [100*t - (20*cos(w*t)) + 20/w;
         100 + 20*sin(w*t);
         20*w*cos(w*t)]; % Actual State Vector
     
    actualPos(i) = x(1); % Populate Actual Position Matrix (useful to plot)
    z(1) = x(1) + normrnd(0,50); % Gaussian noise
    
    % Kalman Filter
    M = phi*P*phi' + Q;
    K = M*H'*inv(H*M*H' + R);
    P = (eye(3)-K*H)*M;
 
    x_h = phi*x_h + K*(z(1)-H*phi*x_h); % Update
    
    % Save for Later - Plotting Purposes
    measuredPos(i) = z(1);
    estimatedPos(i) = x_h(1);
    errorPos(i) = sqrt(x(1)-x_h(1))^2;
    time(i) = t;
    i = i+1;
end

% Visualize Results
hold on;
axis([0 200 0 20000])
plot(time, estimatedPos, '--');
plot(time, actualPos, '-');
title('Estimated vs Actual Trajectory - Simple Kalman Filter')
xlabel('Time (seconds)')
ylabel('Position (Ft)')
legend('Estimated', 'Actual');

figure()
plot(time, errorPos, '-')
title('Position Error (Ft) - Simple Kalman Filter')
xlabel('Time (seconds)')
ylabel('Position Error')



