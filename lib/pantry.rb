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
    end
  end


end
