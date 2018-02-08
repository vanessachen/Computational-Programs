from sympy import *
import math

x = Symbol('x')

a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))

function1 = input("Input the first function: ")
function2 = input("Input the second function: ")

num_of_Intervals = float(input('Input the number of intervals: '))
riemann_sum_type = input('Input "left", "trapezoidal", or "right" to calculate the type of Riemann Sum Approximation: ')
print ("Options for 3D shape: 'square', 'equilateral triangle', 'isosceles right triangle', and 'semicircle'")
shape_3D = input('Input the 3D shape that extends from the base - the area between two curves: ')


delta_x = ((b-a)/num_of_Intervals)

def riemann_Sum(riemann_sum_type):
    n=0
    leftsum= 0.0
    rightsum = 0.0
    trapezoidalsum = 0.0
    x = a #set x to start at the left interval

    if (riemann_sum_type == 'left'):
        while n < abs(num_of_Intervals):
            #change in area = y-value of function * width of interval
            f1_x = eval(function1)
            f2_x = eval(function2)
            height_of_interval = abs(f1_x - f2_x)
            if (shape_3D == 'square'):
                delta_A = (height_of_interval)**2 * delta_x #squaring the base
            elif (shape_3D == 'equilateral triangle'):
                #area of equilateral triangle is: (((3)**2)/4) * s**2
                delta_A = (((3)**2)/4) * (height_of_interval)**2 * delta_x
            elif (shape_3D == 'isosceles right triangle'):
                #area of isosceles right triangle is: .5 * base**2
                delta_A = .5 * (height_of_interval)**2 * delta_x
            elif (shape_3D == 'semicircle'):
                #area of semicircle is: .5 * pi * (r)**2
                delta_A = .5 * math.pi * (height_of_interval/2)**2 * delta_x
            #delta_A = height_of_interval * delta_x
            x = x + delta_x #increment to the next x-interval
            leftsum = leftsum + delta_A #add to the sum
            n = n+1
        return leftsum
    elif (riemann_sum_type == 'right'):
            #n=1
        x = x + delta_x #incrementing x before the first evaluation to shift by 1 interval to calculate right approx
        while n < abs(num_of_Intervals):
            f1_x = eval(function1)
            f2_x = eval(function2)
            height_of_interval = abs(f1_x - f2_x)
            if (shape_3D == 'square'):
                delta_A = (height_of_interval)**2 * delta_x #squaring the base
            elif (shape_3D == 'equilateral triangle'):
                #area of equilateral triangle is: (((3)**2)/4) * s**2
                delta_A = (((3)**2)/4) * (height_of_interval)**2 * delta_x
            elif (shape_3D == 'isosceles right triangle'):
                #area of isosceles right triangle is: .5 * base**2
                delta_A = .5 * (height_of_interval)**2 * delta_x
            elif (shape_3D == 'semicircle'):
                #area of semicircle is: .5 * pi * (r)**2
                delta_A = .5 * math.pi * (height_of_interval/2)**2 * delta_x
            #delta_A = height_of_interval * delta_x
            x = x + delta_x #increment to the next x-interval
            rightsum = rightsum + delta_A #add to the sum
            n = n+1
        return rightsum
    elif (riemann_sum_type == 'trapezoidal'):
        leftsum = riemann_Sum('left')
        rightsum = riemann_Sum('right')
        return (leftsum+rightsum)/2 #the trapezoidal sum is the average of leftsum and rightsum

print(riemann_Sum(riemann_sum_type))
