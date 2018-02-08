# Calcuate the volume of a shape when rotating a function around the y-axis along the interval 'a' to 'b'
#from pynverse import inversefunc
from sympy import *
import math
from sympy.plotting import plot
from sympy.plotting import plot3d

x = Symbol('x')
y = Symbol('y')
z = Symbol('z')

print ('This will calculate the volume of a rotated funtion from y-values along the interval "a" to "b".')
print ('The function should be centered at the y-axis and have the lowest point at (0,0)')
print ('Remember: a should be less than b.')
#user input
a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))
if a > b:
    print('The calculated area will be negative')


num_of_Intervals = float(input('Input the number of intervals: '))
function = input("Input a function to rotate around the x axis: ")

volume_sum_type = input('Input "left", "middle", or "right" to calculate the type of Volume Approximation: ')

# Compute delta_x for the integration interval
delta_x = ((b-a)/num_of_Intervals)

# Begin Numerical Integration
def calculate_volume(volume_sum_type):
    # initialize
    n=0
    leftVol = 0.0
    rightArea = 0.0
    rightVol = 0.0
    trapezoidalsum = 0.0
    x = a #set x inputed by user to be the first interval

    if (volume_sum_type == 'left'):
        while n < abs(num_of_Intervals):
            #change in area = y-value of function * width of interval(y)
            #what to then rotate this around the x axis
            height_of_interval = eval(function)
            #radius = inverse_function(y)
            delta_V = ((height_of_interval)**2)*(math.pi)*delta_x #takes the radius, makes it a circle, multiply by delta_y to get a cylinder
            leftVol = leftVol + delta_V
            x = x + delta_x #increment to next interval
            n = n+1
        return leftVol
    elif (volume_sum_type == 'right'):
        x = x + delta_x #increment to next interval before first calculation to calculate outer volume
        while n < abs(num_of_Intervals):
            #change in area = x-value of function * height of interval(y)
            height_of_interval = eval(function)
            delta_V = ((height_of_interval)**2)*(math.pi)*delta_x #takes the radius, makes it a circle, multiply by delta_y to get a cylinder
            rightVol = rightVol + (delta_V)
            x = x + delta_x #increment to next interval
            n = n+1
        return rightVol
        print ("new test")
    elif (volume_sum_type == 'middle'):
          leftVol = calculate_volume('left')
          rightVol = calculate_volume('right')
          return (leftVol+rightVol)/2

plot3d(function, (x, -5,5), (y,-5,5))
print('The volume of the shape = ', calculate_volume(volume_sum_type))
print("new")
