# Polynomial-Kalman-Filter-Implementation
This repository contains code for implementations of a simple Kalman Filter as well as an implementation to facilitate aiding between GPS and INS. This implementation has been derived from the example outlined in the book, “Fundamentals of Kalman Filtering: A Practical Approach" (Page 632 - 642).

## Simple Kalman Filter
This filter is a three-state polynomial Kalman filter used to track a vehicle's position. We are assuming in this example that GPS is providing the vehicle location corrupted by zero-mean Gaussian noise with a standard deviation of 50 ft. The exact parameters can be found in the cited textbook.
![alt text](screenshots/filename.png "Description goes here")

