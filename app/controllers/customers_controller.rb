require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list # index
    customers = @customer_repository.all
    @customers_view.display(customers)
  end

  def add
    name = @customers_view.ask_for_("name")
    address = @customers_view.ask_for_("address")
    customer = Customer.new(name: name, address: address)
    @customer_repository.add(customer)
  end
end
