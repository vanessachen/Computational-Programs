import random as r

success_counter=0
total_counter=1000

for i in range(total_counter):
    xr= r.random()
    yr= r.random()
    yp=(1-xr**2)**(.5)
    if yr<=yp:
        success_counter=+1


print(success_counter/total_counter)
