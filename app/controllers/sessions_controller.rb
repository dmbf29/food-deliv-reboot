require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # tell view to ask for username
    username = @sessions_view.ask_for_("username")
    # tell view to ask for password
    password = @sessions_view.ask_for_("password")
    # @ask employees repo for the employee w/username
    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      @sessions_view.success_sign_in
      return employee
    else
      @sessions_view.fail_sign_in
      sign_in # recursive
    end
  end
end
