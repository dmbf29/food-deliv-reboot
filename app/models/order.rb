class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # instance
    @customer = attributes[:customer] # instance
    @employee = attributes[:employee] # instance
    @delivered = attributes[:delivered] # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
