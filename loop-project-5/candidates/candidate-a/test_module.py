from module import is_even


def test_four_is_even():
    assert is_even(4) is True


def test_seven_is_not_even():
    assert is_even(7) is False


def test_zero_is_even():
    assert is_even(0) is True
