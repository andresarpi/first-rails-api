class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end

#My version. Does the same thing, the one above is refractored, the one below
#shows the details of the implementation.
=begin
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end
  
  def call 
    @user = User.find_by(email: email)
    if (@user && @user.authenticate(password))
      return JsonWebToken.encode(user_id: @user.id)
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end
  
  private
  attr_reader :email, :password
end
=end



