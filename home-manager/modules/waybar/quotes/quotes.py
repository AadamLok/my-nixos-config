#!/usr/bin/env python3
import random
import os
import sys

def random_line(file):
    lines = file.read().splitlines()
    return random.choice(lines)

def get_random_file():
   files = ['rumi.txt', 'programming.txt']
   return random.choice(files)

if __name__ == "__main__":
    os.chdir(sys.argv[1])
    try:
        f = open(get_random_file())
        print(random_line(f))
    except Exception as e:
        print("Failed with error: ", e)
