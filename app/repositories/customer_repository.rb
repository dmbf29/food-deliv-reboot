require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def add(customer) # an instance of customer!
    # hash_name[key] = new_value
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_to_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i # reassigning a value
      @customers << Customer.new(row)
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << @customers.first.class.headers
      csv << ['id', 'name', 'address']
      @customers.each do |customer|
        # csv << customer.build_row
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end






