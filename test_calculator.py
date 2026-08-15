from calculator import add, multiply, subtract


def test_add():
    assert add(2, 3) == 5


def test_multiply():
    assert multiply(4, 5) == 20


def test_subtract():
    assert subtract(10, 3) == 7


if __name__ == "__main__":
    import sys

    tests = [test_add, test_multiply, test_subtract]
    for test in tests:
        try:
            test()
        except AssertionError:
            print(f"FAILED: {test.__name__}")
            sys.exit(1)

    print("ALL TESTS PASSED")
    sys.exit(0)
