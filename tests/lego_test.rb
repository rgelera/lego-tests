require 'minitest/autorun'
require_relative '../lego'

class TestLego < Minitest::Test
  def test_is_strong_left_light_right_heavy 
    left_item = LegoItem.new("left item light", 5)
    right_item = LegoItem.new("right item heavy", 15)
    minifigure = LegoMinifigure.new("name", nil, left_item, right_item)
    assert(minifigure.is_strong?)
  end

  def test_is_strong_left_heavy_right_light
    left_item = LegoItem.new("left item heavy", 15)
    right_item = LegoItem.new("right item light", 5)
    minifigure = LegoMinifigure.new("name", nil, left_item, right_item)
    assert(minifigure.is_strong?)
  end

  def test_is_strong_left_light
    left_item = LegoItem.new("left item light", 5)
    minifigure = LegoMinifigure.new("name", nil, left_item)
    assert(!minifigure.is_strong?)
  end

  def test_is_strong_left_heavy
    left_item = LegoItem.new("left item heavy", 15)
    minifigure = LegoMinifigure.new("name", nil, left_item)
    assert(minifigure.is_strong?)
  end

  def test_is_strong_right_heavy
    right_item = LegoItem.new("right item heavy", 15)
    minifigure = LegoMinifigure.new("name", nil, nil, right_item)
    assert(minifigure.is_strong?)
  end

  def test_is_strong_both_light
    left_item = LegoItem.new("left item light", 5)
    right_item = LegoItem.new("right item light", 5)
    minifigure = LegoMinifigure.new("name", nil, left_item, right_item)
    refute(minifigure.is_strong?)
  end

  def test_swapping_items
    left_item = LegoItem.new("left item heavy", 25)
    right_item = LegoItem.new("right item light", 5)
    minifigure = LegoMinifigure.new("name", nil, left_item, right_item)
    minifigure = minifigure.swap_hands
    assert_equal(left_item, minifigure.right_item)
    assert_equal(right_item, minifigure.left_item)
  end

  def test_swapping_one_item
    left_item = LegoItem.new("left item heavy", 25)
    minifigure = LegoMinifigure.new("name", nil, left_item)
    minifigure = minifigure.swap_hands
    assert_equal(left_item, minifigure.right_item)
  end

  def test_place_in_left
    left_item = LegoItem.new("left item heavy", 25)
    minifigure = LegoMinifigure.new("name")
    minifigure.place_in_left_hand(left_item)
    assert_equal(left_item, minifigure.left_item)
  end

  def test_place_in_left_not_an_item
    minifigure = LegoMinifigure.new("name")
    minifigure.place_in_left_hand("Not an item!")
    assert_equal(nil, minifigure.left_hand)
  end

  def test_is_stylish_green_hat
    hat = LegoHat.new("small", "green", "cap")
    minifigure = LegoMinifigure.new("name", hat)
    refute(minifigure.is_stylish?)
  end

  def test_is_stylish_blue_hat
    hat = LegoHat.new("small", "blue", "cap")
    minifigure = LegoMinifigure.new("name", hat)
    assert(minifigure.is_stylish?)
  end

  def test_is_stylish_no_hat
    minifigure = LegoMinifigure.new("name")
    refute(minifigure.is_stylish?)
  end

  def test_wear_hat
    hat = LegoHat.new("small", "blue", "cap")
    minifigure = LegoMinifigure.new("name")
    minifigure.wear_hat(hat)
    assert_equal(hat, minifigure.hat)
  end

  def test_replace_hat
    hat = LegoHat.new("small", "blue", "cap")
    hat2 = LegoHat.new("small", "green", "cap")
    minifigure = LegoMinifigure.new("name", hat)
    minifigure.wear_hat(hat2)
    assert_equal(hat2, minifigure.hat)
  end

  def test_hat_words
    hat = LegoHat.new("small", "blue", "cap")
    minifigure = LegoMinifigure.new("name", hat)
    assert_equal(", who is wearing a small blue cap", minifigure.hat_words)
  end

  def test_hat_words_no_hat
    minifigure = LegoMinifigure.new("name")
    assert_equal("", minifigure.hat_words)
  end
end