from module import average


def test_average_of_two():
    assert average([10, 20]) == 15


def test_average_of_three():
    assert average([1, 2, 3]) == 2


def test_average_single_value():
    assert average([50]) == 50
