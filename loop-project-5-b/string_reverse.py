def reverse_string(s):
    # BUG: off-by-one slice — drops the last character
    return s[-2::-1]
