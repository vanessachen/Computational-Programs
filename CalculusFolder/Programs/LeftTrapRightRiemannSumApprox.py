# Calcuate the area under a curve for any function from a to b with Riemann Sum Approximation

correct_format = True;

print ('This will calculate the area under a curve of a function from "a" to "b".')
print ('Remember: a should be less than b.')
#user input
a = float(input('Input the starting value: '))
b = float (input('Input the ending value: '))
if a > b:
    print('The calculated area will be negative')

if (correct_format == True):
    num_of_Intervals = float(input('Input the number of intervals: '))
    function = input('Input a function: ')
    riemann_sum_type = input('Input "left", "trapezoidal", or "right" to calculate the type of Riemann Sum Approximation: ')
    #if ((riemann_sum_type != 'left') or (riemann_sum_type != 'right') or (riemann_sum_type != 'trapezoidal')):
        #correct_format = False
        #print ('Please enter either "left" "right" or "trapezoidal"')
        #correct_format = True
        #riemann_sum_type = input('Input left, trapezoidal, or right to calculate the type of Riemann Sum Approximation: ')

# Compute delta_x for the integration interval
delta_x = ((b-a)/num_of_Intervals)

# Begin Numerical Integration
def riemann_Sum(riemann_sum_type):
    # initialize
    n=0
    leftsum= 0.0
    rightsum = 0.0
    trapezoidalsum = 0.0
    x = a #set x to start at the left interval

    if (riemann_sum_type == 'left'):
        while n < abs(num_of_Intervals):
            #change in area = y-value of function * width of interval
            delta_A = eval(function) * delta_x
            x = x + delta_x #increment to the next x-interval
            leftsum = leftsum + delta_A #add to the sum
            n = n+1
        return leftsum
    elif (riemann_sum_type == 'right'):
        #n=1
        x = x + delta_x #incrementing x before the first evaluation to shift by 1 interval to calculate right approx
        while n < abs(num_of_Intervals):
            delta_A = eval(function) * delta_x
            x = x + delta_x
            rightsum = rightsum + delta_A
            n = n+1
        return rightsum
    elif (riemann_sum_type == 'trapezoidal'):
        leftsum = riemann_Sum('left')
        rightsum = riemann_Sum('right')
        return (leftsum+rightsum)/2 #the trapezoidal sum is the average of leftsum and rightsum

print('Area Under the Curve = ', riemann_Sum(riemann_sum_type))
