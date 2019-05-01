class SessionsView
  def ask_for_(thing)
    puts "#{thing}?"
    gets.chomp
  end

  def success_sign_in
    puts "You are now signed in!"
  end

  def fail_sign_in
    puts "Wrong credentials"
  end
end
