class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    logger.error("#{exception.class.name} :: #{exception}")
    render_error(:internal_server_error, 'Internal server error occurred, this request has been logged.')
  end

  rescue_from EntityNotFoundError do |exception|
    render_error(:not_found, exception.message)
  end

  rescue_from InvalidDataError do |exception|
    render_error(:bad_request, exception.message)
  end

  rescue_from AuthenticationFailedError do |_exception|
    render_error(:unauthorized)
  end

  rescue_from ActionDispatch::Http::Parameters::ParseError do
    render_error(:bad_request, 'JSON cannot be parsed.')
  end

  protected

  def render_error(error, message = '')
    @error = error.to_s.tr('_', ' ')
    @message = message
    render(:error, status: error)
  end
end
