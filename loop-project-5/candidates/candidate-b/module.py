def average(numbers):
    # BUG: off-by-one — divides by one more than the count of numbers
    return sum(numbers) / (len(numbers) + 1)
