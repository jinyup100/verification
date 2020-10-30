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

### Details of the Splitting Methods
```matlab
Unsound_Method_Random_Split(
```
