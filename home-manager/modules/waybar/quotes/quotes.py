#!/usr/bin/env python3
import random
import os

def random_line(file):
    lines = file.read().splitlines()
    myline = random.choice(lines)
    return myline

def get_random_file():
   pass

if __name__ == "__main__":
    try:
        f = open("../rumi.txt")
        print("success")
    except Exception as e:
        print("failed", e)
