class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.sign_in
      while @employee # is signed in
        if @employee.role == 'manager'
          # if manager, show manager menu
          choice = display_manager_menu
          manager_action(choice)
        else
          # otherwise show delivery guy menu
          choice = display_delivery_menu
          delivery_action(choice)
        end
      end
      print `clear`
    end
  end

  private

  def display_manager_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all meals"
    puts "2 - Add a meal"
    puts "3 - List all customers"
    puts "4 - Add a customer"
    puts "5 - List undelivered orders"
    puts "6 - Create an order"
    puts "8 - Sign out"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def display_delivery_menu
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List my undelivered orders"
    puts "2 - Mark order as delivered"
    puts "8 - Sign out"
    puts "9 - Quit"
    print "> "
    gets.chomp.to_i
  end

  def manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.create
    when 8 then @employee = nil
    when 9
      @employee = nil
      @running = false
    else
      puts "Try again..."
    end
  end

  def delivery_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 8 then @employee = nil
    when 9
      @employee = nil
      @running = false
    else
      puts "Try again..."
    end
  end
end
