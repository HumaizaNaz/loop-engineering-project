def dedupe(items):
    # BUG: set() does not preserve the original order
    return list(set(items))
