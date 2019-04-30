class CustomersView
  def display(customers) # an array of instances
    customers.each do |customer|
      puts "#{customer.id} | #{customer.name}\n#{customer.address}"
    end
  end

  def ask_for_(thing)
    puts "#{thing}?"
    gets.chomp
  end
end
