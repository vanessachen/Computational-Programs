from sympy import *

x = Symbol('x')

function = input("Input a function: ")
derivative_num = int(input("Input which order of derivative: "))

antiderivative = integrate(function)
derivative =  diff(function, x, derivative_num)

print("This is the antiderivative: {}".format(antiderivative))
print("This is the {} order derivative: {}".format(derivative_num,derivative))
