from sympy import *

x = Symbol('x')

a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))

function1 = input("Input the first function: ")
function2 = input("Input the second function: ")

num_of_Intervals = float(input('Input the number of intervals: '))

delta_x = ((b-a)/num_of_Intervals)

def riemann_Sum():
    n=0
    leftsum= 0.0
    x = a #set x to start at the left interval
    riemann_sum_type = 'left'
    if (riemann_sum_type == 'left'):
        while n < abs(num_of_Intervals):
            #change in area = y-value of function * width of interval
            f1_x = eval(function1)
            f2_x = eval(function2)
            height_of_interval = abs(f1_x - f2_x)
            delta_A = height_of_interval * delta_x
            x = x + delta_x #increment to the next x-interval
            leftsum = leftsum + delta_A #add to the sum
            n = n+1
        return leftsum


print(riemann_Sum())
