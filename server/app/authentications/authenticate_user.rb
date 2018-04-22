class AuthenticateUser
  prepend SimpleCommand

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    JwtService.encode(user_id: user.id) if user
  end

  private

  def user
    user = User.find_by!(username: @username)
    return user if user&.authenticate(@password)

    errors.add(:user_authentication, 'Invalid Credentials')
    return nil
  end
end
