#import random as r

#print(r.random())

from sympy import *

x = Symbol('x')

a = float(input('Input the starting value: '))
b = int(input('Input the ending value: '))

function_str = input("Input a function: ")

#integral_str = integrate(function_str)

function = (lambda x: eval(function_str))
integral = integrate(function(b))

print(integral)

#test = ((lambda x: eval(integral_str)))
#print(test)
