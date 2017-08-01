require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_can_be_created
    pan = Pantry.new
    assert_instance_of Pantry, pan
    assert pan
  end

  def test_stock_can_be_got
    pan = Pantry.new
    assert pan.stock.empty?
  end

end
