class JwtService
  class << self
    def encode(payload)
      if Rails.configuration.jwt[:time_to_live] != 0
        payload[:exp] = Rails.configuration.jwt[:time_to_live].seconds.from_now
      end
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError, JWT::ExpiredSignature
      raise(AuthenticationFailedError)
    end
  end
end
