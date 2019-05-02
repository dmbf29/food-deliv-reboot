require_relative '../views/orders_view'
require_relative '../views/meals_view'

class OrdersController
  def initialize(meal_repo, employee_repo, customer_repo, order_repo)
    @order_repo = order_repo
    @meal_repo = meal_repo
    @employee_repo = employee_repo
    @customer_repo = customer_repo
    @orders_view = OrdersView.new
  end

  def list_undelivered_orders
    # ask order rep for orders -> undelivered
    orders = @order_repo.undelivered_orders
    # tell the view to display the orders
    @orders_view.display(orders)
  end

  def create
    # need meal, customer, employee
    # display meals
    MealsView.new.display(@meal_repo.all)
    meal_id = @orders_view.ask_for_("meal number").to_i
    CustomersView.new.display(@customer_repo.all)
    customer_id = @orders_view.ask_for_("customer number").to_i
    @orders_view.display_employees(@employee_repo.all_delivery_guys)
    employee_id = @orders_view.ask_for_("employee number").to_i
    meal = @meal_repo.find(meal_id)
    customer = @customer_repo.find(customer_id)
    employee = @employee_repo.find(employee_id)

    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repo.add(order)
  end

  def list_my_orders(employee)
    orders =
      @order_repo.undelivered_orders.select do |order|
        order.employee == employee
      end
    # tell the view to display the orders
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    list_my_orders(employee)
    order_id = @orders_view.ask_for_("order number").to_i
    order = @order_repo.find(order_id)
    order.deliver!
    @order_repo.save_to_csv
  end
end










