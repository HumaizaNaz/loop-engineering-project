from module import reverse_words


def test_two_words():
    assert reverse_words("hello world") == "world hello"


def test_three_words():
    assert reverse_words("the quick fox") == "fox quick the"


def test_single_word_unchanged():
    assert reverse_words("hello") == "hello"
