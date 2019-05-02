require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def find_by_username(username)
    @employees.find do |employee|
      username == employee.username
    end
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def all_delivery_guys
    @employees.select do |employee|
      employee.delivery_guy?
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i # reassigning a value
      @employees << Employee.new(row)
    end
    @next_id = @employees.empty? ? 1 : @employees.last.id + 1
  end
end
