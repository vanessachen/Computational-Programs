import random as r
import math as m

# Number of points that land inside.
inside_points = 0
# Total number of darts to throw.
total_points = 100000
#function_str = "(1-x**2)**(0.5)"
print("Try (1-x**2)**(0.5) for approximating 1/4 of pi")
#a = float(input('Input a starting value: '));
#b = float(input('Input an ending value: '));
function_str = input('Input a function: ')
function = (lambda x: eval(function_str))

# Iterate for the number of darts.
for i in range(0, total_points):
  # Generate random x, y in [0, 1].
  x2 = r.random()
  y2 = r.random()
  # Increment counter if inside unit circle.
  if (y2<=function(x2)):
      inside_points+=1
  #if m.sqrt(1-(x**2)) < 1.0:
      #inside_points +=1
    #if m.sqrt(x2 + y2) < 1.0:
      #inside_points += 1

# inside / total = pi / 4
probability = (float(inside_points) / total_points)
pi = probability*4


print("This is the approximation of points inside the function from an interval of [0,1]: {}".format(probability))
print("If you chose the function to approximate pi along [0,1]: {}".format(pi))
