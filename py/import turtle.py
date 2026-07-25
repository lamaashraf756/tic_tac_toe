import turtle
import math 
import random
import time

screen = turtle.Screen()
screen.title("Heart/project no.12")
screen.bgcolor("black")
screen.setup(width=800, height=800)
screen.tracer(0)

t = turtle.Turtle()
t.hideturtle()
t.speed(0)
t.pensize(2)

def heart_x(t_val):
    return 16*math.sin(t_val)**3
def heart_y(t_val):
    return(13*math.cos(t_val))
