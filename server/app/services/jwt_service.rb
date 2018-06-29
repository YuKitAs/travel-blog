class JwtService
  class << self
    def encode(payload)
      time_to_live = Rails.configuration.jwt['time_to_live']
      if time_to_live != 0
        payload[:exp] = time_to_live.seconds.from_now.to_i
      end
      return JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      return HashWithIndifferentAccess.new(body)
    end
  end
end
