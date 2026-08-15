import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from inventory import apply_discount


def test_discount_reduces_price():
    assert apply_discount(100, 10) == 90


def test_zero_discount_is_unchanged():
    assert apply_discount(50, 0) == 50


def test_discount_scales_with_price():
    assert apply_discount(200, 25) == 150
