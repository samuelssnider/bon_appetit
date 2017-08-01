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

  def test_we_add_to_cookbook_can_be_called
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    pan.add_to_cookbook(r1)
  end

  def test_add_to_cookbook_one_or_many
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    assert_equal 0, pan.cook_book.count

    pan.add_to_cookbook(r1)

    assert_equal 1, pan.cook_book.count

    pan.add_to_cookbook(r2)
    pan.add_to_cookbook(r3)

    assert_equal 3, pan.cook_book.count
  end

  def test_what_can_i_make_works_for_one_recipe
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    pan.add_to_cookbook(r1)

    pan.restock("Cheese", 20)
    pan.restock("Flour", 20)
    assert_equal ["Cheese Pizza"], pan.what_can_i_make
  end

  def test_what_can_i_make_works_for_multiple_recipes
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pan.add_to_cookbook(r1)
    pan.add_to_cookbook(r2)
    pan.add_to_cookbook(r3)

    pan.restock("Cheese", 10)
    pan.restock("Flour", 20)
    pan.restock("Brine", 40)
    pan.restock("Raw nuts", 20)
    pan.restock("Salt", 20)

    assert_equal ["Brine Shot", "Peanuts"], pan.what_can_i_make
  end

  def test_how_many_can_i_make_works_for_one_recipe
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 40)
    r1.add_ingredient("Flour", 40)

    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pan.add_to_cookbook(r1)
    pan.add_to_cookbook(r2)
    pan.add_to_cookbook(r3)

    pan.restock("Cheese", 20)
    pan.restock("Flour", 20)
    assert_equal Hash.new({"Cheese Pizza" => 2}), pan.how_many_can_i_make
  end

  def test_test_how_many_can_i_make_works_for_multiple_recipes
    pan = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pan.add_to_cookbook(r1)
    pan.add_to_cookbook(r2)
    pan.add_to_cookbook(r3)

    pan.restock("Cheese", 10)
    pan.restock("Flour", 20)
    pan.restock("Brine", 40)
    pan.restock("Raw nuts", 20)
    pan.restock("Salt", 20)
    
    hash = {"Brine Shot"=>4, "Peanuts"=>2}

    assert_equal hash, pan.how_many_can_i_make
  end

end
