# Calcuate the volume of a shape when rotating a function around the y-axis along the interval 'a' to 'b'
from pynverse import inversefunc
import math

correct_format = True;

print ('This will calculate the volume of a rotated funtion from y-values along the interval "a" to "b".')
print ('The function should be centered at the y-axis and have the lowest point at (0,0)')
print ('Remember: a should be less than b.')
#user input
a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))
if a > b:
    print('The calculated area will be negative')

if (correct_format == True):
    num_of_Intervals = float(input('Input the number of intervals: '))
    function_str = input('Input a function: ')
    #need to calculate the inverse of the function, because we are evaluating the x-value at every y interval along the fxn
    function = (lambda x: eval(function_str)) #lamba lists the args of the function, followed by the function
    inverse_function = inversefunc(function) #inverse_function is a function that can evaluate the inverse given an x value
    print("This is the inverse function: {}".format(inverse_function))
    volume_sum_type = input('Input "left", "middle", or "right" to calculate the type of Volume Approximation: ')

# Compute delta_y for the integration interval
delta_y = ((b-a)/num_of_Intervals)

# Begin Numerical Integration
def calculate_volume(volume_sum_type):
    # initialize
    n=0
    leftVol = 0.0
    rightArea = 0.0
    rightVol = 0.0
    trapezoidalsum = 0.0
    y = a #set y inputed by user to be the first interval

    if (volume_sum_type == 'left'):
        while n < abs(num_of_Intervals):
            #change in area = x-value of function * height of interval(y)
            radius = inverse_function(y)
            delta_V = ((radius)**2)*(math.pi)*delta_y #takes the radius, makes it a circle, multiply by delta_y to get a cylinder
            leftVol = leftVol + delta_V
            y = y + delta_y #increment to next interval
            n = n+1
        return leftVol
    elif (volume_sum_type == 'right'):
        y = y + delta_y #increment to next interval before first calculation to calculate outer volume
        while n < abs(num_of_Intervals):
            #change in area = x-value of function * height of interval(y)
            radius = inverse_function(y)
            delta_V = ((radius)**2)*(math.pi)*(delta_y) #takes the radius, makes it a circle, multiply by delta_y to get a cylinder
            rightVol = rightVol + (delta_V)
            y = y + delta_y #increment to next interval
            n = n+1
        return rightVol
        print ("new test")
    elif (volume_sum_type == 'middle'):
          leftVol = calculate_volume('left')
          rightVol = calculate_volume('right')
          return (leftVol+rightVol)/2


print('The volume of the shape = ', calculate_volume(volume_sum_type))
print("new")
