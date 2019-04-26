# Polynomial-Kalman-Filter-Implementation
This repository contains code for implementations of a simple Kalman Filter as well as an implementation to facilitate aiding between GPS and INS. This implementation has been derived from the example outlined in the book, “Fundamentals of Kalman Filtering: A Practical Approach" (Page 632 - 642).

## Simple Kalman Filter
This filter is a three-state polynomial Kalman filter used to track a vehicle's position. We are assuming in this example that GPS is providing the vehicle location corrupted by zero-mean Gaussian noise with a standard deviation of 50 ft. The exact parameters can be found in the cited textbook.

<p align="center">
  <img src="https://github.com/shloksobti/Polynomial-Kalman-Filter-Implementation/blob/master/Screenshots/SimpleKalman1.png" width="512" title="Simple Kalman Filter with lost data points">
</p>

The above screenshot is a simulated result of using a simple Kalman filter, with 100 lost data points. One can see that as long as GPS data is available the kalman filter estimation is good; however, when data is unavailable, the the estimation becomes drastically unreliable. This is seen more clearly in the error plot below.

<p align="center">
  <img src="https://github.com/shloksobti/Polynomial-Kalman-Filter-Implementation/blob/master/Screenshots/SimpleKalman2.png" width="512" title="Simple Kalman Filter with Lost Data Points - Position Error">
</p>



