module AuthenticationMacros
  def login(user)
    cookies[:auth_token] = user.auth_token
  end

  def logout
    cookies[:auth_token] = nil
  end
end
