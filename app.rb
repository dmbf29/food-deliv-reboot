require_relative './app/repositories/meal_repository'
require_relative './app/controllers/meals_controller'
require_relative './app/repositories/customer_repository'
require_relative './app/repositories/employee_repository'
require_relative './app/repositories/order_repository'
require_relative './app/controllers/customers_controller'
require_relative './app/controllers/sessions_controller'
require_relative './app/controllers/orders_controller'
require_relative 'router'

meals_csv_file = File.join(__dir__, '/data/meals.csv')
meals_repo = MealRepository.new(meals_csv_file)
meals_controller = MealsController.new(meals_repo)

customers_csv_file = File.join(__dir__, '/data/customers.csv')
customers_repo = CustomerRepository.new(customers_csv_file)
customers_controller = CustomersController.new(customers_repo)

employees_csv_file = File.join(__dir__, '/data/employees.csv')
employee_repository = EmployeeRepository.new(employees_csv_file)
sessions_controller = SessionsController.new(employee_repository)

orders_csv_file = File.join(__dir__, '/data/orders.csv')
order_repo = OrderRepository.new(orders_csv_file, meals_repo, employee_repository, customers_repo)
orders_controller = OrdersController.new(meals_repo, employee_repository, customers_repo, order_repo)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)

router.run
