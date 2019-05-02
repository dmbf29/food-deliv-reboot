  class OrdersView
  def display(orders) # an array of INSTANCES
    orders.each do |order|
      puts "#{order.id}.) #{order.customer.name} | #{order.meal.name}\n Delivery guy: #{order.employee.username}"
    end
  end

  def ask_for_(thing)
    puts "#{thing}?"
    gets.chomp
  end

  def display_employees(employees)
    employees.each do |employee|
      puts "#{employee.id} - #{employee.username}"
    end
  end
end
