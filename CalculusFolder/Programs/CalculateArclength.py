from sympy import *

x = Symbol('x')

a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))

function = input("Input a function: ")

derivative =  diff(function, x, 1)

#want arclength = (integral of square toot of 1 + (f'(x))^2 from a to b)) * dx
#remember : this equates to square toot of 1 + (f'(x))^2 from at b - this expression at a
#defining f'(b) and f'(a)
fprime_b = derivative.subs(x,b)
fprime_a = derivative.subs(x,a)

#g(x) = sqrt(1+(f'(x)^2)) * dx
#now want g(b) - g(a)
g_b = ((fprime_b)**2 + 1)**(.5)
g_a = ((fprime_a)**2 + 1)**(.5)

arclength= (g_b-g_a)

print ("This is the arclength of the function along that interval: {}".format(arclength))
