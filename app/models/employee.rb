class Employee
  attr_reader :username, :password, :id, :role

  def initialize(attributes ={})
    @id = attributes[:id] # integer
    @username = attributes[:username] # string
    @password = attributes[:password] # string
    @role = attributes[:role] #string
  end

  def delivery_guy?
    @role == "delivery_guy"
  end

  def manager?
    @role == "manager"
  end
end
