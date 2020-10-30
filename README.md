# Formal Verification of Neural Networks

### Overview
Supervisor : Pawan Kumar   
Student : Jin Yeob Chung @jinyup100

### Introduction
Advances in deep learning have led to a wide implementation of neural networks in addressing complex real-wrold problems such as sppech recognition and image classification. In recent years, however, as the adversarial networks has proved to show, it has been observed that DNNs can react in an unexpected and incorrect ways to even the slightest perturbation of their inputs unnoticeable to the human eye. In the context of safety-critical applications such as autonomous cars, adversarial attacks can be targeted on vehicles where sticks and paint used to generate an adversarial stop sign that the vehicles can misinterpret for another sign.

In the wake of such dangers, a greater emphasis has been placed on developing means to formally verify the correctness of the nerual systems. With recent interest in the interpretability of neural networks, the purpose of this project is to devise an algorithmic framework that accurately calculates the lower and upper bounds on the outputs of a toy neural network, and eventually on the real network trained on the ACAS dataset. Specifically, the main contributions of this dissertation are:

1) Design of the Branch and Bound Framework
2) Analysis of the Branching Methods including Random Splitting, Gradient Interval Splitting, and Splitting along Long Edge
2) Analysis of the Bounding Methods including Unsound Method, Interval Bound Propagation Method, Linear Programming Method and Mixed Integer Programming Methods

### Details of the Subdomain Partitioning Branch Methods
```matlab
Unsound_Method_Random_Split(maxValue) % where maxValue refers to the number of random samples we take from our calculated interval range
```
The Branch Strategy exploits the piecewise lienar property and bisections the input sub-domain that generates the greatest upper bound into subdomains X1 and X2. The bisection of the input sub-domain with the greatest upper bound is iterated continually to create tighter bounds of the output z. In Unsound_Method_Random_Split, "maxValue" number of random samples are taken from each sub-domain to find the upper bound.

```matlab
Unsound_Method_Random_Split(maxValue) % where maxValue refers to the number of random samples we take from our calculated interval range
```
One common way is to implement the function to split the longest edge of the input domain. Assuming the piecewise linear property, the function partitions the input domain into subdomain by computing s(i) and j and effectively look for the element with the longest relative length. 

```matlab
Unsound_Method_Random_Split(maxValue) % where maxValue refers to the number of random samples we take from our calculated interval range
```
The final branch strategy is to split the input domain according to the computed value of the gradient interval. For this particular strategy, the Jacobian matrix of the output z with respect to each element of the input is computed. In theory, gradient interval can be calculated by differentiating z with respect to each interval.  The problem however rises with the presence of the RELU activation function and thus the number of layers and layer size has to be taken into account.

### Details of the Bounding Strategy
Unsound_Method_Random_Split(maxValue) % where maxValue refers to the number of random samples we take from our calculated interval range
```
The final branch strategy is to split the input domain according to the computed value of the gradient interval. For this particular strategy, the Jacobian matrix of the output z with respect to each element of the input is computed. In theory, gradient interval can be calculated by differentiating z with respect to each interval.  The problem however rises with the presence of the RELU activation function and thus the number of layers and layer size has to be taken into account.
