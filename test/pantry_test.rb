require './lib/pantry'
require './lib/recipe'
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

  def test_restock_working_with_ingredient_already_in_stock
    pan = Pantry.new

    pan.restock("Cheese", 10)
    pan.restock("Cheese", 20)

    assert_equal 30, pan.stock_check("Cheese")

    pan.restock("Cheese", 40)

    assert_equal 70, pan.stock_check("Cheese")
  end

  def test_convert_units
    pan = Pantry.new
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    hash = {"Cayenne Pepper" => {quantity: 25, units: "Milli-Units"    },
            "Cheese"         => {quantity: 75, units: "Universal Units"},
            "Flour"          => {quantity: 5, units: "Centi-Units"     } }

    assert_equal hash, pan.convert_units(r)
  end


end
