from validator import is_valid_age, get_discount_tier


def test_none_age_is_invalid():
    assert is_valid_age(None) is False


def test_normal_age_is_valid():
    assert is_valid_age(30) is True


def test_negative_age_is_invalid():
    assert is_valid_age(-1) is False


def test_gold_tier():
    assert get_discount_tier(10) == "gold"


def test_bronze_tier():
    assert get_discount_tier(1) == "bronze"
