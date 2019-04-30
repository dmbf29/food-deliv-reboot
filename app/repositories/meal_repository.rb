require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def add(meal) # an instance of meal!
    # hash_name[key] = new_value
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i # reassigning a value
      row[:price] = row[:price].to_i # reassigning a value
      @meals << Meal.new(row)
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << @meals.first.class.headers
      csv << ['id', 'name', 'price']
      @meals.each do |meal|
        # csv << meal.build_row
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end






