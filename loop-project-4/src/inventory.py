def apply_discount(price, discount_percent):
    """Return the price after applying a percent discount."""
    # BUG: adds the discount instead of subtracting it
    return price + (price * discount_percent / 100)
