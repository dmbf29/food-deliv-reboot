class MealsView
  def display(meals) # an array of instances
    meals.each do |meal|
      puts "#{meal.id} | ($#{meal.price}) #{meal.name}"
    end
  end

  def ask_for_(thing)
    puts "#{thing}?"
    gets.chomp
  end
end
