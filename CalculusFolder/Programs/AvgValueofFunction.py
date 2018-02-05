from sympy import *

x = Symbol('x')

a = float(input('Input the starting value: '))
b = float(input('Input the ending value: '))

function = input("Input a function: ")

integral = integrate(function)

#want avg = (integral of f(x) from a to b)/b-a
#remember : integral of f(x) from a to b = f(b) - f(a)
f_b = integral.subs(x,b)
f_a = integral.subs(x,a)

avg_value = (f_b-f_a)/(abs(b-a))

print ("This is the arclength of the function along that interval: {}".format(arclength))








#testing to figure out how the sympy pow object works
#print(type(integral))

#test = ((lambda x: eval(integral_str)))
#print(test)

#print(integral.subs(x,b))
#b=x
#print(eval(test(b)))
#- (lambda a: eval(integral))

#avg_value = dy_of_integral/(abs(b-a))

#print("This is the average value: {}".format(avg_value))
