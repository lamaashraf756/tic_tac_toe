import math
from turtle import *

helpers = Screen()
helpers.setup(width=700, height=700)
bgcolor("black")
speed(0)         
delay(0)         
hideturtle()
tracer(2, 0)     

def heart_a(n):
    return 15 * math.sin(n) ** 3

def heart_b(n):
    return 12 * math.cos(n) - 5 * math.cos(2*n) - 2 * math.cos(3*n) - math.cos(4*n)

for i in range(1, 750):
    penup()
    goto(0, 0)
    pendown()
    
    if i % 2 == 0:
        color('#ff2a7f')  
    else:
        color('#e6005c')  
        
    
    goto(heart_a(i) * 18, heart_b(i) * 18)

done()


