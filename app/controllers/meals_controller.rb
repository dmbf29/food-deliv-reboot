require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list # index
    meals = @meal_repository.all
    @meals_view.display(meals)
  end

  def add
    name = @meals_view.ask_for_("name")
    price = @meals_view.ask_for_("price").to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.add(meal)
  end
end
