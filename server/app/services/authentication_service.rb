class AuthenticationService
  class << self
    def authenticate(headers)
      check_existence_of_user(decode_jwt(extract_jwt(headers))[:username])
    end

    private

    def extract_jwt(headers)
      raise(AuthenticationFailedError) if headers['Authorization'].blank?
      return headers['Authorization'].split(' ').last
    end

    def decode_jwt(jwt)
      return JwtService.decode(jwt, Rails.application.credentials.secret_key_base)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      raise(AuthenticationFailedError)
    end

    def check_existence_of_user(username)
      User.find_by(username: username)
    rescue Mongoid::Errors::DocumentNotFound
      raise(AuthenticationFailedError)
    end
  end
end
