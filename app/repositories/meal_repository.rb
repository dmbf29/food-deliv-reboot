require 'csv'
require_relative '../models/meal'
require_relative 'base_repository'

class MealRepository < BaseRepository

  def build_element(row)
    row[:id] = row[:id].to_i # reassigning a value
    row[:price] = row[:price].to_i # reassigning a value
    Meal.new(row)
  end
end






