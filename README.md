# 3-Stage Single Precision Floating-Point-Adder-Design

The Single Precision representation can be done using 32 bits, where the first bit is used to represent the sign of the number, the next 8 bits are used to represent the exponent of the number added to the bias and the remaining 23 bits are used for the mantissa.

The 3-stage single precision floating point adder in design divides the whole process into three parts: Mantissa Alignment, Mantissa Addition and Normalization.
