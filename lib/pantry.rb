class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
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

  def convert_unit(quantity)
    if quantity < 1.0
      unit = "Milli-Units"
      quantity *= 1000.0
    elsif quantity >= 1.0 && quantity <= 100.0
      unit = "Universal Units"
    else
      unit = "Centi-Units"
      quantity /= 100.0
    end
    {quantity: quantity, units: unit}
  end


end
