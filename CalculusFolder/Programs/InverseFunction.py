from pynverse import inversefunc

function_str = input('Input a function: ')
#the function string is no longer a string
function = (lambda x: eval(function_str)) #lamba lists the args of the function, followed by the function
inverse_function = inversefunc(function) #inverse_function is a function that can evaluate the inverse given an x value

print (inverse_function)
print (str(inverse_function))

answer = inverse_function(float(input("input an x value : ")))

print("Answer is: {}" .format(answer))



#print(answer)
