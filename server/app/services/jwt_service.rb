class JwtService
  class << self
    def encode(payload, key)
      time_to_live = Rails.configuration.jwt['time_to_live']
      if time_to_live != 0
        payload[:exp] = time_to_live.seconds.from_now.to_i
      end
      return JWT.encode(payload, key)
    end

    def decode(token, key)
      body = JWT.decode(token, key)[0]
      return HashWithIndifferentAccess.new(body)
    end
  end
end
