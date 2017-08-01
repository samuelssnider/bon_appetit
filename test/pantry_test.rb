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

  def test_stock_can_be_checked
    pan = Pantry.new

    assert_equal 0, pan.stock_check("Cheese")
  end

  def test_restock_can_be_called
    pan = Pantry.new

    pan.restock("Cheese", 10)
  end

  def test_restock_working
    pan = Pantry.new

    assert_equal 0, pan.stock.count

    pan.restock("Cheese", 10)

    assert_equal 1 , pan.stock.count
    assert_equal 10, pan.stock_check("Cheese")
  end


end
