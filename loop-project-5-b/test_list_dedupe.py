from list_dedupe import dedupe


def test_preserves_order():
    assert dedupe([3, 1, 2, 1, 3]) == [3, 1, 2]


def test_no_duplicates_unchanged():
    assert dedupe([1, 2, 3]) == [1, 2, 3]
