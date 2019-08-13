from math import log, ceil

def is_armstrong(number):
    working = number
    sum = 0
    digits = ceil(log(number, 10))

    while working > 0:
        sum += (working % 10) ** digits
        working = working // 10

    return sum == number
