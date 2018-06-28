class JsonParseErrorHandler
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue ActionDispatch::Http::Parameters::ParseError
    return [
      400, { 'Content-Type' => 'application/json' },
      [{ error: 'bad request', message: 'Query JSON cannot be parsed.' }.to_json]
    ]
  end
end
