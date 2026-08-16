def is_valid_age(age):
    """Return True if age is a sane human age, False for None or out-of-range."""
    if age is None:
        return False
    return 0 <= age <= 120


def get_discount_tier(purchase_count):
    """Map a customer's purchase count to a discount tier."""
    if purchase_count is None:
        return "none"
    if purchase_count >= 10:
        return "gold"
    if purchase_count >= 5:
        return "silver"
    return "bronze"
