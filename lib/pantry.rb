require 'pry'
class Pantry
  attr_reader :stock,
              :cook_book

  def initialize
    @stock = {}
    @cook_book = []
  end

  def stock_check(ingredient)
   if @stock[ingredient]
     @stock[ingredient]
   else
     0
   end
  end

  def restock(ingredient, quantity)
    unless @stock[ingredient]
      @stock.merge!(ingredient => quantity)
    else
      @stock[ingredient] += quantity
    end
  end

  def convert_units(recipe)
    converted_ingreditent_units = Hash.new(0)
    recipe.ingredients.each do |ingredient|
      converted_ingreditent_units.merge!(ingredient[0] => convert_unit(ingredient[1]))
    end
    converted_ingreditent_units
  end

  def convert_unit(quantity, array = [])
    leftover = 0
    if quantity < 1.0
      unit = "Milli-Units"
      quantity *= 1000.0
    elsif quantity >= 1.0 && quantity <= 100.0
      unit = "Universal Units"
    else
      unit = "Centi-Units"
      leftover = quantity % 100
      quantity /= 100
    end
    split = (quantity % 1.0).round(4)
    if split == 0 && leftover ==0
      array << {quantity: quantity, units: unit}
    else
      unless unit == "Centi-Units"
        array << {quantity: quantity.to_i, units: unit}
        convert_unit(split, array)
      else
        array << {quantity: quantity.to_i, units: unit}
        convert_unit(leftover, array)
      end
    end
    array
  end

  def add_to_cookbook(recipe)
    @cook_book << recipe
  end

  def what_can_i_make
    can_make.map {|makeable| makeable.name}
  end

  def can_make
    @cook_book.find_all do |recipe|
      recipe.ingredients.all? do |ingredient|
        stock[ingredient[0]] >= recipe.amount_required(ingredient[0]) if stock[ingredient[0]]
      end
    end
  end

  def how_many_can_i_make
    recipes = can_make
    how_many = Hash.new
    recipes.each do |recipie|
      most = recipie.ingredients.map do |ingredient|
        mosts = @stock[ingredient[0]] / recipie.amount_required(ingredient[0]) if @stock[ingredient[0]]
      end
      how_many.merge!(recipie.name => most.min_by {|most| most})
    end
    how_many
  end



end
