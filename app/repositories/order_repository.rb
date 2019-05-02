require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repo, employee_repo, customer_repo)
    @csv_file_path = csv_file_path
    @meal_repo  = meal_repo
    @employee_repo = employee_repo
    @customer_repo = customer_repo
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_to_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def find(id)
    @orders.find { |order| order.id == id }
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row| # row is a hash
      order =
        Order.new(
          id: row[:id].to_i,
          meal: @meal_repo.find(row[:meal_id].to_i),
          customer: @customer_repo.find(row[:customer_id].to_i),
          employee: @employee_repo.find(row[:employee_id].to_i),
          delivered: row[:delivered] == 'true'
        )
      @orders << order
    end
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end


end








